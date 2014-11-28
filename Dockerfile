FROM ubuntu:14.04
MAINTAINER Kevin Mook <kevin@kevinmook.com>

RUN apt-get update && apt-get install -y wget screen

# TODO install java

# the minecraft folder will be in /data
VOLUME ["/data"]
VOLUME ["/backup"]

COPY /container_scripts/minecraft /minecraft/

# Forward apporpriate ports
EXPOSE 25565/tcp 25565/udp

# Run murmur
CMD ["/minecraft/minecraft", "start"]
