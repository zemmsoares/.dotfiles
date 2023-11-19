#!/bin/bash

# Set the URL of the .dotfiles repository
DOTFILES_REPO="https://github.com/zemmsoares/.dotfiles"

# update system
echo "Updating system..."
sudo pacman -Syu

# install necessary packages
echo "Installing necessary packages..."
sudo pacman -S --needed alacritty feh dunst picom polybar i3-wm zsh stow git

# install neovim from source
echo "Install neovim from source..."
sudo pacman -S base-devel cmake unzip ninja curl
cd /opt
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
git checkout stable
sudo make install

# go to home directory
cd ~

# Clone the .dotfiles repository
echo "Cloning .dotfiles repository..."
git clone $DOTFILES_REPO .dotfiles

# go to .dotfiles directory
cd ~/.dotfiles

# pull latest changes from the repository and update submodules
echo "Updating repository and submodules..."
git pull origin master
git submodule update --init --recursive

# stow configuration files
echo "Stowing configuration files..."
for dir in alacritty bin dunst i3 nvim picom polybar Xresources zsh
do
  stow -R $dir
done

# install fonts
echo "Installing fonts..."
sudo mkdir -p /usr/share/fonts/FiraCode/
sudo mkdir -p /usr/share/fonts/MaterialSymbols/
sudo cp fonts/MaterialSymbols-Rounded.ttf /usr/share/fonts/MaterialSymbols/
sudo cp fonts/FiraCode-* /usr/share/fonts/FiraCode/
fc-cache -fv

# install fonts
echo "get and set wallpaper..."
sudo mkdir -p /usr/share/fonts/FiraCode/
sudo mkdir -p /usr/share/fonts/MaterialSymbols/
sudo cp wallpaper/wallpaper.png ~/.config/i3/wallpaper.png

echo "All tasks completed successfully!"

