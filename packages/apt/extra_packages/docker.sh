#!/bin/bash

apt-key list | grep 'Docker Release (CE deb)' >/dev/null

if [ $? -eq 0 ] ; then
  info "Already installed, skipping"
  exit 0
fi

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

success "Docker pre-hook succeeded"
