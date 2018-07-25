#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

YYSTYPE yylval;

int yylex(void); /* prototype for the lexing function */



string toknames[] = {
	"ID", "STRING", "INT", "COMMA", "COLON", "SEMICOLON", "LPAREN",
	"RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "DOT", "PLUS",
	"MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "LE", "GT", "GE",
	"AND", "OR", "ASSIGN", "ARRAY", "IF", "THEN", "ELSE", "WHILE", "FOR",
	"TO", "DO", "LET", "IN", "END", "OF", "BREAK", "NIL", "FUNCTION",
	"VAR", "TYPE", "FLOAT", "LEXPLAN", "REXPLAN", "CHAR"
};

string tokname(tok) {
	return tok<257 || tok>303 ? "BAD_TOKEN" : toknames[tok-257];
}

int main(int argc, char **argv) {
	string fname; 
	int tok;
	if (argc != 2) 
	{
		fprintf(stderr,"usage: lextest filename\n");
		exit(1);
	}

	fname = argv[1];
	EM_reset(fname);
	for(;;) {
		tok = yylex();
		if (tok == 0) 
			break;
		switch(tok) 
		{
			case ID: 
			case STRING:
				printf("%10s %4d %s\n", tokname(tok), EM_tokPos, yylval.sval);
				break;

			case CHAR:
				printf("%10s %4d %c\n", tokname(tok), EM_tokPos, yylval.cval);
				break;

			case INT:
				printf("%10s %4d %d\n", tokname(tok), EM_tokPos, yylval.ival);
				break;
			case FLOAT:
				printf("%10s %4d %f\n", tokname(tok), EM_tokPos, yylval.fval);
				break;

			default:
				printf("%10s %4d\n", tokname(tok), EM_tokPos);
		}
	}
	return 0;
}
