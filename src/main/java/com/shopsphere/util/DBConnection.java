package com.shopsphere.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * Thread-safe singleton Database Connection Manager for the ShopSphere application.
 * <p>
 * Responsible for loading JDBC credentials from {@code db.properties} on the classpath,
 * registering the MySQL JDBC Driver, and managing active database connections and resource
 * deallocation.
 * </p>
 */
public final class DBConnection {

    private static final String CONFIG_FILE = "db.properties";
    private static final Properties PROPERTIES = new Properties();

    private static volatile DBConnection instance;

    private static String dbDriver;
    private static String dbUrl;
    private static String dbUsername;
    private static String dbPassword;

    static {
        loadConfiguration();
        registerDriver();
    }

    /**
     * Private constructor to enforce singleton design pattern.
     */
    private DBConnection() {
        // Initialization handled in static block
    }

    /**
     * Retrieves the singleton instance of {@code DBConnection}.
     *
     * @return singleton {@link DBConnection} instance
     */
    public static DBConnection getInstance() {
        if (instance == null) {
            synchronized (DBConnection.class) {
                if (instance == null) {
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    /**
     * Loads database configuration properties from the classpath.
     */
    private static void loadConfiguration() {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
            if (input == null) {
                System.err.println("[DBConnection] ERROR: Configuration file '" + CONFIG_FILE + "' not found on classpath.");
                // Provide fallback defaults if properties file is missing
                dbDriver = "com.mysql.cj.jdbc.Driver";
                dbUrl = "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
                dbUsername = "root";
                dbPassword = "";
                return;
            }

            PROPERTIES.load(input);
            dbDriver = PROPERTIES.getProperty("db.driver", "com.mysql.cj.jdbc.Driver").trim();
            dbUrl = PROPERTIES.getProperty("db.url", "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8").trim();
            dbUsername = PROPERTIES.getProperty("db.username", "root").trim();
            dbPassword = PROPERTIES.getProperty("db.password", "").trim();

        } catch (IOException e) {
            System.err.println("[DBConnection] ERROR loading " + CONFIG_FILE + ": " + e.getMessage());
            e.printStackTrace(System.err);
        }
    }

    /**
     * Explicitly loads and registers the MySQL JDBC driver.
     */
    private static void registerDriver() {
        try {
            if (dbDriver == null || dbDriver.isEmpty()) {
                dbDriver = "com.mysql.cj.jdbc.Driver";
            }
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            System.err.println("[DBConnection] ERROR: JDBC Driver class not found: " + dbDriver);
            e.printStackTrace(System.err);
        }
    }

    /**
     * Obtains a new database connection from the {@link DriverManager}.
     *
     * @return active {@link Connection} to the database
     * @throws SQLException if a database access error occurs or URL is invalid
     */
    public static Connection getConnection() throws SQLException {
        if (dbUrl == null || dbUrl.isEmpty()) {
            throw new SQLException("Database URL is unconfigured or null. Ensure db.properties is present.");
        }
        return DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
    }

    /**
     * Closes the provided database resources safely, suppressing any {@link SQLException}
     * while logging to standard error.
     *
     * @param conn the database connection to close, may be null
     * @param stmt the statement to close, may be null
     * @param rs   the result set to close, may be null
     */
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println("[DBConnection] Warning closing ResultSet: " + e.getMessage());
            }
        }

        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                System.err.println("[DBConnection] Warning closing Statement: " + e.getMessage());
            }
        }

        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.err.println("[DBConnection] Warning closing Connection: " + e.getMessage());
            }
        }
    }

    /**
     * Overloaded helper to close Statement and ResultSet.
     *
     * @param stmt the statement to close
     * @param rs   the result set to close
     */
    public static void close(Statement stmt, ResultSet rs) {
        close(null, stmt, rs);
    }

    /**
     * Overloaded helper to close Connection and Statement.
     *
     * @param conn the connection to close
     * @param stmt the statement to close
     */
    public static void close(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }
}
