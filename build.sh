#/bin/sh

NOW=`date +%s`
INTERFIX=id_vision
FILE=$NOW-$INTERFIX
BASE_VERSION=1.0
TMP=tmp
TOC="--toc --toc-depth=4"
mkdir -p $TMP
for file in `ls src/*.md`
do
  (cat "${file}"; echo) >> $TMP/$FILE.md
done
cp $TMP/$FILE.md $TMP/LATEST-$INTERFIX.md
pandoc $TMP/$FILE.md -f markdown $TOC -t html -s -o $TMP/LATEST-$INTERFIX.html
pandoc $TMP/$FILE.md -f markdown $TOC -s -o $TMP/LATEST-$INTERFIX.docx
pandoc -N --template=template.tex --variable mainfont="Palatino" --variable sansfont="Helvetica" --variable monofont="Menlo" --variable fontsize=12pt --variable version=$BASE_VERSION.$NOW tmp/LATEST-$INTERFIX.md --pdf-engine=xelatex --toc -o LATEST-$INTERFIX.pdf
