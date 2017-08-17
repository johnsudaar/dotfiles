#!/bin/bash

if [ -d $HOME/.rbenv ] ; then
  log "Rbenv already installed. Skipping..."
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv 2>&1 | identOutput
  failFast $? "Failed to clone rbenv"
fi

if [ -d $HOME/.rbenv/plugins/ruby-build ] ; then
  log "Ruby-build (rbenv) already installed. Skipping..."
  exit 0
else
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build 2>&1 | identOutput
  failFast $? "Failed to install ruby-build"
fi

success "Rbenv installed"
