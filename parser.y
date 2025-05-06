%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

typedef struct {
    int ival;
    char *str;
} YYSTYPE;

#define YYSTYPE_IS_DECLARED 1
%}

%union {
    int ival;
    char *str;
}

%token <ival> NUMBER
%token <str> IDENTIFIER
%token INT FLOAT IF ELSE WHILE RETURN
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON COMMA ASSIGN PLUS MINUS TIMES DIVIDE

%start program

%%

program:
    program statement
    | statement
    ;

statement:
    declaration
    | assignment
    | function
    ;

declaration:
    type IDENTIFIER SEMICOLON
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    ;

type:
    INT
    | FLOAT
    ;

expression:
    NUMBER
    | IDENTIFIER
    | expression PLUS expression
    | expression MINUS expression
    ;

function:
    type IDENTIFIER LPAREN RPAREN LBRACE statement_list RBRACE
    ;

statement_list:
    statement_list statement
    | /* empty */
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}
