#==============================================================================
# ULTIMATE ZSH CONFIGURATION
# Features:
# - Fast startup with async loading
# - Modern, informative prompt
# - Enhanced completions and suggestions
# - Powerful productivity functions
# - Well-organized and fully documented
#==============================================================================

# Enable profiling if needed (uncomment to use)
# zmodload zsh/zprof
#
# Initialize Starship
eval "$(starship init zsh)"

#==============================================================================
# ESSENTIAL SETUP
#==============================================================================
# Path settings
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Default applications
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Set language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#==============================================================================
# ZINIT SETUP & CORE PLUGINS
#==============================================================================
# Initialize zinit
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing zinit...%f"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load zinit annexes
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Load essential Oh-My-Zsh libraries
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::directories.zsh

#==============================================================================
# PROMPT & APPEARANCE
#==============================================================================
# Powerlevel10k - A fast and customizable prompt
zinit ice depth=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#==============================================================================
# HISTORY CONFIGURATION
#==============================================================================
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

# History options
setopt EXTENDED_HISTORY          # Save timestamp and duration
setopt INC_APPEND_HISTORY        # Write immediately, not when shell exits
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first
setopt HIST_IGNORE_DUPS          # Don't record if same as previous command
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entries
setopt HIST_FIND_NO_DUPS         # Don't show duplicates in search
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries
setopt HIST_REDUCE_BLANKS        # Remove extra blanks
setopt HIST_VERIFY               # Don't execute immediately upon expansion

#==============================================================================
# PLUGINS (ASYNC LOADING)
#==============================================================================
# Fast syntax highlighting and suggestions
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

# Directory navigation, completions, and tools
zinit wait lucid for \
    agkozak/zsh-z \
    MichaelAquilina/zsh-you-should-use \
    zdharma-continuum/history-search-multi-word \
    paulirish/git-open \
    Aloxaf/fzf-tab

# Load completions
zinit wait lucid for \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Binary tools from GitHub releases
zinit wait lucid from"gh-r" as"program" for \
    sbin"bat/bat" @sharkdp/bat \
    sbin"fzf" junegunn/fzf \
    sbin"ripgrep/rg" BurntSushi/ripgrep

#==============================================================================
# COMPLETION SYSTEM
#==============================================================================
# Initialize completion
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':fzf-tab:complete:*' fzf-preview 'bat --color=always --line-range :50 {}'

#==============================================================================
# ENHANCED FUNCTIONS
#==============================================================================
# Advanced history search with fzf
function fzf_history_search() {
  local selected
  selected=$(fc -rl 1 | awk '{$1=""; print substr($0,2)}' | 
    fzf --height 40% --layout=reverse --border --color=border:blue --preview='echo {}' --preview-window=down:3:wrap)
  LBUFFER=$selected
  zle reset-prompt
}
zle -N fzf_history_search
bindkey '^R' fzf_history_search

# Directory jump with fuzzy search
function fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git . "${1:-.}" | 
    fzf --preview 'eza --tree --level=1 --color=always {}' --preview-window=right:50%) &&
    cd "$dir"
}

# Search files content and open in editor
function ff() {
  local file line
  read -r file line < <(rg --line-number --no-heading --color=always --smart-case "${*:-}" |
    fzf --ansi --delimiter : \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' |
    awk -F: '{print $1, $2}')
  if [[ -n "$file" ]]; then
    ${EDITOR:-vim} "$file" +$line
  fi
}

