require(FactoMineR)
require(ggplot2)
# Données sources : http://www.statistiques.developpement-durable.gouv.fr/fileadmin/documents/Themes/Transports/Vehicules_routiers/Immatriculations/resultats_detailles/2015/immatriculations-2015-2ir2.xls
# Simplement copiées et enregistrées dans un fichier CSV


setwd("D:/users/vivien.roussez/Documents/Groupe référents R/Module ADD/Exercices")

immat <- read.csv2(file='AFC_immat.csv',dec=',',h=T)  # Importation
immat <- immat[immat$Départements!="Total",-c(1,8)]   # On enlève la ligne qui correspond aux totaux
row.names(immat) <- immat$Départements                # On met les noms de départements en identifiant
immat[is.na(immat)] <- 0                              # On remplace les valeurs manquantes par un 0 (c'est pertinent dans notre cas)


# Utilisation de la fonction CA pour effectuer l'AFC à proprement parler
?CA
CA(immat[,-1])

afc <- CA(immat[,-1],graph = F)


str(afc) # Qu'est-ce qu'il y a dans l'objet résultant de la fonction ?
summary(afc)
dimdesc(afc,axes = 1:2)

# Histogramme des valeurs propres
mean(afc$eig$eigenvalue)
barplot(afc$eig$eigenvalue,horiz = T,main="Histogramme des valeurs propres",
        xlab = "Pourcentage de l'inertie totale",col="lightblue",border = "grey")

h_cp <- ggplot(data=afc$eig,aes(x=row.names(afc$eig),afc$eig$`percentage of variance`))
h_cp + geom_bar(stat = "identity")+ coord_flip()+ xlab("Pourcentage de l'inertie")+ ylab("valeur propre")

plot.CA(afc,selectRow = "contrib 10")    # représentations graphiques sympathiques




