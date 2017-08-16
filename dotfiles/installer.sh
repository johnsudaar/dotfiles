#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage $0 [HOME_DIR]" 1>&2
  exit 1
fi

HOME_DIR=$1
BASEDIR=$(dirname "$0")

source $BASEDIR/../libraries/bootstrap.sh
load $BASEDIR/../libraries

OLD_IFS=$IFS
IFS=$'\n'

log "Starting dotfiles synchronisation"

for line in $( sed -e '/^$/d' -e '/^\#.*$/d' $BASEDIR/map) ; do
  src=$(echo $line | cut -d' ' -f1)
  dst=$(echo $line | cut -d' ' -f2)

  if [ -f $BASEDIR/$src ] ; then
    installFile $BASEDIR/$src $HOME_DIR/$dst
  fi

  if [ -d $BASEDIR/$src ] ; then
    installDir $BASEDIR/$src $HOME_DIR/$dst
  fi
done

IFS=$OLD_IFS

success "Dotfiles synchronisation ended!"

