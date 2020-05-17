# PROJECT STEP 1: LEXICAL ANALYZER
Dear Murat Teacher, since all three of us are roommates we made the program together in a room. This is the reason there is a single contributor on the github. We talked and coded every part together. Thank you for understanding.

## PROJECT MEMBERS
Nasip Efe Tığlı - 20170808020
Berkcan ALtungöz - 20170808014
Özgün Aras - 20150807031
### EXPLANATION OF THE LANGUAGE ###

We were inspired by both Python and Java languages. We took what we liked on both of the languages and we tried to make it easy to write and understand. Variables dont need type declaration in this language. While and if statements end with endif and endwhile. CodeEbo uses "=", "+", "-", "*", "/" signs to do operations.It also uses also uses "!=", "==", ">", "<", ">=", "<=" comparator symbols. You can create your own functions, define constants and make operator comparisions and assignments. You can use it by first using the make command then using a command like "./eboparser < test.ebo " command. 

### EBNF GRAMMAR OF CODEEBO LANGUAGE ###
<statement_list >  ::=  <statement>  |  <statement_list> <statement> 
<statement>  ::=  <assignment_statement>
|  <array_statement>
|  <if_statement>
|  <while_statement>
|  <function_define_statement>
|  <function_call_statement>
|  <return_statement>
|  <expression>

<assignment_statement>  ::=  IDENTIFIER  ‘=’ <EQUAL_OP> <expression> 
  |  IDENTIFIER ‘=’ <logic_expression> 

<array_statement >  ::=  ARRAY IDENTIFIER ‘=’  ‘(’  <array_elements>  ‘)’

<array_elements>  ::=  NUMBER  |  NUMBER  <array_elements>
|  IDENTIFIER  |  IDENTIFIER  <array_elements>

<if_statement>  ::=  IF <logic_expression> ‘:’ <statement_list> ELSE <statement_list> ENDIF
                            | IF <logic_expression> ‘:’ <statement_list> ENDIF

<logic_expression>  ::=  <term>  | <logic_expression> <logical_operator> <term> 
                            
<expression>  ::=  <term>  | <expression> <operator> <term>

<term>  ::=  NUMBER  | IDENTIFIER  | STRING  | TRUE  | FALSE

<while_statement>   ::=   WHILE <logic_expression> ‘:’ <statement_list> ENDWHILE

<function_define_statement>   ::=   FUNC FUNCTION_NAME ‘(’ <define_parameter_list> ‘)’ <statement_list> ENDFUNC 
|  FUNC FUNCTION_NAME ‘(’ ‘)’ <statement_list> ENDFUNC

<function_call_statement>  ::=   CALLFUNC PRINT ‘(’ <expression> ‘)’
           |   CALLFUNC FUNCTION_NAME ‘(’  ‘)’
           |   CALLFUNC FUNCTION_NAME ‘(’  <parameter_list>  ‘)’

return_statement  ::=  “RETURN” <expression>  |  “RETURN”  ‘;’

<define_parameter_list>  ::=  <term>  |  <term> <define_parameter_list>

<parameter_list>  ::=  <term>  |  <term> <parameter_list>

<operator>  ::=  +  |  -  |  *  |   /  |  = 

<logic_operator>  ::  =  >  |  >=  |  <  |  <=  |  =!  |  ==  |  &&  |  ||
