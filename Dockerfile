# Use Maven to build the app
FROM maven:3.9.9-amazoncorretto-17-al2023 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use OpenJDK to run the app
FROM openjdk:17-slim-bullseye
WORKDIR /app
COPY --from=build /app/target/config-server.jar config-server.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "config-server.jar"]
