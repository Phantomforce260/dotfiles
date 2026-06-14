# =================================================================================================
# ARQA
# =================================================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source common aliases/config shared with zsh
COMMON_DIR="~/.config/dotfiles"
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

# Indigo
PROMPT_FG="\[\e[38;2;91;5;138m\]"
# Royal Violet
PROMPT_USER="\[\e[38;2;130;7;197m\]"
# Lavender Purple
PROMPT_DIR="\[\e[38;2;155;114;207m\]"
# Wisteria
PROMPT_TIME="\[\e[38;2;200;177;228m\]"
# Lavender Mist
PROMPT_ARROW="\[\e[38;2;244;239;250m\]"

set_prompt
