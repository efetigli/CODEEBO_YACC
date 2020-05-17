%{
#include <stdlib.h>
%}
%option yylineno
digit [0-9]
letter [A-Za-z]

%%


print 				{return PRINT;}
array 				{return ARRAY;}

func 				{return FUNC;}
endfunc 			{return ENDFUNC;}
call 				{return CALLFUNC;}

\= 					{return EQUAL_OP;}
\+ 					{return SUM_OP;}
\- 					{return SUB_OP;}
\* 					{return MULT_OP;}
\/ 					{return DIV_OP;}

\!\= 				{return NOTEQUAL_COMPARATOR;}
\=\= 				{return EQUAL_COMPARATOR;}
\> 					{return GREATERTHAN_COMPARATOR;}
\< 					{return LESSTHAN_COMPARATOR;}
\>\= 				{return GREATEREQUAL_COMPARATOR;}
\<\= 				{return LESSEQUAL_COMPARATOR;}

\( 					{return LEFT_PAR;}
\) 					{return RIGHT_PAR;}
\, 					{return COMMA;}
\. 					{return DOT;}
\: 					{return COLON;}
\; 					{return SEMICOLON;}


return 				{return RETURN;}
if 					{return IF;}
else 				{return ELSE;}
endif 				{return ENDIF;}
while 				{return WHILE;}
endwhile 			{return ENDWHILE;}
for 				{return FOR;}
endfor 				{return ENDFOR;}

true 				{return TRUE;}
false 				{return FALSE;}

"&&" 				{return AND;}
"||" 				{return OR;}
\/\/.* 				{return COMMENT_LINE;}

\".*\" 							{return STRING;}
{digit}+						{yylval.num = atoi(yytext); return NUMBER;}
{digit}+\.{digit}+ 				{return DOUBLE;}
{letter}+({letter}*|{digit}*) 	{yylval.id = yytext[0]; return IDENTIFIER;}
{letter}+({letter}*|{digit}*)\: {return FUNCTION_NAME;}

%%

int yywrap()		{return 1;}

void yyerror( char *s){ 
	fprintf(stderr, "%s on line %d\n",s,yylineno);
} 
