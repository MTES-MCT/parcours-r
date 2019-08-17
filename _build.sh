#!/bin/sh

set -ev

# Compilation du module 1
cd ./Supports_formations/m1_socle/
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

# Compilation du module 2
cd ./Supports_formations/m2_preparation_donnees/
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

# Compilation du module 3
cd ./Supports_formations/m3_stats_desc/
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

# Compilation du module 4
cd ./Supports_formations/m4_analyse_donnees/
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..

# Compilation du module 4
cd ./Supports_formations/m5_valorisation_des_donnees/
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
cd ../..
