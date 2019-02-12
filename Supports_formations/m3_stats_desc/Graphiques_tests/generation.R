# chargement ----
library(visNetwork)
library(tidyverse)
library(gsheet)
library(stringr)

rm(list = ls())

point <- read.csv2(file = "Graphiques_tests/noeuds.csv", encoding = "UTF-8")
lien <- read.csv2(file = "Graphiques_tests/liens.csv", encoding = "UTF-8")


graph <- visNetwork(point, lien, height = '1000px', width = '100%') %>% 
  visNodes(shape = "box") %>%                        # square for all nodes
  visEdges(arrows = "to", smooth = F) %>%                            # arrow "to" for all edges
  visGroups(groupname = "question", color = "orange", shape = "ellipse") %>%   
  visGroups(groupname = "reponse", color = "lightgreen") %>%  
  visGroups(groupname = "test", color = "red") %>%    
  visGroups(groupname = "depart", color = "darkorchid", shape = "ellipse") %>%   
  visGroups(groupname = "interrogation", color = "lightslateblue") %>%    
  visOptions(highlightNearest = T,
             manipulation = F) %>%
  visHierarchicalLayout(direction = "LR", levelSeparation = 300) 


graph


visSave(graph, file = 'graphiques_tests.html')
