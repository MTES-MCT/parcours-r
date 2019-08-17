# Programme d'exemple pour la présentation de RStudio

# Supprime tous les objets de l'environnement de travail
rm (list = ls ())

# Définition du répertoire de travail
setwd ("C:/Users/pirz/GitHub/parcours-r/m1_socle_book/Presentation RStudio")

# Liste les fichiers du répertoire de travail
dir ()

# Activation du package "tidyverse"
library (tidyverse)

# Import d'un CSV
rp_2012 <- read.table (file = "rp_2012.csv", header = T, sep = ";", dec = ",")

# Affichage du tableau
View (rp_2012)

# Variable de département à modifier
dept <- "31"
lib_dept <- "Haute-Garonne"

# Création d'un sous-ensemble départemental
rp_2012_dept <- filter (rp_2012, str_sub (com, 1, 2) == dept)
rp_2012_dept <- select (rp_2012_dept, com, superficie, pop_mun, nb_res_princ, nb_res_sec, nb_lgt_vac, 
                        nb_lgt_indiv, nb_lgt_collect, nb_lgt_1_2_piece, nb_lgt_3_4_piece, nb_lgt_5plus_piece)
View(rp_2012_dept)

# Calculs divers
surperficie_moyenne <- round (mean (rp_2012$superficie), 2)
pop_mun_totale <- sum (rp_2012$pop_mun)
pop_mun_totale_dept <- sum (rp_2012_dept$pop_mun)

# Affichage d'un résultat
print (paste ("La population municipale du département",
              lib_dept,
              "est de",
              pop_mun_totale_dept,
              "habitants"))

# Recherche d'aide
help (plot)

# Affichage d'un graphique
ggplot (data = rp_2012, aes (x = nb_lgt_indiv, y = nb_resprinc_prop)) + geom_point(col = "blue") +
  xlim (0, 15000) + ylim (0, 30000) +
  ggtitle ("Type des logements et statut des habitants") +
  xlab ("Nb. de lgts. indiv. par commune") + ylab ("Nb. de propriétaires occupants") +
  geom_abline (col = "red")
  
  

