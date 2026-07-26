#!/bin/bash

if [ -d $HOME/.nodenv ] ; then
  log "Nodenv already installed. Skipping..."
else
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv 2>&1 | identOutput
    failFast $? "Failed to clone nodenv"
fi

if [ -d $HOME/.nodenv/plugins/node-build ] ; then
  log "Nodenv node-build already installed. Skipping..."
else
  git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build 2>&1 | identOutput
  failFast $? "Failed to clone nodenv node-build"
fi