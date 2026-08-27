fastfetch

# zsh word chars (exclude / and . so Ctrl+W breaks paths by segment)
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

export EDITOR="/usr/bin/helix"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export NODE_MODULES_GLOBAL="$(npm root -g)"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
_select-right() { [[ $REGION_ACTIVE -eq 0 ]] && zle set-mark-command; zle .forward-char }
_select-left()  { [[ $REGION_ACTIVE -eq 0 ]] && zle set-mark-command; zle .backward-char }
_select-word-right() { [[ $REGION_ACTIVE -eq 0 ]] && zle set-mark-command; zle .forward-word }
_select-word-left()  { [[ $REGION_ACTIVE -eq 0 ]] && zle set-mark-command; zle .backward-word }

zle -N _select-right
zle -N _select-left
zle -N _select-word-right
zle -N _select-word-left

bindkey "\e[1;2C" _select-right
bindkey "\e[1;2D" _select-left
bindkey "\e[1;6C" _select-word-right
bindkey "\e[1;6D" _select-word-left

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias sudo="sudo "
alias pls="sudo "
alias hx="helix "
alias ls="lsd"
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rsn'
alias check='pacman -Qs'
alias search='pacman -Ss'
alias pm='pacman'
alias shutdown='sudo shutdown now'
alias reboot='sudo reboot now'
alias cu='cachy-update'
alias c="clear && fastfetch"

alias dstart='sudo systemctl start docker'
alias dstop='sudo systemctl stop docker.socket docker'
alias dcu='docker compose up -d'
alias dcb='docker compose up --build -d'
alias dcd='docker compose down'
alias dps='docker ps'

xampp() {
    case "$1" in
        start)   sudo /opt/lampp/lampp start ;;
        stop)    sudo /opt/lampp/lampp stop ;;
        restart) sudo /opt/lampp/lampp restart ;;
        *)       echo "Usage: xampp {start|stop|restart}" ;;
    esac
}

fan() {
    case "$1" in
        max)  sudo /usr/local/bin/omencore-cli fan -p max ;;
        auto) sudo /usr/local/bin/omencore-cli fan -p auto ;;
        *)    echo "Usage: fan {auto|max}" ;;
    esac
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

eval "$(zoxide init zsh)"
