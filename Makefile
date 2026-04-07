LATEX    = pdflatex
STY      = $(wildcard beamer*Jacquenetta.sty)
DESTDIR ?= $(shell kpsewhich -var-value=TEXMFHOME)
INSTDIR  = $(DESTDIR)/tex/latex/jacquenetta

.PHONY: example clean install uninstall

example: example.tex $(STY)
	$(LATEX) example.tex
	$(LATEX) example.tex

install: $(STY)
	mkdir -p $(INSTDIR)
	cp $(STY) $(INSTDIR)
	texhash $(DESTDIR)

uninstall:
	rm -rf $(INSTDIR)
	texhash $(DESTDIR)

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.fls *.fdb_latexmk *.synctex.gz *.pdf
