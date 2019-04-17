LATEX        := pdflatex -shell-escape -interaction=nonstopmode -file-line-error
LATEXMK      := latexmk -shell-escape -interaction=nonstopmode -file-line-error -pdf
BIBER        := biber
RM           := rm -f

class.cls    := diphdthesis.cls
biblio.bib   := $(wildcard biblio/*.bib)
styles.sty   := $(wildcard definitions/*.sty)
sources.tex  := $(wildcard thesis.tex)
sources.tex  += $(wildcard committee.tex)
sources.tex  += $(wildcard chapters/*.tex)

thesis.pdf   := thesis.pdf
dependencies := $(biblio.bib) $(class.cls) $(styles.sty) $(sources.tex)

#--------------------------
# Default target
#--------------------------

.PHONY: all
all: $(thesis.pdf)

.PHONY: force
force:

$(thesis.pdf): $(dependencies)

$(thesis.pdf): %.pdf: %.tex force
	$(LATEX) $<
	$(BIBER) $*
	$(LATEX) $<
	$(LATEX) $<

#--------------------------
# Cleanup target
#--------------------------

.PHONY: clean
clean:
	$(RM) $(subst .pdf,.log,$(thesis.pdf))
	$(RM) $(subst .pdf,.lof,$(thesis.pdf))
	$(RM) $(subst .pdf,.lot,$(thesis.pdf))
	$(RM) $(subst .pdf,.toc,$(thesis.pdf))
	$(RM) $(subst .pdf,.aux,$(thesis.pdf))
	$(RM) $(subst .pdf,.bbl,$(thesis.pdf))
	$(RM) $(subst .pdf,.blg,$(thesis.pdf))
	$(RM) $(subst .pdf,.bcf,$(thesis.pdf))
	$(RM) $(subst .pdf,.run.xml,$(thesis.pdf))
	$(RM) $(subst .pdf,.out,$(thesis.pdf))
	$(RM) -r $(thesis.pdf:%.pdf=_minted-%/)
	$(RM) $(thesis.pdf)
