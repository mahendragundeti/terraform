# First stage: build the app using Maven
FROM adoptopenjdk/maven-openjdk11 AS build
WORKDIR /app
COPY . /app
RUN mvn clean package

# Second stage: copy the built jar file and run it using OpenJDK with Alpine JRE
FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /app
COPY --from=build /app/target/spring-boot-web.jar /app
ENTRYPOINT ["java", "-jar", "spring-boot-web.jar"]
