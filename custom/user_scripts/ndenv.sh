#!/bin/bash

if [ -d $HOME/.ndenv ] ; then
  log "Ndenv already installed. Skipping..."
else
  git clone https://github.com/riywo/ndenv ~/.ndenv 2>&1 | identOutput
  failFast $? "Failed to clone ndenv"
fi

if [ -d $HOME/.ndenv/plugins/node-build ] ; then
  log "Node-build (ndenv) already installed. Skipping..."
  exit 0
else
  git clone https://github.com/riywo/node-build.git ~/.ndenv/plugins/node-build 2>&1 | identOutput
  failFast $? "Failed to install node-build"
fi

success "Ndenv installed"
