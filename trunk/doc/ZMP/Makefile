HEAD = dipp.sty
SRC = zmp.tex

TEX = pdfcslatex
vystup = zmp.pdf

.PHONY: build
.PHONY: open
.PHONY: clean

build: ${vystup}

clean:
	rm -f *.log *.dvi *.aux

open:
	open ${vystup}

${vystup}: ${SRC}
	${TEX} ${SRC}

${SRC}: ${HEAD}
