FROM phusion/baseimage:0.9.15
MAINTAINER Kevin Mook <kevin@kevinmook.com>

RUN apt-get update && apt-get install -y wget screen software-properties-common

# this installs Oracle Java. It automatically accepts the license. *I* accept it, but if you use this Dockerfile you should make sure you read and accept the license, too.
RUN add-apt-repository -y ppa:webupd8team/java && apt-get update && (echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections) && (echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections) && apt-get install -y oracle-java7-installer

# the minecraft folder will be in /data
VOLUME ["/data"]
VOLUME ["/backup"]

ADD /container_scripts/minecraft /minecraft/
ADD /container_scripts/init.d/* /etc/my_init.d/

# Forward apporpriate ports
EXPOSE 25565/tcp 25565/udp

CMD ["/sbin/my_init"]
