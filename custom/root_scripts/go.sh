#!/bin/bash
version=1.23.6

/usr/local/go/bin/go version | grep $version > /dev/null

if [ $? -eq 0 ] ; then
  log "Go installed. Skipping..."
  exit 0
fi

log "Downloading go $version"
if [ -d /usr/local/go ]; then
  log "Previous go installation found, cleaning up..."
  rm -r /usr/local/go
fi

log "Downloading go ${version}..."
curl -s -L -O https://go.dev/dl/go$version.linux-amd64.tar.gz
failFast $? "Fail to download go."

log "Installing go $version..."
tar -C /usr/local -xzf go$version.linux-amd64.tar.gz
failFast $? "Fail to extract go"

rm go$version.linux-amd64.tar.gz

success "Go $version installed."

