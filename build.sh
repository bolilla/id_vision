#/bin/sh

NOW=`date +%s`
INTERFIX=id_vision
FILE=$NOW-$INTERFIX
TMP=tmp
mkdir -p $TMP
ls src/*.md | xargs cat > $TMP/$FILE.md
pandoc $TMP/$FILE.md -f markdown -t html -s -o $TMP/$FILE.html
pandoc $TMP/$FILE.md -f markdown -t html -s -o $TMP/LATEST-$INTERFIX.html
pandoc $TMP/$FILE.md -f markdown -s -o $TMP/LATEST-$INTERFIX.docx
pandoc $TMP/$FILE.md -f markdown -s -o $TMP/LATEST-$INTERFIX.pdf
cp $TMP/$FILE.md $TMP/LATEST-$INTERFIX.md
