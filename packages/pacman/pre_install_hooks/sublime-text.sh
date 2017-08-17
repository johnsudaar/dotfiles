#!/bin/bash

curl -s -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A
res=$?
rm sublimehq-pub.gpg
failFast $res "Fail to run sublime text pre-hook"
