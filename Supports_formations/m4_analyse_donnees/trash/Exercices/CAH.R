require(FactoMineR)
require(ggplot2)

# On récupère les résultat de l'ACM

setwd("D:/users/vivien.roussez/Documents/Groupe référents R/Module ADD/Exercices")
source(file = "ACM.R")

# Et on fait la classification sur les coordonénées factorielles

hc <- HCPC(acm,nb.clust=5,graph=F)

barplot(hc$call$t$inert.gain[1:20],horiz = T,main="Gain d'inertie intra sur les 20 dernières agrégations ",
          col="lightblue",border = "grey")
table(hc$data.clust$clust)


plot(hc, choice = "map")
plot(hc, choice = "tree")
plot(hc, choice ="3D.map")

# Description par les variables
hc$desc.var$category

# Description par les individus
hc$desc.ind$para             # Parangons
hc$desc.ind$dist             # individus extrêmes
