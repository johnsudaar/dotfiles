#!/bin/bash

if [ -d $HOME/Documents/cli-tools/fonts ] ; then
  log "Patched fonts installed. Skipping..."
  exit 0
else
  git clone https://github.com/powerline/fonts.git --depth=1 $HOME/Documents/cli-tools/fonts
  ~/Documents/cli-tools/fonts/install.sh
  failFast $? "Fail to install patched fonts"
fi

success "Patched fonts installed"
