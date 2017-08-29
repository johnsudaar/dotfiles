#!/bin/bash

if [ -d $HOME/.zsh/zsh-autosuggestions ] ; then
  log "ZSH Suggestion installed. Skipping..."
  exit 0
fi

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
failFast $0 "Unable to install zsh Suggestions"

success "Zsh suggestions installed"
