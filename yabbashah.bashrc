# =================================================================================================
# YABBASHAH
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

# Deep Twilight
PROMPT_FG="\[\e[38;2;3;4;94m\]"
# Bright Teal Blue
PROMPT_USER="\[\e[38;2;0;119;182m\]"
# Turquoise Surf
PROMPT_DIR="\[\e[38;2;0;180;216m\]"
# Frosted Blue
PROMPT_TIME="\[\e[38;2;144;224;239m\]"
# Light Cyan
PROMPT_ARROW="\[\e[38;2;202;240;248m\]"

set_prompt
