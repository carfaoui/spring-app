FROM maven:3-jdk-8 AS builder

RUN mkdir /build

WORKDIR /build

COPY . /build

RUN ls .

RUN mvn clean install

FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG DEPENDENCY=target/dependency
COPY --from=builder /build/BOOT-INF/lib /app/lib
COPY --from=builder /build/META-INF /app/META-INF
COPY --from=builder /build/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]
