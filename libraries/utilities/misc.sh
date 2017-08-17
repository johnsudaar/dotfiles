#!/bin/bash

function failFast() {
  if [ $1 -ne 0 ] ; then
    shift 1
    fatal $*
  fi
}
