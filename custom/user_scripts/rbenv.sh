#!/bin/bash

version=2.7.1

if [ -d $HOME/.rbenv ] ; then
  log "Rbenv already installed. Skipping..."
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv 2>&1 | identOutput
  failFast $? "Failed to clone rbenv"
fi

if [ -d $HOME/.rbenv/plugins/ruby-build ] ; then
  log "Ruby-build (rbenv) already installed. Skipping..."
else
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build 2>&1 | identOutput
  failFast $? "Failed to install ruby-build"
fi


export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

ruby --version | grep "$version" > /dev/null

if [ $? -eq 0 ] ; then
  log "Ruby version $version installed. Skipping..."
  exit 0
else
  rbenv install $version
  rbenv global $version
fi

success "Rbenv installed"
