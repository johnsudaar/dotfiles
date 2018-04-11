#!/bin/bash

if [ -f $HOME/.cargo/bin/rustfmt ] ; then
  log "Rustfmt installed. Skipping..."
else
  $HOME/.cargo/bin/rustup component add rustfmt-preview
  failFast $? "Fail to install rustfmt"
  success "Rustfmt installed!"
fi

if [ -f $HOME/.cargo/bin/racer ] ; then
  log "Racer installed. Skipping..."
else
  $HOME/.cargo/bin/cargo install racer
  failFast $? "Fail to install racer"
  success "Racer installed!"
fi


if [ -d `$HOME/.cargo/bin/rustc --print sysroot`/lib/rustlib/src/rust/src ] ; then
  log "RustSrc installed. Skipping..."
else
  $HOME/.cargo/bin/rustup component add rust-src
  failFast $? "Fail to install rustsrc"
  success "RustSrc installed!"
fi
