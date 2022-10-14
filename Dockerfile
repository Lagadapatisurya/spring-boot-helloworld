# stage-1: 
FROM maven:3.5.0-jdk-8-alpine AS builder
# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/
# package jar
RUN mvn -DskipTests clean package 

# Second stage: minimal runtime environment
From openjdk:8-jre-alpine
# copy jar from the first stage
COPY --from=builder target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar spring-boot-helloworld-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "spring-boot-helloworld-0.0.1-SNAPSHOT.jar"]
