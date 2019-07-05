RESOURCES = .resources
HTMLS = $(patsubst %.md,%.html,$(wildcard *.md))
PDFS = $(patsubst %.md,%.pdf,$(wildcard *.md)) #$(patsubst %.md,%.2col.pdf,$(wildcard *.md))
BIBFILE=emarg_bib.bib
STANDALONE=--standalone
PANDOC_COMMON = --filter pandoc-crossref --filter .resources/image-fmt-switcher.py \
		--filter pandoc-citeproc --bibliography $(BIBFILE) --csl .resources/kdmthesis.csl # chicago-author-date.csl
HTML = --to html5 -c $(RESOURCES)/kultiad-serif.css --katex=$(RESOURCES)/katex/ --self-contained
LATEXOPTS = -V fontsize=12pt -V geometry="margin=1in"

.PHONY: all clean upload default

DATADEPS = $(shell find figures/ .resources/ -not -name \*.html -type f -not -path .resources/tmp) $(BIBFILE)

all: $(HTMLS) $(PDFS)

pdfs: $(PDFS)

clean:
	rm -f $(HTMLS) $(PDFS)


%.html: %.md $(DATADEPS)
	pandoc $(STANDALONE) $(PANDOC_COMMON) $(HTML) --output $@ $<

%.docx: %.md $(DATADEPS)
	pandoc $(STANDALONE) $(PANDOC_COMMON) --to docx --output $@ $<

%.pdf: %.md $(DATADEPS)
	pandoc $(STANDALONE) $(PANDOC_COMMON) $(LATEXOPTS) --output $@  ./.resources/meta_latex.yml $<

%.2col.pdf: %.md $(DATADEPS)
	pandoc $(STANDALONE) $(PANDOC_COMMON) $(LATEXOPTS) -V classoption=twocolumn --output $@  ./.resources/meta_latex.yml $<

