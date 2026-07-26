#!/bin/bash

if [ -d "$HOME/Documents/cli-tools/fonts" ] ; then
  log "Patched fonts installed. Skipping..."
else
  git clone https://github.com/powerline/fonts.git --depth=1 "$HOME/Documents/cli-tools/fonts"
  "$HOME/Documents/cli-tools/fonts/install.sh"
  failFast $? "Fail to install patched fonts"
fi

nerd_symbols_dir="$HOME/.local/share/fonts/NerdFontsSymbolsOnly"
nerd_symbols_font="$nerd_symbols_dir/SymbolsNerdFontMono-Regular.ttf"

if [ -f "$nerd_symbols_font" ] ; then
  log "Nerd Font symbols installed. Skipping..."
else
  nerd_symbols_tmp="$(mktemp -d)"
  nerd_symbols_archive="$nerd_symbols_tmp/NerdFontsSymbolsOnly.tar.xz"

  mkdir -p "$nerd_symbols_dir"
  curl -fL \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz \
    -o "$nerd_symbols_archive"
  failFast $? "Fail to download Nerd Font symbols"

  tar -xJf "$nerd_symbols_archive" -C "$nerd_symbols_dir" \
    SymbolsNerdFont-Regular.ttf SymbolsNerdFontMono-Regular.ttf
  failFast $? "Fail to install Nerd Font symbols"

  rm -rf "$nerd_symbols_tmp"
  fc-cache -f
  failFast $? "Fail to refresh the font cache"
fi

success "Patched fonts installed"
