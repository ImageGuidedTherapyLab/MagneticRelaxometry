# Makefile for generating presentation $(TARGET).pdf from $(TARGET).tex
PAPER = relaxometry

.PHONY: $(PAPER).pdf
all: $(PAPER).pdf

# build pdf file first to ensure all aux files are available
# http://latex2rtf.sourceforge.net/
#   M6 converts equations to bitmaps
$(PAPER).rtf: $(PAPER).pdf $(PAPER).bbl $(PAPER).aux
	latex2rtf -M12 -D 600 $(PAPER).tex

$(PAPER).pdf: $(PAPER).tex $(PAPER).bbl
	pdflatex $(PAPER).tex

$(PAPER).bbl: $(PAPER).bib
	pdflatex $(PAPER).tex
	bibtex $(PAPER)
	pdflatex $(PAPER).tex

clean:
	rm *.aux *.toc *.bbl *.blg *.log *.out
