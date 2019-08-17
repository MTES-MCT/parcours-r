# Commande pour générer à la main le book du module 4

bookdown::render_book("index.Rmd", "bookdown::gitbook")
bookdown::render_book("index.Rmd", "bookdown::epub_book")
bookdown::render_book("index.Rmd", "bookdown::pdf_book")