# One-command extract for common archives
function extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.tar.xz)    tar xJf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Improved package installation for Arch
function in() {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    # Detect the AUR helper
    if pacman -Qi paru &>/dev/null ; then
        aurhelper="paru"
    elif pacman -Qi yay &>/dev/null ; then
        aurhelper="yay"
    else
        echo "No AUR helper found. Install paru or yay first."
        return 1
    fi

    # Sort packages by repo
    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null ; then
            arch+=("${pkg}")
        else 
            aur+=("${pkg}")
        fi
    done

    # Install packages
    if [[ ${#arch[@]} -gt 0 ]]; then
        echo "Installing from official repositories: ${arch[@]}"
        sudo pacman -S --needed "${arch[@]}"
    fi
    
    if [[ ${#aur[@]} -gt 0 ]]; then
        echo "Installing from AUR: ${aur[@]}"
        ${aurhelper} -S --needed "${aur[@]}"
    fi
}

# Find command suggestions when not found
function command_not_found_handler() {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Create and enter directory in one command
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Universal system update
function update() {
    echo "📦 Starting system update..."
    
    # Determine package manager and update system packages
    if command -v paru &>/dev/null; then
        echo "⚙️ Updating with paru..."
        paru -Syu --noconfirm
    elif command -v yay &>/dev/null; then
        echo "⚙️ Updating with yay..."
        yay -Syu --noconfirm
    else
        echo "⚙️ Updating with pacman..."
        sudo pacman -Syu
    fi
    
    # Update zinit and plugins
    echo "🔌 Updating zinit plugins..."
    zinit self-update
    zinit update --parallel
    
    # Update other package managers if installed
    if command -v flatpak &>/dev/null; then
        echo "📄 Updating flatpak packages..."
        flatpak update -y
    fi
    
    if command -v snap &>/dev/null; then
        echo "📱 Updating snap packages..."
        sudo snap refresh
    fi
    
    # Clean up orphaned packages
    if command -v paru &>/dev/null || command -v yay &>/dev/null; then
        echo "🧹 Cleaning up orphaned packages..."
        pacman -Qtdq | sudo pacman -Rns - 2>/dev/null || echo "No orphaned packages to remove"
    fi
    
    # Clean package cache
    echo "🧼 Cleaning package cache..."
    if command -v paru &>/dev/null; then
        paru -Sc --noconfirm
    elif command -v yay &>/dev/null; then
        yay -Sc --noconfirm
    else
        sudo pacman -Sc --noconfirm
    fi
    
    echo "✅ System update complete!"
}

#==============================================================================
# ALIASES
#==============================================================================
# Detect AUR helper for package management
if pacman -Qi paru &>/dev/null; then
    aurhelper="paru"
elif pacman -Qi yay &>/dev/null; then
    aurhelper="yay"
else
    aurhelper="sudo pacman"
fi

# System and navigation
alias c='clear'
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias mkdir='mkdir -p'

# File operations with safeguards
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Enhanced directory listing (prefer eza, fallback to ls)
if command -v eza &>/dev/null; then
    alias ls='eza --icons=auto --group-directories-first'
    alias l='eza -l --icons=auto --group-directories-first'
    alias ll='eza -la --icons=auto --sort=name --group-directories-first'
    alias lt='eza --tree --level=2 --icons=auto'
    alias ld='eza -lD --icons=auto'
else
    alias ls='ls --color=auto'
    alias l='ls -lh'
    alias ll='ls -lha'
    alias ld='ls -lhd */'
fi

# Package management
alias un='$aurhelper -Rns'
alias up='$aurhelper -Syu'
alias pl='$aurhelper -Qs'
alias pa='$aurhelper -Ss'
alias pc='$aurhelper -Sc'
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --graph --oneline --decorate'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'

# Development
alias vc='code'
alias py='python3'
alias serve='python3 -m http.server 8000'

# System info
alias meminfo='free -h'
alias cpuinfo='lscpu'
alias diskinfo='df -h'
alias sysinfo='neofetch'

# Network
alias myip='curl -s https://ifconfig.me'
alias ports='sudo netstat -tulanp'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dimg='docker images'

#==============================================================================
# KEYBINDINGS
#==============================================================================
# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Navigation
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[1;5C' forward-word            # Ctrl+Right
bindkey '^[[1;5D' backward-word           # Ctrl+Left
bindkey '^[[H' beginning-of-line          # Home
bindkey '^[[F' end-of-line                # End
bindkey '^[[3~' delete-char               # Delete
bindkey '^K' kill-line                    # Kill to end of line
bindkey '^U' kill-whole-line              # Kill entire line

# History navigation
bindkey '^P' up-line-or-history           # Ctrl+P
bindkey '^N' down-line-or-history         # Ctrl+N
bindkey '^S' history-incremental-search-forward  # Ctrl+S

#==============================================================================
# EXTERNAL TOOL INTEGRATIONS
#==============================================================================
# FZF configuration
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=right:60%'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    export FZF_ALT_C_OPTS="--preview 'eza --tree {} | head -200'"
fi

# Google Cloud SDK
if [ -f "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc" ]; then 
    source "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then 
    source "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc"
fi

# GitHub Copilot CLI
if command -v github-copilot-cli &>/dev/null; then
    eval "$(github-copilot-cli alias -- "$0")"
fi

# The Fuck - command correction
if command -v thefuck &>/dev/null; then
    eval $(thefuck --alias)
fi

# Node Version Manager (lazy load)
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # Create lazy-load function to improve shell startup time
    function nvm_load() {
        [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    }
    # Define lazy loading functions for common Node commands
    function nvm() { nvm_load; nvm "$@"; }
    function npm() { nvm_load; npm "$@"; }
    function node() { nvm_load; node "$@"; }
    function npx() { nvm_load; npx "$@"; }
    function yarn() { nvm_load; yarn "$@"; }
fi

#==============================================================================
# LOAD LOCAL CONFIGURATIONS
#==============================================================================
# Source local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local0
