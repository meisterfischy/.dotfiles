for f in $HOME/.files/xinitrc.d/*; do
	# Some scripts require bash, but .xinitrc is sourced from sh.
	# If a script is marked executable, it is executed instead of sourced.
	[ -x "$f" ] && "$f" || . "$f"
done
unset f
