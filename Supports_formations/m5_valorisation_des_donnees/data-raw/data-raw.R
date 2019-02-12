library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(stringr)
library(purrr)
library(sf)
library(tmap)
library(viridis)
library(scales)
library(tmaptools)
library(highcharter)
library(leaflet)
library(cowplot)
library(waffle)
library(glue)
library(gganimate)
load("../data/ODD.RData")

graphique1<-bind_rows(indicateur0,indicateur311 %>%
                        filter(Type_Zone=="Pays",
                               Age_group=="All age ranges or no breakdown by age",
                               Sex=="Both sexes or no breakdown by sex",
                               Location=="Total (national level)",
                               is.na(Value_type)
                        )) %>%
  filter(Year==2015) %>%
  select(Continent,Parent_Zone_libelle,Country_or_Area_Name,Indicator_Description,Value) %>%
  spread(Indicator_Description,Value) %>% 
  rename_all(funs(str_replace_all(.,"[()]",""))) %>% 
  rename_all(funs(str_replace_all(.," ","_")))


graphique2 <-indicateur311 %>% filter(Country_or_Area_Name=="World",!is.na(Value))

graphique3<-bind_rows(indicateur0,indicateur311 %>%
                        filter(Type_Zone=="Pays",
                               Age_group=="All age ranges or no breakdown by age",
                               Sex=="Both sexes or no breakdown by sex",
                               Location=="Total (national level)",
                               is.na(Value_type)
                        )) %>%
  filter(Year==2015|Year==2000) %>%
  unite(Indicator,Indicator_Description,Year) %>%
  select(Continent,Parent_Zone_libelle,Country_or_Area_Name,Indicator,Value) %>%
  spread(Indicator,Value) %>% 
  set_names(c("Continent","Parent_Zone_Libelle","Pays","PIB2000","PIB2015","Mortalite2000","Mortalite2015"))

graphique_anime<-bind_rows(indicateur0,indicateur311 %>%
                             filter(Type_Zone=="Pays",
                                    Age_group=="All age ranges or no breakdown by age",
                                    Sex=="Both sexes or no breakdown by sex",
                                    Location=="Total (national level)",
                                    is.na(Value_type)
                             )) %>%
  filter(Year>=1990) %>% 
  select(Year,Continent,Parent_Zone_libelle,Country_or_Area_Name,Indicator_Description,Value) %>%
  spread(Indicator_Description,Value) %>% 
  rename_all(funs(str_replace_all(.,"[()]",""))) %>% 
  rename_all(funs(str_replace_all(.," ","_")))


save.image("data/ODD.RData")
