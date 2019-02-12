setwd("M:/INFORMATIQUE/Groupe référents R/Module stat desc/Stat desc")
require(tidyr)
require(plyr)
require(lsr)

dat <- read.csv(file="Data/Base_synth_territoires.csv",sep=';',dec=',')
head(dat)


## Manipulation des factor

d <- dat$ZAU[dat$ZAU != dat$ZAU[1]]
d<- droplevels(d)
levels(d)

dat$ZAU2 <- mapvalues(dat$ZAU,from=levels(dat$ZAU), to=c("111 - Grand pôle",
                                                         "112 - Couronne GP" ,              
                                                         "120 - Multipol grandes AU",
                                                         "211 - Moyen pôle",
                                                         "212 - Couronne MP" ,
                                                         "221 - Petit pôle",   
                                                         "222 - Couronne PP",
                                                         "300 - Autre multipol.",           
                                                         "400 - Commune isolée"))
levels(dat$ZAU2)


        ## Etudes bivariées


# 1 variable quali

dat$ZAU_COURT <- as.factor(substr(dat$ZAU,1,3))
tab <- table(dat$ZAU_COURT)

cols <- rainbow(nlevels(dat$ZAU_COURT))
barplot(tab,col=cols,main="Nombre de communes par type ZAU")
legend("center",levels(dat$ZAU2),fill=cols,cex=.7)
pie(tab,col=cols,main="Nombre de communes par type ZAU")
legend("left",levels(dat$ZAU2),fill=cols,cex=.7)

tab <- xtabs(formula = P14_POP ~ ZAU_COURT,data=dat)
tab
100*prop.table(tab)

# 2 variables qualitatives

tab <- table(dat$ZAU2,dat$REG)

cols <- rainbow(nlevels(dat$ZAU2))
barplot(tab,col=cols,main="Répartition des communes par type ZAU et région")
legend("topleft",levels(dat$ZAU2),fill=cols,cex=.7)

barplot(tab,col=cols,beside = T,main="Répartition des communes par type ZAU et région")
legend("topleft",levels(dat$ZAU2),fill=cols,cex=.7)
100*prop.table(tab)

# On inverse colonnes et lignes pour avoir une représentation plus lisible
tab <- table(dat$REG,dat$ZAU_COURT)
plot(tab,col=cols,main="Répartition des communes par type ZAU et région")

freq <- round(100*prop.table(tab),digits = 3)
addmargins(freq)

freq <- round(100*prop.table(tab,margin = 1),digits = 3)
addmargins(freq)
freq <- round(100*prop.table(tab,margin = 2),digits = 3)
addmargins(freq)

chisq.test(tab)
cramersV(tab)


# tableau pondéré
tab <- xtabs(formula = P14_POP~REG+ZAU2,data = dat)
tab
round(100*prop.table(tab,margin=1),3)

## Vaiables quanti
sans.na <- na.omit(dat)
cor(sans.na$MED13,sans.na$P14_EMPLT)
cor(sans.na$MED13,sans.na$P14_EMPLT,method="spearman")

