#!/bin/bash

export PROJECT_ROOT="$(dirname "$0")/../"

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

if [ $(whoami) != "root" ] ; then
  info "Starting custom synchronisation"

  if [ ! `whoami` = root ] ; then
    info "Switching to root"
    sudo bash $0 root
    failFast $? "Fail to run root scripts"
  fi

  info "Continuing as $(whoami)"

  for file in $(ls $PROJECT_ROOT/custom/user_scripts) ; do
    log "Running $file"
    bash $PROJECT_ROOT/custom/wrapper.sh $PROJECT_ROOT $PROJECT_ROOT/custom/user_scripts/$file
    failFast $? "Failed to run $file custom script"
  done
  success "Custom scripts runned"
else
  info "Starting as root"
  for file in $(ls $PROJECT_ROOT/custom/root_scripts) ; do
    log "Running $file"
    bash $PROJECT_ROOT/custom/wrapper.sh $PROJECT_ROOT $PROJECT_ROOT/custom/root_scripts/$file
    failFast $? "Failed to run $file custom script"
  done
fi

