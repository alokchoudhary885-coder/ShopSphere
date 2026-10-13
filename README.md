# ShopSphere — Advanced Java Enterprise E-Commerce Management System

> RTU Advanced Java / Java Enterprise Lab Project

![Java](https://img.shields.io/badge/Java-21_LTS-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Jakarta EE](https://img.shields.io/badge/Jakarta_EE_10-Servlet_6.1-1572B6?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-8.4-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache_Tomcat-11-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Maven-3.9.9-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

## About

ShopSphere is a full-featured e-commerce web application built with Java Enterprise technologies. It demonstrates practical use of Advanced Java concepts including Servlets, JSP, JDBC, MVC architecture, Swing, Socket Programming, RMI, Serialization, Internationalization, and more.

## Tech Stack

| Technology | Purpose |
|---|---|
| Java 21 LTS | Backend programming |
| Jakarta Servlets 6.1 | HTTP request handling |
| JSP + JSTL 3.0 + EL | Dynamic frontend pages |
| JDBC + MySQL 8.4 | Database connectivity |
| Apache Tomcat 11 | Application server |
| Maven 3.9.9 | Build & dependency management |
| Bootstrap 5.3 | Responsive UI framework |
| Java Swing | Desktop admin application |
| java.net (Socket) | Client-server networking |
| Java RMI | Remote inventory service |
| BCrypt | Password hashing |

## Project Structure

```
ShopSphere/
├── pom.xml                    # Maven configuration
├── mvnw.cmd / mvnw            # Maven wrapper scripts
├── database/
│   ├── shopsphere.sql         # Complete schema + seed data (88 products)
│   └── schema_only.sql        # DDL only
├── src/main/java/com/shopsphere/
│   ├── model/                 # 11 Serializable POJOs
│   ├── dao/                   # 11 JDBC DAOs (PreparedStatement)
│   ├── service/               # Business logic layer
│   ├── controller/            # Jakarta Servlets
│   ├── filter/                # Auth & Admin security filters
│   ├── listener/              # Lifecycle listeners
│   ├── util/                  # DBConnection, PasswordUtil
│   ├── swing/                 # Desktop admin app
│   ├── network/               # Socket client-server
│   ├── rmi/                   # Remote inventory service
│   └── edu/                   # Syllabus demonstrations
├── src/main/webapp/           # JSP, CSS, JS, images
└── src/test/                  # Unit & integration tests
```

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/alokchoudhary885-coder/ShopSphere.git

# 2. Import database
mysql -u root -p < database/shopsphere.sql

# 3. Configure database connection
# Edit src/main/resources/db.properties

# 4. Build the project
mvnw.cmd package

# 5. Deploy ShopSphere.war to Apache Tomcat 11 webapps/
```

## Default Login Credentials

| Role | Email | Password |
|---|---|---|
| Admin | admin@shopsphere.com | admin123 |
| Customer | customer@shopsphere.com | customer123 |

## License

This project is developed for educational purposes as part of the RTU Advanced Java Lab curriculum.
