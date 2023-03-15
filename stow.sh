#!/bin/bash

# Set the target directory for the Xorg configuration files
xorg_target="/etc/X11/xorg.conf.d/"

# Set the stow directory to your .dotfiles directory
stow_dir="/home/zemmsoares/.dotfiles/"

# Stow the Xorg configuration files
stow --target="$xorg_target" -d "$stow_dir" xorg_conf

# Stow the remaining configuration files
stow -t ~ -d "$stow_dir" i3 nvim picom zsh

