#/bin/bash

FILES=files

for template in `find $FILES -name "*.j2"`; do
    cfg=$(echo $template | sed 's/.j2//')
    python ./fill_template.py $template $1 > $cfg
done
