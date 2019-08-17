#!/bin/sh

set -ev

cd ./Supports_formations/m1_socle/
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

  
cd ./Supports_formations/m2_preparation_donnees/
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

