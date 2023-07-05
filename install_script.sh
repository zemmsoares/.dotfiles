#!/bin/bash

# update system
echo "Updating system..."
sudo pacman -Syu

# install necessary packages
echo "Installing necessary packages..."
sudo pacman -S --needed alacritty crkbd dunst i3 mpd mpv newsboat picom zsh stow ttf-dejavu git

# clone the dotfiles
echo "Cloning dotfiles from GitHub..."
git clone https://github.com/zemmsoares/.dotfiles ~/.dotfiles

# go to .dotfiles directory
cd ~/.dotfiles

# stow configuration files
echo "Stowing configuration files..."
for dir in alacritty crkbd dunst i3 mpd mpv newsboat picom zsh
do
  stow -R $dir
done

# install fonts
echo "Installing fonts..."
sudo cp fonts/MaterialSymbols-Rounded.ttf /usr/share/fonts/TTF/
fc-cache -fv

echo "All tasks completed successfully!"
