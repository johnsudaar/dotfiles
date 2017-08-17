#!/bin/bash

export PROJECT_ROOT="$(dirname "$0")/../"

source $PROJECT_ROOT/libraries/bootstrap.sh
load $PROJECT_ROOT/libraries

manager=${MANAGER:-apt}

info "Starting with $manager package manager"
info "You may be asked for sudo access"

pre_install_hook_path="$PROJECT_ROOT/packages/$manager/pre_install_hook.sh"

if [ -f $pre_install_hook_path ] ; then
  info "Running pre package hooks"
  sudo $pre_install_hook_path $PROJECT_ROOT
  failFast $? "Hook failed, stopping package installation"
fi

package_list=""

for line in $( sed -e '/^$/d' -e '/^\#.*$/d' $PROJECT_ROOT/packages/packages.list) ; do
  if [ "$manager" == "apt" ] ; then
    package=$(echo $line | cut -d',' -f1)
  else
    package=$(echo $line | cut -d',' -f1)
  fi

  if [ ! -z $package ] ; then
    package_list="$package_list $package"
  fi
done

if [ "$manager" == "apt" ] ; then
  sudo apt-get update | identOutput
  sudo apt-get install -y $package_list | identOutput
else
  pacman -S $package_list | identOutput
fi

success "Packages installed"
