%{
#include "parser.tab.h"
%}

digit   [0-9]
id      [a-zA-Z_][a-zA-Z0-9_]*

%%
"int"           { return INT; }
"float"         { return FLOAT; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"return"        { return RETURN; }

{digit}+        { yylval.ival = atoi(yytext); return NUMBER; }
{id}            { yylval.str = strdup(yytext); return IDENTIFIER; }

"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
";"             { return SEMICOLON; }
","             { return COMMA; }
"="             { return ASSIGN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }

[ \t\r\n]+      ;       // Ignore whitespace
"//".*          ;       // Skip single-line comments
"/*"([^*]*|\*+[^*/])*\*+"/" ; // Skip multi-line comments

.               { printf("Unknown character: %s\n", yytext); }

%%
