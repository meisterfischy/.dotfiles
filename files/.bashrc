#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH:$HOME/.local/bin"

alias ls='ls --color=auto'
alias ssh="TERM=xterm-color ssh"
alias sudo='sudo -v; sudo '
alias st='cd /home/koe/Studium/$(current_semester)'

function current_semester() {
    max=""
    for sem in $(ls "$HOME/Studium" | grep -E "(So)|(Wi)Se[[:digit:]]{2}")
    do
        if [[ ${#max} -lt 6 || ${sem:4:6} -gt ${max:4:6} || $sem < $max ]]; then
            max=$sem
        fi
    done
    echo "$max"
}

function nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

export PS1="[\[\e[31m\]\`nonzero_return\`\[\e[m\]] \[\e[36m\]\u\[\e[m\] \[\e[35m\]\w\[\e[m\]\n\$ "

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
