FROM debian:buster-slim
LABEL maintainer="Chris Smith <chris.smith@oozlum.co.uk>"
LABEL Description="Image for building SAMD21 CMSIS projects"

RUN apt update && \
    apt install -y git wget bzip2 sudo build-essential && \
    addgroup build && \
    adduser --ingroup build build && \
    mkdir -p /etc/sudoers.d && \
    echo "build ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/build && \
    chmod 0440 /etc/sudoers.d/build

WORKDIR /opt
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj
RUN git clone --depth 1 --branch v4.5.0 https://github.com/ARM-software/CMSIS_4.git CMSIS/4.5.0
ADD CMSIS-Atmel-1.2.0.tgz .

ENV PATH "/opt/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"
WORKDIR /home/build
USER build
