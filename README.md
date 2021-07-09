# Openocd docker multiple

This project was made to parallel program multiple nrf chips using stlink.

## Installation

Prerequisites: "docker" and "docker.io". In order to install, run from this directory:

Ubuntu:
```
apt-get install docker docker.io -y
```

## Usage
This repository is util just to maintenance or version update. So to use this software, it is not necessary to clone it. It's only necessary have docker installed and logged into the loopkey account.

## Maintenance or Update
This steps is just to be used by maintenance or update the docker image, use very carefully.

1. Clone this repository.
2. Execute configure file on root. This step requires that ssh key of loopkey github is configured.
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
