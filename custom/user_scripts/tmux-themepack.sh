#!/bin/bash

if [ -d $HOME/.tmux-themepack ] ; then
  log "Tmux themepack already installed. Skipping ..."
  exit 0
fi

git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack 2>&1 | identOutput
failFast $? "Failed to install tmux ThemePack"

success "Tmux themepack installed"
