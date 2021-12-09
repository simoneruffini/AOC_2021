#! /bin/sh

curl --silent https://pandoc.org/installing.html | pandoc --from html --to markdown_strict -o installing.md
