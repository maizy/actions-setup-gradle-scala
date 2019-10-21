#!/bin/bash

DATE=`date -u '+%Y-%m-%dT%H:%M:%S%Z'`
REV=`git rev-parse HEAD`

for GRADLE_LAUNCHER_VERSION in '5.6.3' '4.10.3'; do
    for SCALA_VERSION in '2.12.10' '2.13.1'; do
        echo ""
        echo "BUILD scala=${SCALA_VERSION} gradle=${GRADLE_LAUNCHER_VERSION}"
        docker build \
            --label "org.opencontainers.image.created=${DATE}" \
            --label "org.opencontainers.image.revision=${REV}" \
            --build-arg "SCALA_VERSION=${SCALA_VERSION}" \
            --build-arg "GRADLE_LAUNCHER_VERSION=${GRADLE_LAUNCHER_VERSION}" \
            -t "maizy/actions-setup-gradle-scala:8u212-scala-${SCALA_VERSION}-gradle-${GRADLE_LAUNCHER_VERSION}-v1" \
            .
    done
done
