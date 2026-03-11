# =================================================================================================
# BASHRC
# =================================================================================================

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
# Aliases
# =================================================================================================

alias cl='clear'
alias ff='fastfetch'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias py='python3'
alias bashrc='vim ~/.bashrc && source ~/.bashrc'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable color support for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# =================================================================================================
# Bash Prompt
# =================================================================================================

# Uncomment for a colored prompt, if the terminal has the capability; turned off by default.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Colors from https://ansicolor.com/

WHITE="\[\e[38;5;255m\]"
GRAY="\[\e[38;5;244m\]"
RESET="\[\e[0m\]"

BAMBOO="\[\e[38;2;255;44;109m\]"
SPROUT="\[\e[38;2;25;249;216m\]"
HONEY="\[\e[38;2;255;184;108m\]"
BLUSH="\[\e[38;2;255;117;181m\]"
SKY="\[\e[38;2;69;169;249m\]"

# Powerline separator
SEP="${BAMBOO}"
SEP_NO_COL=""

est_time() {
    TZ="America/New_York" date "+%a %b %d, %H:%M"
}

git_branch() {
    # Default output
    local output="<>"

    # Only if we're in a git repo
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

        # Check for unstaged/staged changes
        if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
            branch="${branch}*"   # add asterisk if changes exist
        fi

        output="<git:(${branch})>"
    fi

    echo "${output}"
}

if [ "$color_prompt" = yes ]; then
    PS1="${BAMBOO}┌─${HONEY}\u${WHITE}@\h ${SEP} ${SKY}\w ${SEP} ${BLUSH}\$(est_time) ${SEP}\n${BAMBOO}└─[${SPROUT}\$${BAMBOO}] ${SPROUT}\$(git_branch) ${RESET}"
else
    PS1="┌─\u@\h ${SEP_NO_COL} \w ${SEP_NO_COL} \$(est_time) ${SEP_NO_COL}\n└─[\$] \$(git_branch)"
fi

unset color_prompt force_color_prompt
