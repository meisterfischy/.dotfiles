#
# ~/.bash_profile
#

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]]; then
   XKB_DEFAULT_LAYOUT=de exec sway
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
   exec startx
fi

export PATH=$PATH:/home/koe/.ghcup/bin:/home/koe/.cabal/bin/:/home/koe/.local/bin/

[[ -f ~/.bashrc ]] && . ~/.bashrc
