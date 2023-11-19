#!/bin/bash

# Set the URL of the .dotfiles repository
DOTFILES_REPO_HTTPS="https://github.com/zemmsoares/.dotfiles"
DOTFILES_REPO_SSH="git@github.com:zemmsoares/.dotfiles.git"

# update system
echo "Updating system..."
sudo pacman -Syu

# install necessary packages
echo "Installing necessary packages..."
sudo pacman -S --needed alacritty feh dunst picom polybar i3-wm zsh stow git

# install neovim from source
#echo "Install neovim from source..."
#sudo pacman -S base-devel cmake unzip ninja curl
#cd /opt
#sudo git clone https://github.com/neovim/neovim
#sudo chown -R $USER:$USER neovim  # Change ownership to the current user
#cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
#sudo make install

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
for dir in alacritty bin dunst i3 nvim picom polybar Xresources zsh wallpaper
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

# Attempt to switch to SSH for future updates
echo "Attempting to switch to SSH..."
git remote set-url origin $DOTFILES_REPO_SSH

echo "All tasks completed successfully!"
