#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
############################

########## Variables

#['name']='install location relative to $HOME'
declare -A CONFIGS
CONFIGS=(   ["sway"]=".config"
            ["i3"]=".config"
            ["i3status"]=".config"
            ["rofi"]=".config"
            ["rofi-pass"]=".config"
            ["picom"]=".config"
            ["termite"]=".config"
            ["zathura"]=".config"
            ["nvim"]=".config"
            [".vimrc"]="."
            [".xinitrc"]="."
            [".bash_profile"]="."
    )

declare -A SETS
SETS=(      ["xorg"]="i3 i3status rofi rofi-pass picom termite zathura nvim .vimrc .xinitrc .bash_profile"
            ["wayland"]="sway rofi rofi-pass termite zathura nvim .vimrc .bash_profile"
    )

# dotfiles directory
dir=$HOME/.dotfiles

# old dotfiles backup directory
olddir=$HOME/.dotfiles_old

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p $olddir
echo "done"

for file in ${SETS[$1]}; do
    
    path="$HOME/${CONFIGS[$file]}/$file"
  
    # Checks if Link already exists 
    if [ -L $path ]; then
        echo "Link already exists"
        continue
    # Checks if file exists and then moves it to $olddir
    elif [ -e $path ]; then
        echo "Moving any existing dotfiles from $HOME to $olddir"
        mv $path $olddir
    fi
    # Creates symbolic link
    echo "Creating symlink to $file in ${CONFIGS[$file]}"
    ln -s $dir/$file $path

done
