# =================================================================================================
# BASIC
# =================================================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source common aliases/config shared with zsh
COMMON_DIR="$HOME/.config/dotfiles"
[ -f "$COMMON_DIR/shell_common" ] && . "$COMMON_DIR/shell_common"

# Source common bash config
[ -f "$COMMON_DIR/bash_common" ] && . "$COMMON_DIR/bash_common"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# =================================================================================================
# Bash Prompt
# =================================================================================================

PS1=$'\[\e[32m\]\u@\h\[\e[0m\] \[\e[2m\]│\[\e[0m\] \
\[\e[34m\]\w\[\e[0m\] \[\e[2m\]│\[\e[0m\] \
\[\e[33m\]$(est_time)\[\e[0m\]\n\
\[\e[35m\]$(git_branch)\[\e[0m\] \$ '
