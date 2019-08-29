# Commande pour générer à la main le book du module 1

bookdown::render_book("index.Rmd", "bookdown::gitbook")
bookdown::render_book("index.Rmd", "bookdown::epub_book")

# Erreur à la compilation
# bookdown::render_book("index.Rmd", "bookdown::pdf_book")
