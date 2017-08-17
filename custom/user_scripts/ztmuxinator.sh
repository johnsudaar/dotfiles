#!/bin/bash

tmuxinator version 2>&1 > /dev/null

if [ $? -eq 0 ] ; then
  log "Tmuxinator installed. Skipping..."
  exit 0
else
  gem install tmuxinator
  failFast $? "Failed to install tmuxinator"
fi

success "Tmuxinator installed"
