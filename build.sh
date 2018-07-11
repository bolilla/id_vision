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
pandoc $TMP/$FILE.md -f markdown $TOC -t html -s -o $TMP/LATEST-$INTERFIX.html
pandoc $TMP/$FILE.md -f markdown $TOC -s -o $TMP/LATEST-$INTERFIX.docx
pandoc -N --template=template.tex --variable mainfont="Palatino" --variable sansfont="Helvetica" --variable monofont="Menlo" --variable fontsize=12pt --variable version=0.1.$NOW tmp/LATEST-id_vision.md --pdf-engine=xelatex --toc -o $TMP/LATEST-$INTERFIX.pdf
