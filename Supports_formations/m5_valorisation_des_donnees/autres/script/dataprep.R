#Préparation des données ODD
library(tidyverse)
library(stringr)
library(readxl)
rm(list=ls())
setwd("/home/ubuntu/Documents/boulot/Dreal/Formations R/Valorisation des données/data")

## Imporation des la table des indicateurs
## Création d'une dimension année
## Création d'une dimension "Type de territoire pour isoler le monde,les sous régions et les pays
pays<-read_csv("pays.csv") %>%
  rename_all(funs(str_replace_all(.," ","_"))) %>% 
  select(-Parent_Country_or_Area_Code)
pays2<-read_csv("pays2.csv") %>%
  rename_all(funs(str_replace_all(.," ","_"))) %>% 
  select(-Parent_Country_or_Area_Code)

indicateur111<-read_excel("SDG Indicators 1.1.1.xls") %>%
  select(-starts_with("FN")) %>% 
  gather(Year,Value,`1990`:`2016`) %>% 
  rename_all(funs(str_replace_all(.," ","_"))) %>% 
  left_join(pays) %>% 
  mutate(TypeZone = case_when(
    str_length(Country_or_Area_Code) == 3 ~ "COUNTRY",
    Country_or_Area_Code == "MDG_WORLD" ~ "WORLD",
    TRUE ~ "SUB REGION"
  ),
  Value=as.numeric(Value),
  Year=as.numeric(Year)
  )

indicateur0<-read_excel("SDG Indicators 0.xls") %>% 
  rename_all(funs(str_replace_all(.," ","_"))) %>% 
  rename(Indicator_Description=Item,
         Country_or_Area_Name=Country_or_Area) %>%
  left_join(pays2) %>% 
  select(-Country_or_Area_Name) %>% 
  left_join(pays) %>% 
  mutate(Indicator_Ref_="0.0.0",
         IndicatorId="C000000",
         frequency="Annual",
         Unit="US dollars/capita",
         Value=as.numeric(Value),
         Year=as.numeric(Year)
  ) %>% 
  filter(!is.na(Country_or_Area_Name))
indicateur311<-read_excel("SDG Indicators 3.1.1.xls") %>%
  select(-starts_with("FN")) %>% 
  gather(Year,Value,`1990`:`2015`) %>% 
  rename_all(funs(str_replace_all(.," ","_"))) %>% 
  left_join(pays) %>% 
  mutate(TypeZone = case_when(
    str_length(Country_or_Area_Code) == 3 ~ "COUNTRY",
    Country_or_Area_Code == "MDG_WORLD" ~ "WORLD",
    TRUE ~ "SUB REGION"
  ),
  Value=as.numeric(Value),
  Year=as.numeric(Year)
  )

rm(pays,pays2)
save.image(file="ODD.RData")
