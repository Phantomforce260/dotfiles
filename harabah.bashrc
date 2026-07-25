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

# Blood Red
PROMPT_FG="\[\e[38;2;106;4;29m\]"

# Warning Yellow
PROMPT_USER="\[\e[38;2;255;201;20m\]"

# Electric Blue
PROMPT_DIR="\[\e[38;2;30;46;222m\]"

# Nuclear Green
PROMPT_TIME="\[\e[38;2;83;255;69m\]"

# Hot Pink
PROMPT_ARROW="\[\e[38;2;240;6;153m\]"


set_prompt

#6a041d
#f00699
#1e2ede
#53ff45
#ffc914
