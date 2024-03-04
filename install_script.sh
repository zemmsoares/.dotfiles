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

#remove old configs
echo "Removing old configs"
rm -rf ~/.config/alacritty
rm -rf ~/.config/dunst
rm -rf ~/.config/picom
rm -rf ~/.config/wallpaper
rm -rf ~/.config/i3
rm -rf ~/.config/redshift
rm -rf ~/.config/polybar
rm -f ~/.zshrc
rm -f ~/.Xresources

# go to home directory
cd ~

# Clone the .dotfiles repository
echo "Cloning .dotfiles repository..."
git clone $DOTFILES_REPO_HTTPS .dotfiles

# go to .dotfiles directory
cd ~/.dotfiles

# pull latest changes from the repository and update submodules
echo "Updating repository and submodules..."
git pull origin master
git submodule update --init --recursive

# Removing old configs and installing necessary packages
echo "Removing old configs and installing necessary packages..."

# Stow config files
echo "Stowing configuration files..."
for dir in alacritty bin dunst i3 picom polybar Xresources zsh wallpaper redshift
do
  stow -R $dir
done

# install Neovim from source
read -p "Do you want to install Neovim from source? (y/N) " install_neovim
if [[ $install_neovim =~ ^[Yy]$ ]]; then
  echo "Removing old nvim config"
  rm -rf ~/.config/nvim
  echo "Installing Neovim from source..."
  sudo pacman -S base-devel cmake unzip ninja curl
  cd /opt
  sudo git clone https://github.com/neovim/neovim
  sudo chown -R $USER:$USER neovim
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
  sudo make install
  echo "Stowing nvim ..."
  stow nvim
fi

# Fonts
read -p "Do you want to install FiraCode? (y/N) " install_firacode
if [[ $install_firacode =~ ^[Yy]$ ]]; then
  echo "Installing FiraCode fonts..."
  sudo mkdir -p /usr/share/fonts/FiraCode/
  sudo cp fonts/FiraCode-* /usr/share/fonts/FiraCode/
  fc-cache -fv
fi

read -p "Do you want to install Material Symbols? (y/N) " install_materialsymbols
if [[ $install_materialsymbols =~ ^[Yy]$ ]]; then
  echo "Installing Material Symbols fonts..."
  sudo mkdir -p /usr/share/fonts/MaterialSymbols/
  sudo cp fonts/MaterialSymbols-Rounded.ttf /usr/share/fonts/MaterialSymbols/
  fc-cache -fv
fi

read -p "Do you want to install FontAwesome? (y/N) " install_fontawesome
if [[ $install_fontawesome =~ ^[Yy]$ ]]; then
  echo "Installing FontAwesome..."
  sudo mkdir -p /usr/share/fonts/FontAwesome/
  sudo cp fonts/Font Awesome 6 Brands-Regular-400.otf /usr/share/fonts/FontAwesome/
  fc-cache -fv
fi

# Attempt to switch to SSH for future updates
echo "Attempting to switch to SSH..."
git remote set-url origin $DOTFILES_REPO_SSH

echo "All tasks completed successfully!"
