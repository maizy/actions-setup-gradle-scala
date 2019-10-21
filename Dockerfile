FROM openjdk:8u212-jdk-alpine

LABEL org.opencontainers.image.authors="Nikita Kovalev" \
      org.opencontainers.image.source="https://github.com/maizy/actions-setup-gradle-scala" \
      org.opencontainers.image.version="v1"

ARG GRADLE_LAUNCHER_VERSION
ENV GRADLE_LAUNCHER_VERSION ${GRADLE_LAUNCHER_VERSION:-5.6.3}
ENV GRADLE_HOME /usr/local/gradle

RUN apk --no-cache --update add bash wget git

RUN mkdir -p "/tmp/gradle" && \
    wget -qO /tmp/gradle/gradle-bin.zip "https://services.gradle.org/distributions/gradle-${GRADLE_LAUNCHER_VERSION}-bin.zip"

RUN mkdir -p /tmp/gradle/gradle-bin && \
    unzip -d "/tmp/gradle/gradle-bin" /tmp/gradle/gradle-bin.zip && \
    mv "/tmp/gradle/gradle-bin/gradle-${GRADLE_LAUNCHER_VERSION}" "$GRADLE_HOME" && \
    rm -rf /tmp/gradle

ARG SCALA_VERSION
ENV SCALA_VERSION ${SCALA_VERSION:-2.12.9}
ENV SCALA_HOME /usr/local/scala
ENV PATH ${PATH}:${GRADLE_HOME}/bin:${SCALA_HOME}/bin

RUN mkdir -p "$SCALA_HOME" && \
    wget -qO - "https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-${SCALA_VERSION}.tgz" | tar xz -C "${SCALA_HOME}" --strip-components=1

COPY sample-project /tmp/gradle-project

RUN cd /tmp/gradle-project && \
    sed -i "s/%SCALA_VERSION%/${SCALA_VERSION}/" build.gradle && \
    sed -i "s/%GRADLE_VERSION%/${GRADLE_LAUNCHER_VERSION}/" build.gradle && \
    gradle wrapper --no-daemon --console=plain && \
    ./gradlew jar --no-daemon --console=plain && \
    rm -rf /tmp/gradle-project

WORKDIR /root
ENTRYPOINT ["bash"]
