require(FactoMineR)
require(ggplot2)
require(foreign)

# Données sources : 


setwd("D:/users/vivien.roussez/Documents/Groupe référents R/Module ADD/Exercices")

dat <- read.csv('ACM.csv',header = T,sep=';',skip=1)

exploit <- dat[dat$rapport_analyses!="",-c(30)]

row.names(exploit)<- paste(exploit$orga,1:nrow(exploit))
# row.names(exploit)<-1:nrow(exploit) # Version anonymisée 


        ### 1 - Préparation des données ###

# On considère que ceux qui ont répondu à la question sur "analyses" 
# et qui n'ont rien coché ensuite pour les détails ont répondu "Pas du tout"
# ie, quelqu'un qui dit lire les analyses et qui n'a pas répondu à la question sur la lecture des tableaux
# ne lit pas les tableaux


for (i in 6:11) {
  levels(exploit[,i])[levels(exploit[,i])==""]  <- "Pas du tout"
}

for (i in 13:20) {
  levels(exploit[,i])[levels(exploit[,i])==""]  <- "Aucune"
}

exploit <- droplevels(exploit)

for (i in c(6:11,13:20))
{
  print(100*prop.table(table(exploit[,i])))
}
rm(i)

          ### 2 - ACM ###
      
acm.dat <- exploit[,c(1,6:11,13:20)]
acm <- MCA(acm.dat)
mean(acm$eig$eigenvalue)
barplot(acm$eig$eigenvalue,horiz = T,main="Histogramme des valeurs propres",
        xlab = "Pourcentage de l'inertie totale",col="lightblue",border = "grey")
summary(acm)

acm <- MCA(acm.dat,quali.sup = c(1,8:15),ncp=4)
plot.MCA(acm,cex=.7,selectMod = "cos2 10",select = "contrib 20")
plot.MCA(acm,axes=c(3,4),cex=.7,selectMod = "cos2 10",select = "contrib 20")
dimdesc(acm,axes = 1:4)
