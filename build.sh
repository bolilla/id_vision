#/bin/sh

NOW=`date +%s`
FILE=$NOW-id_vision
TMP=tmp
mkdir -p $TMP
ls *.md | xargs cat > $TMP/$FILE.md
pandoc $TMP/$FILE.md -f markdown -t html -s -o $TMP/$FILE.html
