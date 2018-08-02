%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void); /* function prototype */

void yyerror(char *s)
{
	EM_error(EM_tokPos, "%s", s);
}
%}

%union {
	int    pos;
	int    ival;
	float  fval;
	char   cval;
	string sval;
}

%token <sval> ID STRING
%token <cval> CHAR
%token <ival> INT
%token <fval> FLOAT

%token 
',' ':' ';' '(' ')' '[' ']'
'{' '}' '.'
'+' '-' '*' '/' '%' EQ NEQ '<' LE '>' GE
AND OR ASSIGN
ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF 
BREAK NIL
FUNCTION VAR TYPE LEXPLAN REXPLAN

%start program

%left  ';'
%left  ','
%right THEN ELSE DO TO OF
%right ASSIGN
%left  AND OR
%nonassoc EQ NEQ '<' '>' GE LE
%left  '&' '|' '^'
%left  '+' '-'
%left  '*' '/' '%'

%%

/* This is a skeleton grammar file, meant to illustrate what kind of
 * declarations are necessary above the %% mark.  Students are expected
 *  to replace the two dummy productions below with an actual grammar. 
 */

 program : exp
	     ;

     exp : lvalue
		 | CHAR
	     | INT
	     | FLOAT
	     | STRING
	     | NIL
	     | '(' expseq ')'
	     | '(' ')'

	     | '-' exp
	     | exp '+' exp
	     | exp '-' exp
	     | exp '*' exp
	     | exp '/' exp
	     | exp '%' exp

	     | exp '&' exp
	     | exp '|' exp
	     | exp '^' exp

	     | exp EQ  exp
	     | exp NEQ exp
	     | exp '<' exp
	     | exp '>' exp
	     | exp LE  exp
	     | exp GE  exp
	     
	     | exp AND exp
	     | exp OR  exp

	     | funcall

	     | ID '[' exp ']' OF exp
	     | ID '{' '}'
	     | ID '{' ass '}'
	     | lvalue ASSIGN exp

	     | IF exp THEN exp
	     | IF exp THEN exp ELSE exp
	     | WHILE exp DO exp
	     | FOR ID ASSIGN exp TO exp DO exp
	     | BREAK

	     | LET decs IN END
	     | LET decs IN expseq END
	     | '(' error ')'
	     | error ';' exp
	     ;

  expseq : exp
	     | exp ';' expseq
	     ;

    decs : 
	     | dec
	     ;

    dec  : tydec
	     | vardec
	     | fundec
	     ;

   tydec : TYPE ID '=' ty
	     ;

      ty : ID 
         | '{' tyfields '}'
         | ARRAY OF ID 
         ;

tyfields :
		 | ID ':' ID 
		 | ID ':' ID ',' ID ':' ID
		 ;

  vardec : VAR ID ASSIGN exp
	     | VAR ID ':' ID ASSIGN exp
	     ;

  fundec : FUNCTION ID '(' tyfields ')' '=' exp
	     | FUNCTION ID '(' tyfields ')' ID '=' exp
	     ;

 funcall : ID '(' ')'
		 | ID '(' para ')'
		 ;

    para : exp
     	 | exp ',' para
	     ;

  lvalue : ID
	     | lvalue '.' ID
	     | lvalue '[' exp ']'
		 | ID '[' exp ']'
	     ;

     ass : ID
	     | ID EQ exp ',' ass
		 ;

%%
