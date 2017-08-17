#!/bin/bash

export PROJECT_ROOT="$(dirname "$0")/../"

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

if [ ! `whoami` = root ] ; then
  info "Switching to root"
  exec sudo bash $0
fi

success "Continuing as root"

info "Starting custom synchronisation"

for file in $(ls $PROJECT_ROOT/custom/scripts) ; do
  info "Running $file"
  source $PROJECT_ROOT/custom/scripts/$file
done

success "Custom scripts runned"

