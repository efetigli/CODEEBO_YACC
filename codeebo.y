%{
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}
%union {int num; char id;} 
%token PRINT
%token ARRAY
%token FUNC
%token ENDFUNC
%token CALLFUNC
%token EQUAL_OP
%token SUM_OP
%token SUB_OP
%token MULT_OP
%token DIV_OP
%token NOTEQUAL_COMPARATOR
%token EQUAL_COMPARATOR
%token GREATERTHAN_COMPARATOR
%token LESSTHAN_COMPARATOR
%token GREATEREQUAL_COMPARATOR
%token LESSEQUAL_COMPARATOR
%token LEFT_PAR
%token RIGHT_PAR
%token COMMA
%token DOT
%token COLON
%token SEMICOLON
%token RETURN
%token IF
%token ELSE
%token ENDIF
%token WHILE
%token ENDWHILE
%token FOR
%token ENDFOR
%token AND
%token OR
%token COMMENT_LINE
%token TRUE
%token FALSE
%token <num> NUMBER
%token FUNCTION_NAME
%token <id> IDENTIFIER
%token STRING
%token DOUBLE
%type <id> statement_list statement assignment_statement array_statement array_elements if_statement logic_expression expression term while_statement function_define_statement
%type <id> function_call_statement return_statement define_parameter_list parameter_list operator logic_operator comment_line

%%


statement_list              : statement SEMICOLON
                            | statement_list statement SEMICOLON 
	                        ;

statement                   : assignment_statement
                            | array_statement
                            | if_statement
                            | while_statement
                            | function_define_statement
                            | function_call_statement
	                        | return_statement
	                        | expression
                            ;

assignment_statement        : IDENTIFIER EQUAL_OP expression  { updateSymbolVal($1,$3); }
                            | IDENTIFIER EQUAL_OP logic_expression { updateSymbolVal($1,$3); }
                            ;

array_statement             : ARRAY IDENTIFIER EQUAL_OP LEFT_PAR array_elements RIGHT_PAR;

array_elements              :   NUMBER         | NUMBER array_elements
                            |   IDENTIFIER     | IDENTIFIER array_elements
                            ;


if_statement                : IF logic_expression COLON statement_list ELSE statement_list ENDIF
                            | IF logic_expression COLON statement_list ENDIF
                            ;

logic_expression            : term
                            | logic_expression NOTEQUAL_COMPARATOR term  { if($1 != $3){$$ = TRUE;} }
                            | logic_expression EQUAL_COMPARATOR term  { if($1 == $3){$$ = TRUE;} }
                            | logic_expression GREATERTHAN_COMPARATOR term  { if($1 > $3){$$ = TRUE;} }
                            | logic_expression LESSTHAN_COMPARATOR term  { if($1 < $3){$$ = TRUE;} }
                            | logic_expression GREATEREQUAL_COMPARATOR term  { if($1 >= $3){$$ = TRUE;} }
                            | logic_expression LESSEQUAL_COMPARATOR term   { if($1 <= $3){$$ = TRUE;} }
                            ;

expression                  : term
                            | expression SUB_OP term {$$ = $1 - $3;}
                            | expression SUM_OP term {$$ = $1 + $3;}
                            | expression MULT_OP term {$$ = $1 * $3;}
                            | expression DIV_OP term {$$ = $1 / $3;}

                            ;

term                        : NUMBER  {$$ = $1;}
                            | IDENTIFIER  {$$ = symbolVal($1);} 
                            | STRING 
                            | TRUE
                            | FALSE
                            ;

                    
while_statement             :   WHILE logic_expression COLON statement_list ENDWHILE
                            ;

function_define_statement   :   FUNC FUNCTION_NAME LEFT_PAR define_parameter_list RIGHT_PAR statement_list ENDFUNC
                            |   FUNC FUNCTION_NAME LEFT_PAR RIGHT_PAR statement_list ENDFUNC
                            ;

function_call_statement     :   CALLFUNC PRINT LEFT_PAR expression RIGHT_PAR {printf("Printing %d\n", $4);}
                            |   CALLFUNC FUNCTION_NAME LEFT_PAR RIGHT_PAR
			                | 	CALLFUNC FUNCTION_NAME LEFT_PAR parameter_list RIGHT_PAR
                            ;

return_statement            :   RETURN expression
                            |   RETURN SEMICOLON
                            ;

define_parameter_list	    :	term
			                |	term define_parameter_list;

parameter_list              :  	term
                            |   term parameter_list
                            ;

operator                    :   SUM_OP
                            |   SUB_OP
                            |   MULT_OP
                            |   DIV_OP
			                |	EQUAL_OP
                            ;

logic_operator              :   GREATERTHAN_COMPARATOR
                            |   GREATEREQUAL_COMPARATOR
                            |   LESSTHAN_COMPARATOR
                            |   LESSEQUAL_COMPARATOR
                            |   NOTEQUAL_COMPARATOR
			                | 	EQUAL_COMPARATOR
                            |   AND
                            |   OR
                            ;

comment_line                : COMMENT_LINE;
                        



%%

#include "lex.yy.c"


int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}