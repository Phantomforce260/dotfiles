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
[ -f "$COMMON_DIR/shell_common.sh" ] && . "$COMMON_DIR/shell_common.sh"

# Source common bash config
[ -f "$COMMON_DIR/bash_common.sh" ] && . "$COMMON_DIR/bash_common.sh"

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

GREEN="\[\e[32m\]"
DIM="\[\e[2m\]"
BLUE="\[\e[34m\]"
YELLOW="\[\e[33m\]"
MAGENTA="\[\e[35m\]"
RESET="\[\e[0m\]"

PS1="${GREEN}\u@\h${RESET} ${DIM}│${RESET} ${BLUE}\w${RESET} ${DIM}│${RESET} ${YELLOW}\$(est_time)${RESET} ${DIM}│${RESET}\n${MAGENTA}\$(git_branch)${RESET} \$ "
