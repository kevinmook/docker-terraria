FROM phusion/baseimage:0.9.16
MAINTAINER Kevin Mook <kevin@kevinmook.com>

RUN apt-get update && apt-get install -y wget screen software-properties-common unzip

# this installs Oracle Java. It automatically accepts the license. *I* accept it, but if you use this Dockerfile you should make sure you read and accept the license, too.
RUN add-apt-repository -y ppa:webupd8team/java && apt-get update && (echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections) && (echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections) && apt-get install -y oracle-java7-installer

# the minecraft folder will be in /data
VOLUME ["/data"]
VOLUME ["/backup"]

ADD configs/ssh/* /tmp/
RUN cat /tmp/authorized_keys >>/root/.ssh/authorized_keys &&\
        rm -f /tmp/authorized_keys
 
ADD /container_scripts/minecraft /minecraft/
ADD /container_scripts/init.d/* /etc/my_init.d/

# allow sshing into the container
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. Passenger-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Forward apporpriate ports
EXPOSE 25565/tcp 25565/udp

CMD ["/sbin/my_init"]
