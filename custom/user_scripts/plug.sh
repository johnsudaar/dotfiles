#!/bin/bash

if [ -f $HOME/.local/share/nvim/site/autoload/plug.vim ] ; then
  log "Plug.vim already installed. Skipping..."
  exit 0
fi

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
failFast $? "Fail to install Plug.vim"

success "Plug.vim installed"

