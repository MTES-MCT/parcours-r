library(sf)
library(tidyverse)
library(magrittr)
rm(list=ls())
load("../data/rpls2016.RData")
load("../../../R/COG/2017/com2017.RData")
com2017 %<>% 
  select(depcom,depcom2017,ncom_2017,Dep_2017,Reg_2017,epci_2017,nepci_2017,nDep_2017,nReg_2017,epci_2017_52) %>% 
  mutate_all(funs(as.factor(.)))
rpls_detail<-rpls %>% 
  rename(depcom=depcom_red) %>% 
  select(depcom,typeconst_red,nbpiece_red,surfhab_red,construct_red,locat_red,dpeenergie_red,dpeserre_red) %>% 
  left_join(com2017) %>% 
  select(-depcom) %>% 
  sample_frac(.1)

load("../data/Logement social 2016.RData")
rpls_aggrege<-rpls %>% 
  mutate_at(vars(Reg_2017,Dep_2017,nepci_2017,epci_2017_52,depcom2017),as.factor)
rpls_aggrege_large<-rpls %>% 
  mutate_at(vars(Reg_2017,Dep_2017,nepci_2017,epci_2017_52,depcom2017),as.factor) %>% 
  mutate(Indicateur=iconv(Indicateur,to="ASCII//TRANSLIT") %>% 
           str_replace_all(" ","_") %>% 
           str_replace_all("'","_") %>% 
           str_replace_all(",","") %>% 
           str_replace_all("\\(","") %>% 
           str_replace_all("\\)","")
  ) %>% 
  spread(Indicateur,Valeur)


Carte_EPCI_France <- st_read(dsn="/home/ubuntu/Documents/boulot/Dreal/Data/refgeo/2017/", layer="Contour_epci_2017_region") %>%
  mutate(siren_epci=as.factor(siren_epci)) %>%
  rename(epci_2017=siren_epci)
load("/home/ubuntu/Documents/boulot/Dreal/R/Application Conjoncture LC/app/AppConj.Rdata")
dataconj<-app %>% 
  select(Theme,libelle,Indicateur,Zone,Periode,Periodicite,Statistique,Valeur,Evolution_Valeur)
rm(com2017,rpls,rpls_epci_geo,app,i,list,Theme)
save.image("../data/data_exercices_formation.RData")
