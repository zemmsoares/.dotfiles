export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="sorin"

plugins=(
    git 
    docker
    z
    history
    web-search
    colored-man-pages
    #zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.local/bin/scripts"

# User configuration
export PATH=$PATH:/opt/stripe