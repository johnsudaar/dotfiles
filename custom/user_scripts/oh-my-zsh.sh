#!/bin/bash

if [ -d $HOME/.oh-my-zsh ] ; then
  log "Oh My Zsh already installed. Skipping..."
  exit 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
failFast $? "Fail to install oh my zsh"

success "Oh my zsh installed"
