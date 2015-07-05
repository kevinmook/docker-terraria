#!/bin/bash
set -e

cd /terraria/
mono --server --gc=sgen -O=all TerrariaServer.exe -port 7777 -world /data/terraria_world/first.wld -autocreate 3
