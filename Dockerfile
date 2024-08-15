FROM gradle:8.10.0-jdk21-alpine AS build
LABEL authors="GEOVANI"
COPY . /app
WORKDIR /app
RUN gradle build -x test

FROM openjdk:21-jdk-slim
COPY --from=build /app/build/libs/*.jar demo.jar
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "demo.jar"]