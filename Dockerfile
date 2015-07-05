FROM phusion/baseimage:0.9.16
MAINTAINER Kevin Mook <kevin@kevinmook.com>

# Regenerate SSH host keys. Passenger-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# allow sshing into the container
RUN rm -f /etc/service/sshd/down

RUN apt-get update && apt-get install -y wget screen mono-complete git vim unzip

# the terraria folder will be in /data
VOLUME ["/data"]
VOLUME ["/backup"]

ADD configs/ssh/* /tmp/
RUN cat /tmp/authorized_keys >>/root/.ssh/authorized_keys &&\
        rm -f /tmp/authorized_keys

RUN mkdir -p /terraria && \
    wget https://github.com/NyxStudios/TShock/releases/download/v4.2.10/tshock_4.2.10.zip -P /terraria && \
    unzip /terraria/tshock_4.2.10.zip -d /terraria

RUN mkdir /etc/service/terraria
ADD /container_scripts/services/terraria.sh /etc/service/terraria/run

# Forward apporpriate ports
EXPOSE 7777/tcp 7777/udp

CMD ["/sbin/my_init"]
