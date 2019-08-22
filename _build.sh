#!/bin/sh

set -ev

make all MODULES=m1_socle m3_stats_desc m4_analyse_donnees m5_valorisation_des_donnees

# pour générer l'ensemble des modules y compris mx_travail_collaboratif :
# make all
