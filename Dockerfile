FROM maven:3-jdk-8 AS builder

RUN mkdir /build

WORKDIR /build

COPY . /build

RUN ls .

RUN mvn clean install

RUN ls /build/target/

FROM openjdk:8-jdk-alpine
COPY --from=builder /build/target/dependency/BOOT-INF/lib /app/lib
COPY --from=builder /build/target/dependency/META-INF /app/META-INF
COPY --from=builder /build/target/dependency/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]
