#!/bin/sh
 xrandr | grep 'DP-1 connected 3840x2160' && xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 3200x1800 --pos 0x2160 --rotate normal --output DP-2 --off
