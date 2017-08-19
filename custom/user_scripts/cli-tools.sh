#!/bin/bash

if [ -d $HOME/Documents/cli-tools/perso/ ] ; then
  log "Cli tools already installed, Skipping..."
  exit 0
fi

mkdir -p $HOME/Documents/cli-tools
git clone git@github.com:johnsudaar/cli-tools.git $HOME/Documents/cli-tools/perso 2>&1 | identOutput
failFast $? "Fail to install cli tools"

success "Cli tools installed"
