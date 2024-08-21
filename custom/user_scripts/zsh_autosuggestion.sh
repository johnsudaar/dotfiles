#!/bin/bash

PLUGIN_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


if [ -d ${PLUGIN_PATH} ] ; then
  log "ZSH Suggestion installed. Skipping..."
  exit 0
fi


git clone https://github.com/zsh-users/zsh-autosuggestions ${PLUGIN_PATH}
failFast $0 "Unable to install zsh Suggestions"

success "Zsh suggestions installed"
