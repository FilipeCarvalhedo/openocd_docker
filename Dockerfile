FROM ubuntu:14.04

MAINTAINER FilipeCarvalhedo

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yq \
    && apt-get install make gcc -y \
    && apt-get install libtool -y \
    && apt-get install autotools-dev -y \
    && apt-get install automake -y \
    && apt-get install make libtool pkg-config autoconf automake texinfo libusb-1.0-0-dev -y \
    && apt-get install libusb-1.0 -y \
    && apt-get install git -y



RUN cd /usr/src/ \
    && git clone https://github.com/ntfreak/openocd.git \
    && cd openocd \
    && git checkout 2caa3455ada686baea01a50d092e4244c461e101 \
    && ./bootstrap \
    #&& ./configure --enable-stlink --enable-jlink --enable-ftdi --enable-cmsis-dap \
    && ./configure  \
    && make -j"$(nproc)" \
    && make install
#remove unneeded directories
RUN cd .. \
    && rm -rf /usr/src/openocd \
    && rm -rf /var/lib/apt/lists/ \
#OpenOCD talks to the chip through USB, so we need to grant our account access to the FTDI.
    &&cp /usr/local/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d/60-openocd.rules

#create a directory for our project & setup a shared workfolder between the host and docker container
RUN mkdir -p /usr/src/app
# RUN mkdir -p /usr/src/app/config
# RUN mkdir -p /usr/src/app/program
VOLUME ["/usr/src/app"]
WORKDIR /usr/src/app
RUN cd /usr/src/app

EXPOSE 3333

ENTRYPOINT ["openocd"]
# CMD ["no arguments"]