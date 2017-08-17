#!/bin/bash

if [ -f /usr/local/bin/scalingo ] ; then
  log "Scalingo cli already installed. Skipping..."
  exit 0
fi

curl -sO https://cli-dl.scalingo.io/install && bash install
failFast $? "Fail to install scalingo cli"
