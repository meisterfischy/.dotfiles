#/bin/bash

FILES=files
olddir=.dotfiles_old
home=$(echo $HOME | sed 's/\//\\\//g')

if [ "$#" -ne 1 ]; then
    echo "Expected one argument: arch | think"
    exit 2
fi

echo "Generating config files from templates"
for template in `find $FILES -name "*.j2"`; do
    cfg=$(echo $template | sed 's/.j2/_gen/')
    python ./fill_template.py $template $1 > $cfg
done

echo "Creating fodlers"
for folder in `find $FILES -mindepth 1 -type d`; do
    mkdir -p $(echo $folder | sed 's/files/'$home'/')
done

echo "Creating syslinks to config files"
for file in `find $FILES -mindepth 1 -type f -not -name "*.j2"`; do
    dest=$(echo $file | sed 's/files/'$home'/')
    if [[ $file == *_gen ]]; then
        dest=$(echo $dest | sed 's/\(.*\)_gen/\1/')
    fi
    if [ -L $dest ]; then
        rm $dest
    fi
    ln -s $(pwd)\/$file $dest
done
