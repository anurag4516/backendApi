# Build Stage
FROM maven:3.6.0-jdk-11-slim AS build
RUN mkdir -p /opt/source
COPY src /opt/source/src
COPY pom.xml /opt/source
RUN mvn -f /opt/source/pom.xml clean package

# Package Stage
FROM openjdk:10-jre-slim
RUN mkdir -p /opt/to-do-app/ 
COPY --from=build ./opt/source/target/to-do-listEntity-app-0.0.1-SNAPSHOT.jar /opt/to-do-app/
WORKDIR /opt/to-do-app/
EXPOSE 8080
CMD ["java", "-jar", "to-do-listEntity-app-0.0.1-SNAPSHOT.jar"]
