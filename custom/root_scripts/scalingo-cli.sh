#!/bin/bash

if [ -f /usr/local/bin/scalingo ] ; then
  scalingo version | grep "Please update"

  if [ $? -ne 0 ] ; then
    log "Scalingo cli already installed. Skipping..."
    exit 0
  else
    log "New version available. Installing ..."
  fi
fi

curl -sO https://cli-dl.scalingo.io/install && yes | bash install
failFast $? "Fail to install scalingo cli"

success "Scalingo CLI installed"
