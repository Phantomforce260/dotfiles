# =================================================================================================
# Common aliases & config sourced by both zsh and bash
# =================================================================================================

export DNS_SERVER=192.168.1.6
export LF_GIT=git.lunarflame.dev/docker

alias whereami="curl ipinfo.io"

# Docker
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# Python
alias py='python3'
alias venv="source venv/bin/activate"

# LS
alias l="ls -l"
alias la='ls -a'
alias ll='ls -alF'

# Miscellaneous
alias cl='clear'

alias bashrc='vim ~/.bashrc && source ~/.bashrc'

export PATH="$PATH:$HOME/.config/git-tools/bash"
export PATH="$PATH:$HOME/.local/bin"
