#!/bin/bash

curl -S -L -o /tmp/bg.jpg 'https://source.unsplash.com/random/1920x1080'
feh --bg-scale /tmp/bg.jpg
