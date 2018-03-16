#!/bin/bash
version=1.10

/usr/local/go/bin/go version | grep $version > /dev/null

if [ $? -eq 0 ] ; then
  log "Go installed. Skipping..."
  exit 0
fi

log "Downloading go $version"
curl -s -O https://storage.googleapis.com/golang/go$version.linux-amd64.tar.gz
failFast $? "Fail to download go"

log "Installing go $version"
tar -C /usr/local -xzf go$version.linux-amd64.tar.gz
failFast $? "Fail to extract go"

rm go$version.linux-amd64.tar.gz

success "Go $version installed."

