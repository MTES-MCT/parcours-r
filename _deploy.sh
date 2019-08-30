#!/bin/sh

set -e

git config --global user.email "stephane.trainel@gmail.com"
git config --global user.name "Stéphane Trainel"
git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git output

# Suppresion des fichiers pour maintenir un espace le plus propre possible
rm -fr ./output/*

# Copie des fichiers par module
cp -r ./Supports_formations/m1_socle/_book ./output/
mv ./output/_book ./output/m1
cp -r ./Supports_formations/m1_socle/_bookdown_files ./output/m1/

cp -r ./Supports_formations/m2_preparation_donnees/_book ./output/
mv ./output/_book ./output/m2
cp -r ./Supports_formations/m2_preparation_donnees/_bookdown_files ./output/m2/

cp -r ./Supports_formations/m3_stats_desc/_book ./output/
mv ./output/_book ./output/m3
cp -r ./Supports_formations/m3_stats_desc/_bookdown_files ./output/m3/

cp -r ./Supports_formations/m4_analyse_donnees/_book ./output/
mv ./output/_book ./output/m4
cp -r ./Supports_formations/m4_analyse_donnees/_bookdown_files ./output/m4/

cp -r ./Supports_formations/m5_valorisation_des_donnees/_book ./output/
mv ./output/_book ./output/m5
cp -r ./Supports_formations/m5_valorisation_des_donnees/_bookdown_files ./output/m5/

# Copie des fichiers communs
cp -r ./documents ./front/assets ./front/semantic ./front/index.html ./output/

# Publication des fichiers sur la branche "gh-pages" de GitHub
cd output
git add --all -f ./*
git commit --allow-empty -m"Update site - build by travis-ci (#${TRAVIS_BUILD_NUMBER})"
git push origin gh-pages