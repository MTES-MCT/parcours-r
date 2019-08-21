GBDIR=_book
BOOK_NAME=$(shell Rscript -e "cat(bookdown:::book_filename())")
PDF_FILE=$(addsuffix .pdf,$(BOOK_NAME))
PDF_FILE:=$(addprefix /,$(PDF_FILE))
PDF_FILE:=$(addprefix $(GBDIR),$(PDF_FILE))

all: gitbook pdf

gitbook: $(GBDIR) 

pdf: $(PDF_FILE)

$(GBDIR): *.Rmd
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', output_dir = '$(GBDIR)')"

$(PDF_FILE): *.Rmd
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book', output_dir = '$(GBDIR)', output_options = list(latex_engine = 'xelatex'))"

clean:
	rm -rf $(GBDIR)
