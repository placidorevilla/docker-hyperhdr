FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND="noninteractive"
ARG HYPERHDR_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
ARG HYPERHDR_VERSION="17.0.0.0"
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN ["/bin/bash", "-c", "declare -A ARCHMAP=( [linux/amd64]=x86_64 [linux/arm64]=aarch64 ) && \
    ARCH=${ARCHMAP[${TARGETPLATFORM}]} && \
    echo '**** install packages ****' && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
#           wget xz-utils libusb-1.0-0 libexpat1 libglu1-mesa libglib2.0-0 libfreetype6 && \
         wget libglu1-mesa && \
    echo '**** install HyperHDR ****' && \
    wget -O /tmp/hyperhdr.deb ${HYPERHDR_URL}/v${HYPERHDR_VERSION}/HyperHDR-${HYPERHDR_VERSION}-Linux-${ARCH}.deb && \
    apt install -y ./tmp/hyperhdr.deb && \
    echo '**** cleanup ****' && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    "]

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8090 19444 19445
VOLUME /config
