export CONFIG="$HOME/.config"

# Source common aliases/config shared with bash
COMMON_DIR="$CONFIG/dotfiles"
[ -f "$COMMON_DIR/shell_common" ] && . "$COMMON_DIR/shell_common"

# =================================================================================================
# ZSHRC
# =================================================================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"
# Honorable Mentions:
#   - agnosterzak

COLORIZE_STYLES=(
    "one-dark"
    "gruvbox-dark"
    "nord"
    "material"
    "dracula"
    "github-dark"
)

# Supports all pygment styles. Check with:
# 
# pygmentize -L styles
ZSH_COLORIZE_STYLE="${COLORIZE_STYLES[$(( RANDOM % ${#COLORIZE_STYLES[@]} ))]}"

plugins=(
    # Prepend sudo to a command by pressing <Esc> twice.
    sudo

    # Syntax highlighting in the terminal.
    colorize

    # Show color for man pages.
    colored-man-pages

    # Interactive menu for changing directories.
    zsh-interactive-cd

    # External Plugins

    # Suggests commands based on history.
    zsh-autosuggestions

    # Highlights commands .
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
PROMPT_EOL_MARK=''

# =================================================================================================
# Pokemon Colorscripts
# =================================================================================================

# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos

# Display a random shiny pokemon
{ pokemon-colorscripts --no-title -s -r } </dev/null

# =================================================================================================
# fastfetch
# =================================================================================================

# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# =================================================================================================
# LS
# =================================================================================================

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias lla='ls -la'
alias lt='ls --tree'

# =================================================================================================
# Bun
# =================================================================================================

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =================================================================================================
# Node
# =================================================================================================

export NVM_DIR="$HOME/.nvm"

lazy_load_nvm() {
    if command -v node >/dev/null 2>&1 && [[ "$PATH" == *"$NVM_DIR"* ]]; then
        return
    fi

    unset -f node npm npx nvm 2>/dev/null || true

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

node() {
    lazy_load_nvm
    command node "$@"
}

npm() {
    lazy_load_nvm
    command npm "$@"
}

npx() {
    lazy_load_nvm
    command npx "$@"
}

nvm() {
    lazy_load_nvm
    command nvm "$@"
}

nvim() {
    lazy_load_nvm
    command nvim "$@"
}

# =================================================================================================
# Custom PATHs
# =================================================================================================

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

eval "$(zoxide init zsh)"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

rustup() {
    source "$HOME/.cargo/env"
    command rustup "$@"
}

cargo() {
    source "$HOME/.cargo/env"
    command cargo "$@"
}

# =================================================================================================
# Aliases
# =================================================================================================

alias cd="z"
alias cat="ccat"

alias ssh="kitty +kitten ssh"

alias zshrc="nvim ~/.zshrc && clear && source ~/.zshrc"

alias cl="clear && exec zsh"

pkmn_cache() {
    { pokemon-colorscripts --no-title -s -r } </dev/null > ~/.config/fastfetch/pkmn-cache.txt
    command fastfetch "$@"
}

alias fastfetch=pkmn_cache
alias ff=pkmn_cache
alias neofetch=pkmn_cache

alias enable-wg="sudo wg-quick up polaris"
alias disable-wg="sudo wg-quick down polaris"

alias acli="arduino-cli"
alias pkmn="pokemon-colorscripts"

alias weather="$CONFIG/hypr/shell/user/Weather.sh"

APP_IMAGES="$HOME/Documents/AppImages"

alias edex="$APP_IMAGES/edex.AppImage --no-sandbox"
alias prism="$APP_IMAGES/prism.AppImage & disown"

alias intellij="$HOME/.intellij/bin/idea & disown"
alias update-hwmon="bun $CONFIG/waybar/js/build.js"

# =================================================================================================
# Custom Scripts
# =================================================================================================

# Safe RM
safe_rm() {
    local trash_dir="$HOME/.local/share/Trash/files"
    mkdir -p "$trash_dir"
    local timestamp
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

    local items=()

    # Filter out rm options like -r, -f, -rf, etc.
    for arg in "$@"; do
        case "$arg" in
            -r|-rf|-fr|-f) 
              # Ignore these flags, they're not needed since mv handles directories
              ;;
            --) 
              # Explicit end of options, rest are files
              shift
              items+=("$@")
              break
              ;;
            -*)
              echo "safe_rm: unrecognized option '$arg' (ignored)" >&2
              ;;
            *)
              items+=("$arg")
              ;;
        esac
    done

    # Move the actual files/directories
    for item in "${items[@]}"; do
        if [ -e "$item" ]; then
            mv "$item" "$trash_dir/$(basename "$item")_$timestamp"
        else
            echo "rm: cannot remove '$item': No such file or directory" >&2
        fi
    done
}
alias rm='safe_rm'

empty-trash() {
    local trash_dir="$HOME/.local/share/Trash/files"
    local info_dir="$HOME/.local/share/Trash/info"
    local reply

    # Ensure directories exist
    mkdir -p "$trash_dir" "$info_dir"

    # If both are empty, report and exit
    if [ -z "$(ls -A "$trash_dir" 2>/dev/null)" ] && [ -z "$(ls -A "$info_dir" 2>/dev/null)" ]; then
        echo "Trash is already empty."
        return 0
    fi

    # Cross-shell prompt: zsh vs bash-compatible read
    if [ -n "$ZSH_VERSION" ]; then
        # zsh: 'read "reply?prompt"' reads a line into $reply with prompt
        read "reply?Are you sure you want to permanently delete all files in Trash? [y/N] "
    else
        # bash / others
        read -r -p "Are you sure you want to permanently delete all files in Trash? [y/N] " reply
    fi

    case "$reply" in
        [Yy]|[Yy][Ee][Ss])
            # Safely remove contents of trash directories without removing the directories themselves.
            # Use find -delete where available; fallback to safe glob patterns to avoid errors when empty.
            if command -v find >/dev/null 2>&1; then
                find "$trash_dir" -mindepth 1 -delete 2>/dev/null || true
                find "$info_dir" -mindepth 1 -delete 2>/dev/null || true
            else
                rm -rf -- "$trash_dir"/* "$trash_dir"/.[!.]* "$trash_dir"/..?* 2>/dev/null || true
                rm -rf -- "$info_dir"/* "$info_dir"/.[!.]* "$info_dir"/..?* 2>/dev/null || true
            fi
            echo "Trash emptied."
            ;;
        *)
            echo "Canceled."
            ;;
    esac
}

fork() {
    kitten @ launch --type=tab --cwd=current
}
