#!/bin/bash
# script d initialisation pour les modules de formations sous onyxia
R -e "remotes::install_github('MTES-MCT/savoirfR')"
R -e "remotes::install_cran('ggiraph')"