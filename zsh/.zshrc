export ZSH="$HOME/.oh-my-zsh"
export ANDROID_HOME="/home/zm/Android/Sdk/"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#custom aliases
alias raid="scrcpy --tcpip=192.168.1.35 --max-size 1440 --window-title RAID --shortcut-mod ralt --turn-screen-off"

#Tracking dotfiles with Git
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
