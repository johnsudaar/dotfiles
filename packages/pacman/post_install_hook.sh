#!/bin/bash

export PROJECT_ROOT=$1

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

info "Running post install hooks"
for file in $(ls $PROJECT_ROOT/packages/pacman/post_install_hooks ) ; do
  log "Running $file"
  source $PROJECT_ROOT/packages/pacman/post_install_hooks/$file
done
success "Done!"
