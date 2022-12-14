CC = ghc
TARGETS = criptografa descriptografa
LIBS = util.hs viegenere.hs playFair.hs

all: criptografa descriptografa

criptografa: ${LIBS} criptografa.hs
	${CC} $@ -i ${LIBS}

descriptografa: ${LIBS} descriptografa.hs
	${CC} $@ -i ${LIBS}

clean:
	$(RM) *.hi *.o

purge: clean
	$(RM) ${TARGETS}
