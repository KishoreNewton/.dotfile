# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Load vcs_info for Git branch information
autoload -Uz vcs_info
precmd() { vcs_info }

# Function to check uncommitted changes
zsh_git_prompt() {
    if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
        if [[ -n $(git status -s 2>/dev/null) ]]; then
            echo "%F{red}✘%f"
        else
            echo "%F{green}✔%f"
        fi
    fi
}

# Customize the vcs_info message format
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'

# Set the prompt with custom arrow icon
PROMPT='%F{156}➜ %1~%f${vcs_info_msg_0_}$(zsh_git_prompt) '
RPROMPT='%F{121}%D{%I:%M:%S %p}%f'


# Function to update the right prompt
update_rprompt() {
    RPROMPT='%F{121}%D{%I:%M:%S %p}%f'
    PROMPT='%F{156}➜ %1~%f${vcs_info_msg_0_}$(zsh_git_prompt) '
}

# Call the update_rprompt function before each prompt
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_rprompt

# Function to reset the prompt if ZLE is active
reset_prompt_if_zle() {
    if [[ -o interactive ]]; then
        zle && zle reset-prompt
    fi
}

# Load zsh/sched module
zmodload zsh/sched

# Schedule the prompt reset function
sched_prompt_reset() {
    sched +1 sched_prompt_reset
    reset_prompt_if_zle
}

sched +1 sched_prompt_reset

# List of plugins used
plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting z autojump web-search docker kubectl npm python thefuck tmux vi-mode history fasd dirhistory)
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
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

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

# Helpful aliases
# alias  l='eza -lh  --icons=auto' # long list
alias l='eza -1   --icons=auto' # short list
alias lt='ls -lt created' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code --disable-gpu' # gui code editor

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/bin/python:$PATH"

eval "$(github-copilot-cli alias -- "$0")"

export PATH=$PATH:$HOME/go/bin


