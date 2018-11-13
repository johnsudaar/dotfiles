#!/bin/bash

if [ -x "$(which fx)" ] ; then
  npm install -g fx
  failFast $? "Fail to install fx"
  success "FX installed"
else
  log "Cli tools already installed, Skipping..."
  exit 0
fi
