%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

int charPos=1;

void adjust(void)
{
	EM_tokPos=charPos;
	charPos+=yyleng;
}
%}

C   \'.\'
N	(\-)?[0-9]+
F   (\-)?[0-9]+\.[0-9]+
D	[\_a-zA-Z][a-zA-Z0-9\_]*
S	\"([^\\]\\\"|[^\"])*\"

%%

\n		{adjust(); EM_newline(); continue;}
[\r\t]	{adjust(); continue;}
" "	 	{adjust(); continue;}
","	 	{adjust(); return COMMA;}
":"	 	{adjust(); return COLON;}
";"	 	{adjust(); return SEMICOLON;}
"("	 	{adjust(); return LPAREN;}
")"	 	{adjust(); return RPAREN;}
"["	 	{adjust(); return LBRACK;}
"]"	 	{adjust(); return RBRACK;}
"{"	 	{adjust(); return LBRACE;}
"}"	 	{adjust(); return RBRACE;}
"."	 	{adjust(); return DOT;}
"+"	 	{adjust(); return PLUS;}
"-"	 	{adjust(); return MINUS;}
"*"	 	{adjust(); return TIMES;}
"/"	 	{adjust(); return DIVIDE;}
"=="	{adjust(); return EQ;}
"!="	{adjust(); return NEQ;}
"<"		{adjust(); return LT;}
"<="	{adjust(); return LE;}
">"		{adjust(); return GT;}
">="	{adjust(); return GE;}
"&&"	{adjust(); return AND;}
"||"	{adjust(); return OR;}
":="	{adjust(); return ASSIGN;}
"\/\*"  {adjust(); return LEXPLAN;}
"\*\/"  {adjust(); return REXPLAN;}
array	{adjust(); return ARRAY;}
if		{adjust(); return IF;}
then	{adjust(); return THEN;}
else	{adjust(); return ELSE;}
while	{adjust(); return WHILE;}
for		{adjust(); return FOR;}
to	 	{adjust(); return TO;}
do	 	{adjust(); return DO;}
let	 	{adjust(); return LET;}
in	 	{adjust(); return IN;}
end	 	{adjust(); return END;}
of	 	{adjust(); return OF;}
break	{adjust(); return BREAK;}
nil		{adjust(); return NIL;}
func	{adjust(); return FUNCTION;}
var		{adjust(); return VAR;}
type	{adjust(); return TYPE;}
{C}		{adjust(); yylval.cval = *(yytext + 1); return CHAR;}
{N}		{adjust(); yylval.ival = atoi(yytext); return INT;}
{F}		{adjust(); yylval.fval = atof(yytext); return FLOAT;}
{D}     {adjust(); yylval.sval = String(yytext); return ID;}
{S}		{adjust(); yylval.sval = String(yytext); return STRING;}
.		{adjust(); EM_error(EM_tokPos,"illegal token");}

%%

int yywrap(void)
{
	charPos=1;
	return 1;
}

