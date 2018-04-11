#!/bin/bash

if [ -f $HOME/.cargo/bin/rustc ] ; then
  log "Rust already installed. Skipping..."
  exit 0
fi

curl https://sh.rustup.rs -sSf | sh

failFast $? "Fail to install Rust"

success "Rust installed!"
