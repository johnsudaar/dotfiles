#!/bin/bash

eval "$(~/.rbenv/bin/rbenv init -)"

tmuxinator version 2>&1 > /dev/null

if [ $? -eq 0 ] ; then
  log "Tmuxinator installed. Skipping..."
else
  gem install tmuxinator
  failFast $? "Failed to install tmuxinator"
fi

if [ -f $HOME/.bin/tmuxinator.zsh ] ; then
  log "Tmuxinator autocompletion present. Skipping.."
  exit 0
else
  mkdir -p $HOME/.bin
  curl -S "https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh" > $HOME/.bin/tmuxinator.zsh
  failFast $? "Fail to install tmuxinator autocompletion"
fi


success "Tmuxinator installed"
