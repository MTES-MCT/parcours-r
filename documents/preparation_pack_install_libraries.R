################################################################################
########## Préparation d'un répertoire regroupant tous les packages dont il y a besoin
# en format zip. C'est à faire au bureau avant de partir faire la formation.

rm (list = ls ())

# Définition de la fonction qui va, à partir d'une liste de packages, aller chercher leurs dépendances et
# en faire une liste (packages choisis + leurs dépendances) sans doublons
# source : https://www.r-bloggers.com/installing-packages-without-internet/

getDependencies <- function (packs) {
  dependencyNames <- unlist (
    tools::package_dependencies (packages = packs, db = available.packages (),
                                which = c ('Depends', 'Imports'),
                                recursive = TRUE))

  packageNames <- union (packs, dependencyNames)
  packageNames }

# Application
my_packages <- c ('ade4','BalancedSampling','bookdown','boot','caTools','cartography','classInt',
                  'cluster','codetools','cowplot','data.table','doBy','DT','dygraphs','explor',
                  'factoextra','FactoMineR','foreign','gganimate','GGally','ggExtra','ggmosaic','ggthemes','gifski',
                  'glue', 'googleVis','gridExtra','haven','highcharter','hrbrthemes','htmltools','htmlwidgets',
                  'icarus','ineq','kableExtra','KernSmooth','knitr','leaflet','lsr',
                  'maptools','MASS','Matrix','mgcv','nlme','nycflights13','plotrix', 'purrr',
                  'Rcmdr','RcppRoll','rgdal','rmarkdown','RODBC','rpart','RPostgreSQL','rsdmx',
                  'sampling','scales','sf','shiny','shinydashboard','sp','spatial','sqldf','survey','survival',
                  'tidyverse','tmap','tmaptools','viridis','visNetwork','waffle',
                  'XLConnect','xtable','xts','zoo')

packages_to_download <- sort (getDependencies (my_packages))

# gestion des cas particuliers. eg le package "datasets" doit apparaître comme dépendence, mais de quoi ? Et il bloque au
# téléchargement -> on les supprime de la liste

packages_to_download <- packages_to_download[!packages_to_download %in% c("datasets", "graphics", "grDevices",
                                                                          "grid", "methods", "parallel", "splines",
                                                                          "stats", "stats4", "tcltk", "tools", "utils")]




# Téléchargement des packages dans le répertoire de travail (eg clé USB qu'on va emmener pour installer la salle).
setwd ("T:/G2R/kitR/packages")
pkgInfo <- download.packages (pkgs = packages_to_download,
                              destdir = getwd(),
                              type = "win.binary")

# sauvegarde des noms des packages téléchargés.
# ATTENTION, C'EST INDISPENSABLE POUR POUVOIR DEPLOYER UNE FOIS DANS LA SALLE !

write.csv (file = "pkgFilenames.csv", basename (pkgInfo[, 2]), row.names = FALSE)


########################################################################
# A ce stade, copier tout le répertoire de travail sur le support qui va servir à configurer les postes
# dans la salle de formation
################################################################################

# Une fois en salle de formation, après avoir installé R et Rstudio, exécuter le script suivant

# Mettre comme répertoire de travail celui où sont les packages
setwd ("E:/Installation_postes/packages/")

# Lecture de la liste des packages à partir du fichier csv et installation
pkgFilenames <- read.csv ("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]

# Gestion des cas particuliers (certains packages qui bloquent le déploiement ; cause non indentifiée).

pkgFilenames <- pkgFilenames [!pkgFilenames %in% c("ade4_1.7-13.zip", "doBy_4.6-2.zip", "kernlab_0.9-27.zip",
                                                   "lme4_1.1-19.zip", "sandwich_2.5-0.zip", "survey_3.34.zip")]
pkgFilenames <- sort (pkgFilenames, decreasing = TRUE)

install.packages (pkgFilenames, repos = NULL, type = "win.binary")


# traçage inverse des dépendantes, ex pour la package "graphics" : dependsOnPkgs("graphics")

