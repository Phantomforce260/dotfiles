# =================================================================================================
# TZIAH
# =================================================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source common aliases/config shared with zsh
COMMON_DIR="$HOME/.config/dotfiles"
source "$COMMON_DIR/shell_common"
source "$COMMON_DIR/bash_common"

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

echo $PATH | grep -Eq "(^|:)/sbin(:|)" || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# =================================================================================================
# Bash Prompt
# =================================================================================================

# Sunflower Gold
PROMPT_FG="\[\e[38;2;253;184;51m\]"
# School Bus Yellow
PROMPT_USER="\[\e[38;2;253;196;63m\]"
# Bright Gold
PROMPT_DIR="\[\e[38;2;255;218;61m\]"
# Banana Cream
PROMPT_TIME="\[\e[38;2;255;233;78m\]"
# Canary Yellow
PROMPT_ARROW="\[\e[38;2;255;247;94m\]"

set_prompt
