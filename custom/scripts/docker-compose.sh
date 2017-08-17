#!/bin/bash

info "Downloading docker-compose"
curl -Ls https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

failFast $? "Fail to download docker-compose"

chmod +x /usr/local/bin/docker-compose

failFast $? "Fail to update docker-compse rights"
