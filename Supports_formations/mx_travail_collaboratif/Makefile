OUTDIR=_book
SOURCE=$(wildcard *.Rmd)
PDF_FILE=$(shell Rscript -e "cat(paste0(bookdown:::book_filename(), '.pdf'))")
PDF_FILE:=$(addprefix $(OUTDIR),$(addprefix /,$(PDF_FILE)))

.PHONY: all gitbook pdf clean

all: gitbook pdf

gitbook: $(OUTDIR) 

pdf: $(PDF_FILE)

$(OUTDIR): $(SOURCE)
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', output_dir = '$(OUTDIR)')"

$(PDF_FILE): $(SOURCE)
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book', output_dir = '$(OUTDIR)', output_options = list(latex_engine = 'xelatex'))"

clean:
	rm -rf $(OUTDIR)
