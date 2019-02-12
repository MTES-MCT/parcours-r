require(FactoMineR)
require(ggplot2)

# Données sources : http://geoidd.developpement-durable.gouv.fr/geoclip_stats_o3/index.php?profil=FR#s=2012;v=map1;i=ocs.p_surf_c1;l=fr
# Simplement copiées et enregistrées dans un fichier CSV, avec remplacement des valeurs erronées (N/A)


setwd("D:/users/vivien.roussez/Documents/Groupe référents R/Module ADD/Exercices")

geoidd <- read.csv2(file = "ACP.csv",h=T)
head(geoidd)

dat <- geoidd[,-c(1,2)]
row.names(dat) <- geoidd[,1]
dat$agd21 <- as.factor(paste("Agenda21 ",(dat$part_agenda21>0)+0))
dat <- na.omit(dat[,-5])

# Matrice de corrélations 
cor(dat[,-c(5,7)])
table(dat$agd21,dat$PPRN)

# On fait l'ACP
acp <- PCA(dat,quali.sup = c(5,7),graph = F)

acp$eig
diff(acp$eig[,1])
plot.PCA(acp,choix="var")
plot.PCA(acp,choix="ind")                      # On n'y voit pas grand chose...
plot.PCA(acp,choix="ind",select="contrib 20")  # C'est un peu mieux...

# On veut identifier les individus très influents

select <- acp$ind$contrib
rownames(select) <- 
plot.PCA(acp,choix="ind",select="contrib 20")

summary(acp)

barplot(acp$eig$`percentage of variance`,horiz = T,main="Histogramme des valeurs propres",
        xlab = "Pourcentage de l'inertie totale",col="lightblue",border = "grey",names.arg=1:nrow(acp$eig))


dimdesc(acp,axes = 1:2)

# Illustration de l'effet taille 

taille <- read.csv2("Effet_taille.csv",h=T)
t <- PCA(na.omit(taille[,-c(1,2)]),graph = F)
plot.PCA(t,choix=c("var"),col.var="blue")
