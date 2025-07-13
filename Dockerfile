# syntax=docker/dockerfile:1
FROM eclipse-temurin:17-jdk-alpine

# Create working directory
WORKDIR /app

# Copy the JAR (built by Gradle)
COPY build/libs/spring_boot_crash_course-0.0.1-SNAPSHOT.jar app.jar

# Expose Spring Boot default port
EXPOSE 8080

# Run Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
