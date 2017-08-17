#!/bin/bash

# COLORS
COLORS_RESET="\033[1;0m"
COLORS_RED="\033[1;31m"
COLORS_GREEN="\033[1;32m"
COLORS_YELLOW="\033[1;33m"
COLORS_BLUE="\033[1;34m"

function ident() {
  MESSAGE=$1$'\t'
  echo -n "$MESSAGE "
}

function identOutput() {
  sed -e 's/^/\t /'
}

function log() {
  ident
  echo $*
}

function warn() {
  echo -ne $COLORS_YELLOW
  ident "WARNING"
  echo -ne $COLORS_RESET
  echo $*
}

function error() {
  echo -ne $COLORS_RED
  ident "ERROR"
  echo -ne $COLORS_RESET
  echo $*
}

function fatal() {
  echo -ne $COLORS_RED
  ident "FATAL"
  echo -ne $COLORS_RESET
  echo $*
  exit 1
}

function info() {
  echo -ne $COLORS_BLUE
  ident "INFO"
  echo -ne $COLORS_RESET
  echo $*
}

function success() {
  echo -ne $COLORS_GREEN
  ident "SUCCESS"
  echo -ne $COLORS_RESET
  echo $*
}
