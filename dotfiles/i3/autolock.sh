#!/usr/bin/env bash

. /home/john/.nix-profile/etc/profile.d/nix.sh

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; /home/john/.config/i3/.lock.sh' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 300 \
    'systemctl suspend' \
    ''\
  --socket /tmp/autolocker.sock
