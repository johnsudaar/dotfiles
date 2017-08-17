#!/bin/bash

export PROJECT_ROOT="$(dirname "$0")/../"

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

info "Switching to root"
[ `whoami` = root ] || exec sudo bash $0
success "Continuing as root"

info "Starting custom synchronisation"

for file in $(ls $PROJECT_ROOT/custom/scripts) ; do
  info "Running $file"
  source $PROJECT_ROOT/custom/scripts/$file
done

success "Custom scripts runned"

