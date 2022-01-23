#
# ~/.bash_profile
#

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export GPG_TTY=$(tty)

[[ -f ~/.bashrc ]] && . ~/.bashrc
