all:
	bison -d parser.y
	flex lexer.l
	gcc -o cparser parser.tab.c lex.yy.c -lfl

clean:
	rm -f cparser parser.tab.* lex.yy.c
