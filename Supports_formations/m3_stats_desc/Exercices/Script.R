require(plyr)
require(dplyr)
require(ggplot2)
require(plotly)

install.packages("plotly")

setwd("E:/Formation R/Module stat desc/Stat desc")
dir()
dat <- read.csv("Data/Base_synth_territoires.csv",sep=";",dec=",",
         header = T)

dat$DEP %>% 
      levels() %>% 
      substr(start = 1,stop=1)

substr(levels(dat$DEP),start = 1,stop=1)

d <- filter(dat,substr(ZAU,1,3) != "120")
levels(d$ZAU)
d <- droplevels(d)
levels(d$ZAU)


dat <- mutate(dat,ZAU2=mapvalues(dat$ZAU,from=levels(dat$ZAU), to=c("111 - Grand pôle",
                                                                    "112 - Couronne GP" ,
                                                                    "120 - Multipol grandes AU",
                                                                    "211 - Moyen pôle",
                                                                    "212 - Couronne MP" ,
                                                                    "221 - Petit pôle",
                                                                    "222 - Couronne PP",
                                                                    "300 - Autre multipol.",
                                                                    "400 - Commune isolée")))
dat <- mutate(dat,ZAU_COURT = as.factor(substr(dat$ZAU,1,3)))
tab <- dat$ZAU2 %>% table()
tab

g <- ggplot(dat,aes(x=ZAU2,fill=ZAU2)) + geom_bar() + 
  theme(axis.text.x = element_blank())

pie(tab)

tab1 <- 100*prop.table(tab) %>% round(digits = 4)

tab <- xtabs(formula = P14_POP ~ ZAU2,data=dat)
100*prop.table(tab)

ggplot(dat,aes(x=ZAU2,fill=ZAU2,weight=P14_POP)) + 
  geom_bar() + 
  theme(axis.text.x = element_blank()) 

dat <- mutate(dat,densite=P14_POP/SUPERF)

# pour éviter les densités nulles (passage au log)
ggplot(dat,aes(densite)) + geom_histogram()

summarise(dat,mini=min(densite,na.rm=T),maxi=max(densite,na.rm=T))
max(dat$densite, na.rm=T)

summarise(dat,mini=min(log(densite),na.rm=T),maxi=max(log(densite),na.rm=T))
dat <- mutate(dat,densite=replace(densite,densite==0,0.01))

dat <- mutate(dat,log_dens = log10(dat$densite))
ggplot(dat,aes(log_dens)) + geom_histogram(bins = 100)

quantile(dat$log_dens,  probs = seq(from=0, to=1,by=0.1), na.rm = T)

ggplot(dat,aes(log_dens)) + geom_histogram() +
  geom_vline(xintercept=quantile(dat$log_dens, na.rm = T)) +
  annotate("text",x=quantile(dat$log_dens, na.rm = T),y=3400, label=c("Min","Q1","Méd.","Q3","Max"),colour="red")


ggplot(dat,aes(sample=log_dens)) + stat_qq()

summary(dat)
summary(dat$P14_POP)
select(dat,P14_POP,densite) %>% summary()
sd(dat$P14_POP, na.rm =T)

dat$SUPERF %>% mean(na.rm=T) %>% round(digits = 2)
dat$SUPERF %>% median(na.rm=T) %>% round(digits = 2)

v <- dat$densite
v <- na.omit(dat$densite)
var(v, na.rm = F) 

sd(v, na.rm = F)

dat$P14_RP_PROP %>% range(na.rm = T) %>% round(0)


q <- quantile(v, na.rm = T)
print(q)

q["75%"] - q["25%"]


IQR(v,na.rm = T)



v <- dat$densite
sd <- sd(v, na.rm = T)
mean <- mean(v, na.rm = T)
cov_dens <- sd/mean
print(cov_dens)

v1 <- dat$P14_POP
cov_pop <- sd(v1, na.rm = T)/mean(v1, na.rm = T)
print(cov_pop)


dat$densite %>% quantile(na.rm = T)

dat <- mutate(dat,tr_dens=cut(dat$densite,
                              breaks=c(0, 18.6, 40.4, 94.6, 27127),
                              labels=c("inf_18.6", "18.6_40.4", "40.4_94.6", "Sup_94.6")))

table(dat$tr_dens)


ggplot(dat,aes(x=P14_EMPLT,y=MED13)) + geom_point(colour="blue")

ggplot(dat,aes(x=log(P14_EMPLT),y=MED13)) + 
  geom_point(colour="blue") + 
  ggtitle("Revenu médian selon le nombre d'emplois") + 
  ylab("Revenu médian") + 
  xlab("Nombre d'habitants")

install.packages("GGally")
require(GGally)

num <- select(dat,18:21) %>% sample_n(10000) %>% log() # On sélectionne quelques données
ggpairs(num,title="Matrice de corrélation")
plot(num)

cor(na.omit(num))
?cor()
cor(na.omit(num), method = "spearman")

cor(na.omit(log(num)))

#############################################
#### Partie sur les tableaux de contingence #
#############################################

tab <- select(dat,ZAU2,REG) %>% table()
tab

bar <- ggplot(dat,aes(x=as.factor(REG),fill=ZAU2)) 
bar + geom_bar(position = "stack")
bar + geom_bar(position = "dodge")

install.packages("ggmosaic")
require(ggmosaic)

ggplot(dat) + geom_mosaic(aes(x = product(ZAU2,as.factor(REG)),
                              fill=ZAU2))

freq <- round(100*prop.table(tab),digits = 3)
addmargins(freq)


require(lsr)
cramersV(tab)


tab <- xtabs(formula = P14_POP~REG+ZAU_COURT,data = dat)
freq <- round(100*prop.table(tab,margin = 1),digits = 3)
addmargins(freq)

#par(mfrow=c(1,1))
bar <- ggplot(dat,aes(x=as.factor(REG),fill=ZAU2)) 
bar + geom_bar(position = "stack")
ggplot(dat,aes(as.factor(REG),fill=ZAU2,weight=P14_POP)) + 
  geom_bar(position = "stack")


ggplot(dat) + geom_mosaic(aes(x = product(ZAU2,as.factor(REG)),
                              fill=ZAU2))
ggplot(dat,aes(product(ZAU2,as.factor(REG)),fill=ZAU2,
               weight=P14_POP)) + geom_mosaic()
ggplot(dat,aes(product(ZAU2,as.factor(REG)),fill=ZAU2,
               weight=SUPERF)) + geom_mosaic()


ag <- dat %>% group_by(ZAU2) %>% 
  summarise(pop_moy=mean(P14_POP,na.rm=T),
            dens_med=median(densite,na.rm=T),
            nb_com=n(),
            sd_intra=sd(P14_POP,na.rm=T))

ggplot(dat,aes(y=log(densite),x=ZAU2,fill=ZAU2)) +
  geom_boxplot()


anova <- lm(densite~ZAU2,data=dat)
etaSquared(anova)

summary(anova)

write.csv2(ag,"toto.csv")

svg("toto.svg")
ggplot(dat,aes(y=log(densite),x=ZAU2,fill=ZAU2)) +
  geom_boxplot()
dev.off()
