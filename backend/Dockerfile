FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY pom.xml .
# Download all required dependencies into one layer
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src
# Build application
RUN mvn package -DskipTests

# Use OpenJDK for running the application
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Create a non-root user to improve security
RUN addgroup --system javauser && adduser --system --ingroup javauser javauser
USER javauser

# Copy JAR file from build stage
COPY --from=build /app/target/*.jar app.jar

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -q --spider http://localhost:8080/actuator/health || exit 1

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"] 