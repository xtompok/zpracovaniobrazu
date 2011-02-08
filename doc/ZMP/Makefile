HEAD = dipp.sty
SRC = zmp.tex
METAPOST = kriz.mp 2p-transform.mp

TEX = pdfcslatex
vystup = zmp.pdf

.PHONY: build
.PHONY: open
.PHONY: clean
.PHONY: metapost
.PHONY: all

build: ${vystup}

clean:
	rm -f *.log *.dvi *.aux *.1 *.mpo *.keep *mpgraph.mp *.mpx

open:
	open ${vystup}
metapost:
	mptopdf ${METAPOST}
all: build open

${vystup}: ${SRC} metapost #${HEAD}
	${TEX} ${SRC}

#${SRC}: ${HEAD} 
#zmp.tex: dipp.sty
#${HEAD}:
#	echo "Kontroluji hlavicky"
