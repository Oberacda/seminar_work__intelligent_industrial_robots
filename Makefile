LATEX_COMPILER = xelatex
LATEX_BIBTOOL = biber
LATEX_GLOSSARIES = makeglossaries

all: | latex finalize

clean: *.tex
	rm -f $(wildcard *.aux)
	rm -f $(wildcard *.log)
	rm -f $(wildcard *.nav)
	rm -f $(wildcard *.out)
	rm -f $(wildcard *.snm)
	rm -f $(wildcard *.toc)
	rm -f $(wildcard *.bbl)
	rm -f $(wildcard *.blg)
	rm -f $(wildcard *.zip)
	rm -f $(wildcard *~)
	rm -f $(wildcard *.bcf)
	rm -f $(wildcard *.xml)
	rm -f $(wildcard *.acn)
	rm -f $(wildcard *.acr)
	rm -f $(wildcard *.alg)
	rm -f $(wildcard *.ist)
	rm -f $(wildcard *.glg)
	rm -f $(wildcard *.glo)
	rm -f $(wildcard *.gls)
	rm -f $(wildcard *.gz)

distclean: *.tex clean
	rm -f $(wildcard *.pdf)

latex: *.tex
	${LATEX_COMPILER} -interaction=nonstopmode thesis.tex
	${LATEX_BIBTOOL} thesis
	${LATEX_GLOSSARIES} thesis
	${LATEX_COMPILER} -interaction=nonstopmode thesis.tex
	${LATEX_GLOSSARIES} thesis
	${LATEX_COMPILER} -interaction=nonstopmode thesis.tex

finalize: thesis.pdf
	gs 	-dCompatibilityLevel=1.4										\
		-dPDFSETTINGS=/screen											\
		-dCompressFonts=true -dEmbedAllFonts=true -dSubsetFonts=true	\
		-dNOPAUSE -dBATCH -dPrinted=false -sDEVICE=pdfwrite				\
		-sOutputFile=seminar_intelligent_industrial_robots__automated_plc_programming.pdf				\
		-f thesis.pdf
