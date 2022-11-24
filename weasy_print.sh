#!/bin/bash

set -x

PDF_DIR=PDFs

sed -i -e "s/’/\'/g" -e "s/–/-/g" -e "s/“/\"/g" -e "s/”/\"/g" $1.html

docker run -it --name weasy -d 4teamwork/weasyprint:56.1
docker cp codeblock_wrap.css weasy:/tmp/codeblock_wrap.css
docker exec -i weasy weasyprint -v -s /tmp/codeblock_wrap.css '-' '-' >| "$PDF_DIR/$1.pdf" <$1.html
docker stop weasy
docker rm -f weasy
