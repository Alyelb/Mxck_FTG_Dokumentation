# =============================================================
#  Mxck FTG Documentation – Makefile
# =============================================================
MAIN     = main
SRCDIR   = src
BUILDDIR = build
PDFNAME  = Mxck_FTG_Dokumentation.pdf

LATEX     = pdflatex
BIBTEX    = bibtex
LATEXOPTS = -interaction=nonstopmode -halt-on-error

.PHONY: all clean view

all: $(PDFNAME)
	@echo "✓  PDF ready: $(PDFNAME)"

$(PDFNAME): $(SRCDIR)/$(MAIN).tex \
    $(wildcard $(SRCDIR)/chapters/*.tex) \
    $(SRCDIR)/references.bib
	@mkdir -p $(BUILDDIR)
	# Run 1 – initial compilation
	cd $(SRCDIR) && $(LATEX) $(LATEXOPTS) -output-directory=../$(BUILDDIR) $(MAIN).tex
	# BibTeX (BIBINPUTS points to src/ so references.bib is found)
	cd $(BUILDDIR) && BIBINPUTS=../$(SRCDIR): $(BIBTEX) $(MAIN) || true
	# Run 2 – resolve citations
	cd $(SRCDIR) && $(LATEX) $(LATEXOPTS) -output-directory=../$(BUILDDIR) $(MAIN).tex
	# Run 3 – resolve cross-references and final output
	cd $(SRCDIR) && $(LATEX) $(LATEXOPTS) -output-directory=../$(BUILDDIR) $(MAIN).tex
	@cp $(BUILDDIR)/$(MAIN).pdf $(PDFNAME)

clean:
	rm -rf $(BUILDDIR) $(PDFNAME)
	@echo "✓  Clean complete."

view: all
	@xdg-open $(PDFNAME) 2>/dev/null || open $(PDFNAME) 2>/dev/null || \
	  echo "Open $(PDFNAME) manually."
