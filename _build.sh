#!/bin/sh

set -ev

# Compilation du module 1
./_render_book_maybe.R -f all  ./Supports_formations/m1_socle/

# Compilation du module 2
./_render_book_maybe.R -f all  ./Supports_formations/m2_preparation_donnees/

# Compilation du module 3
./_render_book_maybe.R -f all  ./Supports_formations/m3_stats_desc/

# Compilation du module 4
./_render_book_maybe.R -f bookdown::gitbook  ./Supports_formations/m4_analyse_donnees/

# Compilation du module 5
./_render_book_maybe.R -f bookdown::gitbook  ./Supports_formations/m5_valorisation_des_donnees/
