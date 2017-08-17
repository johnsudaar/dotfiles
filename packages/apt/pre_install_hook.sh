#!/bin/bash

export PROJECT_ROOT=$1

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

apt-get update | identOutput
apt-get install -y apt-transport-https ca-certificates curl software-properties-common | identOutput

failFast $? "Unable to install needed apt tools"

info "Running apt hooks"
for file in $(ls $PROJECT_ROOT/packages/apt/extra_packages ) ; do
  log "Running $file"
  source $PROJECT_ROOT/packages/apt/extra_packages/$file
done
success "Done!"

