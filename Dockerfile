# https://hub.docker.com/_/maven
FROM maven:3-jdk-11-openj9 AS BUILD_IMAGE
ENV APP_HOME=/app
WORKDIR $APP_HOME
# download dependencies
COPY . .
RUN mvn package

# https://hub.docker.com/_/openjdk
FROM openjdk:11.0.6-slim
ENV APP_HOME=/app
WORKDIR $APP_HOME
COPY --from=BUILD_IMAGE /app/target/spring-boot-hello-world-1.0.0.jar .
EXPOSE 8080
CMD ["java","-jar","spring-boot-hello-world-1.0.0.jar"]
