#!/bin/bash

if [ -f $HOME/.zsh/completion/scalingo_complete.zsh ] ; then
  log "Scalingo cli completion installed. Skipping..."
  exit 0
fi

mkdir -p $HOME/.zsh/completion/
curl "https://raw.githubusercontent.com/Scalingo/cli/master/cmd/autocomplete/scripts/scalingo_complete.zsh" > ~/.zsh/completion/scalingo_complete.zsh
failFast $? "Fail to install scalingo autocompletion"

success "Scalingo cli autocompletion installed"

