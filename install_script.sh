#!/bin/bash

# update system
echo "Updating system..."
sudo pacman -Syu

# install necessary packages
echo "Installing necessary packages..."
sudo pacman -S --needed alacritty crkbd dunst i3 mpd mpv newsboat picom zsh stow ttf-dejavu git

# go to .dotfiles directory
cd ~/.dotfiles

# pull latest changes from the repository and update submodules
echo "Updating repository and submodules..."
git pull origin master
git submodule update --init --recursive

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
