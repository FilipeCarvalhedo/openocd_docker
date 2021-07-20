# Openocd docker multiple

This project was made to parallel program multiple nrf chips using stlink.

## Installation

Prerequisites: "docker" and "docker.io". In order to install, run from this directory:

Ubuntu:
```
apt-get install docker docker.io -y
```

## Usage
Execute configure with sudo to pull docker image and create a link on /usr/local/bin/openocd

To use parallel stlink program use normal openocd with new arguments:
	"-zn" is to show stlink devices connected
	"-zl id_device"


## Maintenance or Update
This steps is just to be used by maintenance or update the docker image, use very carefully.

1. Clone this repository.
2. Execute configure file on root.
```
./configure
```
3. Build docker.
```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx rm builder
docker buildx create --name builder --driver docker-container --use
docker buildx inspect --bootstrap
docker buildx build --push --platform linux/amd64,linux/arm64,linux/arm/v7 -t filipecarvalhedo/docker_openocd .
```
