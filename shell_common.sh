# =================================================================================================
# Common aliases & config sourced by both zsh and bash
# =================================================================================================

export DNS_SERVER=192.168.1.6
export LF_GIT=git.lunarflame.dev/docker

alias whereami="curl ipinfo.io"

# Docker
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# Python
alias py='python3'

# LS
alias l="ls -l"
alias la='ls -a'
alias ll='ls -alF'

# Miscellaneous
alias cl='clear'

alias bashrc='vim ~/.bashrc && source ~/.bashrc'

export PATH="$PATH:$HOME/.config/git-tools/bash"
export PATH="$PATH:$HOME/.local/bin"

venv() {
    if [ ! -d "./venv" ]; then 
        while true; do
            echo -n "venv not found in this directory. Create new venv? [y/N]:"
            read -r response
            case "$response" in
                [Yy]* )
                    python3 -m venv venv;
                    echo "Created venv."
                    source ./venv/bin/activate
                    break ;;
                "" | [Nn]* )
                    echo "Abort."
                    break ;;
                * ) echo "Error: Invalid input [y/N]." ;;
            esac
        done
    else source ./venv/bin/activate
    fi
}

lzd() {
    local lzd_dir="$DOCKERFILES/tziah/lazydocker"
    docker compose --project-directory "$lzd_dir" -f "$lzd_dir/docker-compose.yml" run --rm lazydocker
}

lzg() {
    local lzg_dir="$DOCKERFILES/tziah/lazygit"
    local repo_root
    repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || repo_root="$(pwd)"
    docker compose --project-directory "$repo_root" -f "$lzg_dir/docker-compose.yml" run --rm lazygit
}

run_magick() {
    local bin="$1"; shift
    docker compose -f "$DOCKERFILES/tziah/magick/docker-compose.yml" run --rm -T \
        -v "$PWD:/imgs" \
        --entrypoint magick \
        imagemagick "$@"
}

magick()    { run_magick "$@"; }

convert()   { run_magick convert "$@"; }
mogrify()   { run_magick mogrify   "$@"; }
identify()  { run_magick identify  "$@"; }
montage()   { run_magick montage   "$@"; }
composite() { run_magick composite "$@"; }
compare()   { run_magick compare   "$@"; }

skopeo() {
    docker compose -f "$DOCKERFILES/tziah/skopeo/docker-compose.yml" run --rm -T \
        -v "$PWD:/work" -w /work \
        skopeo "$@"
}
