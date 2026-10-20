# ==============================================================================
# ShopSphere — Production Dockerfile for Render / Railway / Cloud Deployment
# Multi-stage build: Maven 3.9 (JDK 21) -> Apache Tomcat (JDK 21)
# ==============================================================================

# Stage 1: Build WAR with Maven
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /build

# Copy configuration and source code
COPY pom.xml .
COPY src ./src

# Compile and package production WAR
RUN mvn clean package -DskipTests

# Stage 2: Runtime Container with Apache Tomcat & JDK 21
FROM tomcat:10.1-jdk21-temurin

# Clean default Tomcat welcome apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy ShopSphere as the default ROOT application (accessible directly at /)
COPY --from=builder /build/target/ShopSphere.war /usr/local/tomcat/webapps/ROOT.war
# Also deploy as /ShopSphere for legacy context path compatibility
COPY --from=builder /build/target/ShopSphere.war /usr/local/tomcat/webapps/ShopSphere.war

# Expose HTTP port
EXPOSE 8080

# Start Tomcat Server
CMD ["catalina.sh", "run"]
