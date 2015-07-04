#!/bin/bash
set -e

if [ ! -f /data/server/Tekkit.jar ]; then
  mkdir -p /data/server
  wget http://mirror.technicpack.net/Technic/servers/tekkitmain/Tekkit_Server_v1.2.9g.zip -P /data/server
  unzip /data/server/Tekkit_Server_v1.2.9g.zip -d /data/server
fi
