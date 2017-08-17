#!/bin/bash

rubocop version 2>&1 > /dev/null

if [ $? -eq 0 ] ; then
  log "Rubocop installed. Skipping..."
  exit 0
else
  gem install rubocop
  failFast $? "Failed to install rubocop"
fi

success "Rubocop installed"
