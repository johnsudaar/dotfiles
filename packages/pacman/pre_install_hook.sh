#!/bin/bash

export PROJECT_ROOT=$1

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

cat $PROJECT_ROOT/packages/pacman/pacman.conf $PROJECT_ROOT/packages/pacman/extra_configuration/* > /tmp/pacman.conf

installFile /tmp/pacman.conf /etc/pacman.conf
cpStat=$?

rm /tmp/pacman.conf

if [ $cpStat -eq 2 ] ; then fatal "File synchronisation failed" ; fi

if [ $cpStat -eq 1 ] ; then
  info "Pacman configuration has changed. Running hooks"
  for file in $(ls $PROJECT_ROOT/packages/pacman/pre_install_hooks ) ; do
    log "Running $file"
    source $PROJECT_ROOT/packages/pacman/pre_install_hooks/$file
  done
  success "Done!"
fi
