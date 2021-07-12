FROM alpine:3.6

WORKDIR /tmp

RUN apk --no-cache add --virtual runtime-dependencies \
      libusb \
      libftdi1 &&\
    apk --no-cache add --virtual build-dependencies \
      git \
      build-base \
      libusb-dev \
      libftdi1-dev \
      automake \
      autoconf \
      libtool &&\
    git clone https://github.com/ntfreak/openocd.git &&\
    cd openocd &&\
    git checkout 2caa3455ada686baea01a50d092e4244c461e101 &&\
    ./bootstrap &&\
    ./configure &&\
    make &&\
    make install &&\
    apk del --purge build-dependencies &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

#create a directory for our project & setup a shared workfolder between the host and docker container
RUN mkdir -p /usr/src/app
VOLUME ["/usr/src/app"]
WORKDIR /usr/src/app
RUN cd /usr/src/app

EXPOSE 3333

ENTRYPOINT ["openocd"]
# CMD ["no arguments"]