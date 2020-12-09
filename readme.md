# Parcours R - Supports pédagogiques pour la formation à R au sein du MTES/MCTRCT (et au-délà)

[![Build Status](https://travis-ci.org/MTES-MCT/parcours-r.svg?branch=master)](https://travis-ci.org/MTES-MCT/parcours-r)

## Se former à R

Ce dépôt contient les supports pédagogiques de la formation R en version Rmd. Il permet aux référents R de construire et mettre à jour les modules de formation. L'outil Travis-Ci est utilisé pour compiler les fichiers Rmd en support au format HTML. Ces supports sont ensuite copiés sur la branche `gh-pages`.

## Journal

09/12/2020
* ajout d'un repo pour chaque module de formation
* modification de la marianne

30/08/2019
* ajout d'un script pour ne compiler les modules dont les sources ont évolué
* ajout d'un répertoire front pour la page d'accueil (index.html) et les éléments associés

23/08/2019
* optimisation de la création des supports : activation des caches `knitr` et travis-ci

16/08/2019
* gérer la fermeture de rawgit : mise en place d'un branche `gh-pages` qui contient les supports HTML/PDF/ePub générés à partir des `Rmd`
* nettoyage de l'arborescence : suppression des fichiers de la branche `master` rendus inutiles

15/02/2019
* init (modules socle et à la carte : de 1 à 5)
* ajout d'une page index de présentation

