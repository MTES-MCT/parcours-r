#!/bin/sh

set -e

git config --global user.email "stephane.trainel@gmail.com"
git config --global user.name "Stéphane Trainel"
git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git output

rm -fr ./output/*

cp -r ./Supports_formations/m1_socle/_book ./output/
mv ./output/_book ./output/m1
cp -r ./Supports_formations/m1_socle/_bookdown_files ./output/m1/

cp -r ./Supports_formations/m2_preparation_donnees/_book ./output/
mv ./output/_book ./output/m2
cp -r ./Supports_formations/m2_preparation_donnees/_bookdown_files ./output/m2/

#cp -r ./Supports_formations/m3_stats_desc/_book ./output/
#mv ./output/_book ./output/m3
#cp -r ./Supports_formations/m3_stats_desc/_bookdown_files ./output/m3/

cp -r ./Supports_formations/m4_analyse_donnees/_book ./output/
mv ./output/_book ./output/m4
cp -r ./Supports_formations/m4_analyse_donnees/_bookdown_files ./output/m4/

cp -r ./Supports_formations/m5_valorisation_des_donnees/_book ./output/
mv ./output/_book ./output/m5
cp -r ./Supports_formations/m5_valorisation_des_donnees/_bookdown_files ./output/m5/


cp -r ./assets ./semantic index.html ./output/

cd output
git add --all -f ./*
git commit --allow-empty -m"Update site - build by travis-ci (#${TRAVIS_REPO_SLUG})"
git push origin gh-pages