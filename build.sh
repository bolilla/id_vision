#/bin/sh

NOW=`date +%s`
INTERFIX=id_vision
FILE=$NOW-$INTERFIX
TMP=tmp
TOC="--toc --toc-depth=4"
mkdir -p $TMP
for file in `ls src/*.md`
do
  (cat "${file}"; echo) >> $TMP/$FILE.md
done
cp $TMP/$FILE.md $TMP/LATEST-$INTERFIX.md
#pandoc $TMP/$FILE.md -f markdown $TOC -t html -s -o $TMP/$FILE.html
pandoc $TMP/$FILE.md -f markdown $TOC -t html -s -o $TMP/LATEST-$INTERFIX.html
pandoc $TMP/$FILE.md -f markdown $TOC -s -o $TMP/LATEST-$INTERFIX.docx
pandoc $TMP/$FILE.md -f markdown $TOC -s -o $TMP/LATEST-$INTERFIX.pdf
