# =================================================================================================
# NECRONOMICON
# =================================================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source common aliases/config shared with zsh
COMMON_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
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

# Colors from https://ansicolor.com/

# Bamboo
PROMPT_FG="\[\e[38;2;255;44;109m\]"
# Sprout
PROMPT_USER="\[\e[38;2;255;184;108m\]"
# Honey
PROMPT_DIR="\[\e[38;2;69;169;249m\]"
# Blush
PROMPT_TIME="\[\e[38;2;255;117;181m\]"
# Sky
PROMPT_ARROW="\[\e[38;2;25;249;216m\]"

set_prompt
