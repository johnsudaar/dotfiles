#!/bin/bash

if [ -f $HOME/gocode/bin/curl-unix-socket ] ; then
  log "curl-unix-socket installed. Skipping..."
  exit 0
fi

/usr/local/go/bin/go get github.com/Soulou/curl-unix-socket
failFast $? "Fail to install curl-unix-socket"

success "Curl unix socket installed"
