#!/bin/sh

set -ev

# Compilation du module 3
cd ./Supports_formations/m3_stats_desc/
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

