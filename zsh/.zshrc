export ZSH="$HOME/.oh-my-zsh"
export ANDROID_HOME="/home/zm/Android/Sdk/"
export PATH=$PATH:/home/zm/.local/bin
# composedr tailpress
export PATH="$PATH:/home/zm/.config/composer/vendor/bin"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#custom aliases
alias vim='nvim'

alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'

