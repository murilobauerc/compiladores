all: elgol

elgol.tab.c elgol.tab.h:	elgol.y
	bison -d elgol.y

lex.yy.c: elgol.l elgol.tab.h
	flex elgol.l

elgol: lex.yy.c elgol.tab.c elgol.tab.h
	gcc -o elgol elgol.tab.c lex.yy.c

clean:
	rm elgol elgol.tab.c lex.yy.c elgol.tab.h