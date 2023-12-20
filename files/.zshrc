HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

fpath=("$HOME/.zprompts" "$fpath[@]")
typeset -U path PATH
path=("$HOME/.cabal/bin" "$HOME/.ghcup/bin" "$HOME/.local/bin" "$path[@]")
export PATH

# Use vim mode
bindkey -v

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"

# Use only history entries matching the current lines
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Completion
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'
autoload -Uz compinit
compinit

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

autoload -Uz promptinit
promptinit

local fadebar_cwd="#EECFA1"
local userhost="#282a36"
local date="#EECFA1"
local bg=transparent

local -A schars
autoload -Uz prompt_special_chars
prompt_special_chars

PS1="%F{$fadebar_cwd}%B%K{$fadebar_cwd}$schars[333]$schars[262]$schars[261]$schars[260]%F{$userhost}%K{$fadebar_cwd}%B%n@%m%b%F{$fadebar_cwd}%K{$bg}$schars[333]$schars[262]$schars[261]$schars[260]%F{$date}%B %D{%a %b %d} %D{%I:%M:%S%P} $prompt_newline%F{$fadebar_cwd}%B%(?..[%F{#ffffff}%?%F{$fadebar_cwd}] )%~/%b%k%f "
PS2="%F{$fadebar_cwd}%K{$bg}$schars[333]$schars[262]$schars[261]$schars[260]%f%k>"

prompt_opts=(cr subst percent)


# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
    if [[ -a /var/cache/zsh/pacman ]]; then
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if (( zshcache_time < paccache_time )); then
            rehash
            zshcache_time="$paccache_time"
        fi
    fi
}

add-zsh-hook -Uz precmd rehash_precmd


mkcdir () {
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# Aliases
alias emacs="emacs -nw"
alias ls="ls --color=auto"
alias prolog="swipl"
alias ssh="TERM=xterm-color ssh"
alias sudo='sudo -v && sudo '
alias csgo='sway input "type:keyboard" xkb_options caps:escape > /dev/null'
alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias ua-update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && ua-drop-caches \
      && yay -Syyu --noconfirm'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
