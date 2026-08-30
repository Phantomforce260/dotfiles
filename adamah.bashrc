# =================================================================================================
# ADAMAH
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

# From https://coolors.co/palette/8e9aaf-c0c7d3-d2ddef-eaf2ff-ddeaff

# Lavender Grey
PROMPT_FG="\[\e[38;2;142;154;175m\]"

# Pale Slate
PROMPT_USER="\[\e[38;2;192;199;211m\]"

# Lavender
PROMPT_DIR="\[\e[38;2;210;221;239m\]"

# Alice Blue
PROMPT_TIME="\[\e[38;2;234;242;255m\]"

# Lavender
PROMPT_ARROW="\[\e[38;2;221;234;255m\]"

set_prompt
