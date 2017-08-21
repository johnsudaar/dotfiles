#!/bin/bash

if [ -d $HOME/Documents/Scalingo/tools-and-hacks/ ] ; then
  log "Scalingo base project installed. Skipping..."
  exit 0
fi

mkdir -p $HOME/Documents/Scalingo/
mkdir -p $HOME/gocode/src/github.com/Scalingo

git clone git@github.com:Scalingo/tools-and-hacks.git $HOME/Documents/Scalingo/tools-and-hacks
failFast $? "Fail to install base scalingo repo"

success "Base scalingo repo installed"
