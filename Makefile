codeebo: y.tab.c lex.yy.c
	gcc -o eboparser y.tab.c

y.tab.c: codeebo.y lex.yy.c
	yacc codeebo.y

lex.yy.c: codeebo.l
	lex codeebo.l

clean:	rm -f lex.yy.c y.tab.c codeebo
