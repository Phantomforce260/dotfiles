# =================================================================================================
# BLOCK VMs + TARTARUS HOST (thebel, arqa, yabbashah, tziah, harabah, adamah, tartarus)
# =================================================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
        *) return;;
esac

# Short hostname, used below to select the per-host colour palette
BLOCK_HOST="${HOSTNAME:-$(hostname)}"
BLOCK_HOST="${BLOCK_HOST%%.*}"

# Source common aliases/config shared with zsh
COMMON_DIR="$HOME/.config/dotfiles"

# tziah sources the common files with `source` instead of the guarded `.`
# form used below -- this works around a sourcing bug. Keep it as-is.
if [ "$BLOCK_HOST" = "tziah" ]; then
    source "$COMMON_DIR/shell_common.sh"
    source "$COMMON_DIR/bash_common.sh"
else
    [ -f "$COMMON_DIR/shell_common.sh" ] && . "$COMMON_DIR/shell_common.sh"
    [ -f "$COMMON_DIR/bash_common.sh" ] && . "$COMMON_DIR/bash_common.sh"
fi

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

# tziah needs /sbin and /usr/sbin on the PATH
if [ "$BLOCK_HOST" = "tziah" ]; then
    echo $PATH | grep -Eq "(^|:)/sbin(:|)" || PATH=$PATH:/sbin
    echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin
fi

# =================================================================================================
# Bash Prompt -- colour palette chosen per host
# =================================================================================================

case "$BLOCK_HOST" in
    thebel)
        # From https://coolors.co/palette/22577a-38a3a5-57cc99-80ed99-c7f9cc
        # Baltic Blue
        PROMPT_FG="\[\e[38;2;34;87;122m\]"
        # Tropical Teal
        PROMPT_USER="\[\e[38;2;56;163;165m\]"
        # Mint Leaf
        PROMPT_DIR="\[\e[38;2;87;204;153m\]"
        # Light Green
        PROMPT_TIME="\[\e[38;2;128;237;153m\]"
        # Tea Green
        PROMPT_ARROW="\[\e[38;2;199;249;204m\]"
        ;;
    arqa)
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
        ;;
    yabbashah)
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
        ;;
    tziah)
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
        ;;
    harabah)
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
        ;;
    adamah)
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
        ;;
    necronomicon)
        # Thebel
        PROMPT_FG="\[\e[38;2;130;175;120m\]"
        # Harabah
        PROMPT_USER="\[\e[38;2;114;71;58m\]"
        # Arqa
        PROMPT_DIR="\[\e[38;2;92;87;123m\]"
        # Yabbashah
        PROMPT_TIME="\[\e[38;2;94;161;148m\]"
        # Tziah
        PROMPT_ARROW="\[\e[38;2;187;190;133m\]"
        ;;
    *)
        # Unknown host: neutral grey palette
        PROMPT_FG="\[\e[38;2;142;154;175m\]"
        PROMPT_USER="\[\e[38;2;192;199;211m\]"
        PROMPT_DIR="\[\e[38;2;210;221;239m\]"
        PROMPT_TIME="\[\e[38;2;234;242;255m\]"
        PROMPT_ARROW="\[\e[38;2;221;234;255m\]"
        ;;
esac

set_prompt
