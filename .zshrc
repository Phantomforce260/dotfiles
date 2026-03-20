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
    # Shortcuts for git controls.
    git

    # Shortcuts for docker compose.
    docker-compose

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
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# =================================================================================================
# Bun
# =================================================================================================

[ -s "/home/adrian/.bun/_bun" ] && source "/home/adrian/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =================================================================================================
# Custom PATHs
# =================================================================================================

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.config/git-tools"

eval "$(zoxide init zsh)"

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

alias whereami="curl ipinfo.io"

alias enable-wg="sudo wg-quick up adri-linux"
alias disable-wg="sudo wg-quick down adri-linux"

alias py="python3"
alias acli="arduino-cli"
alias pkmn="pokemon-colorscripts"
alias ssh-home="ssh -p 2222 adrian@ssh.local.lunarflame.dev"

alias weather="$HOME/.config/hypr/shell/user/Weather.sh"

alias php-dev-lfs="$HOME/Documents/Projects/shell/php_dev_lfs.sh"

APP_IMAGES="$HOME/Documents/AppImages"

alias edex="$APP_IMAGES/edex.AppImage --no-sandbox"
alias prism="$APP_IMAGES/prism.AppImage & disown"

alias intellij="$HOME/.intellij/bin/idea & disown"
alias update-hwmon="bun $HOME/.config/waybar/js/build.js"

# =================================================================================================
# Custom Scripts
# =================================================================================================

# WPI stuff

alias ssh-wpi="ssh -i ~/.ssh/student-cs2011 -p 9308 student@secnet-gateway.cs.wpi.edu"
scp-wpi() {
    vm_addr="student@secnet-gateway.cs.wpi.edu:/home/student/Downloads"

    if [ -z "$1" ]; then
        echo "Incorrect Format."
        echo "Correct Usage: scp-wpi <to/from> <file>"
        return 1
    elif [ -z "$2" ]; then
        echo "No file specified for copy"
        return 1
    elif [[ "$1" == "to" ]]; then
        scp -i ~/.ssh/student-cs2011 -P 9308 "$2" "$vm_addr"
    elif [[ "$1" == "from" ]]; then
        scp -i ~/.ssh/student-cs2011 -P 9308 $vm_addr/$2 $HOME/Downloads
    else
        echo "Error."
    fi
}

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

update-discord() {
    deb_file=$(find "$HOME/Downloads" -maxdepth 1 -type f -name "discord-*.deb" | head -n 1)

    if [ -z "$deb_file" ]; then
        echo "No discord .deb package found in ~/Downloads"
        return 1
    fi

    echo "Installing $deb_file..."
    sudo dpkg -i "$deb_file"

    # If install succeeded, remove the file
    if [ $? -eq 0 ]; then
        echo "Removing $deb_file..."
        rm "$deb_file"
    else
        echo "Installation failed. Keeping the .deb file."
        return 1
    fi
}
