%{
# include <math.h>
# include <stdio.h> 
# include "parser.tab.h" 
#define BUFSIZE 4
extern void yyerror( char *); // we need to forward declare these functions , 
int yyparse( void ); // don ' t worry about them 
%}

%option noyywrap

DIGIT    [0-9]
ID       [-_a-zA-Z][-_a-zA-Z0-9]*
 
%%

\"[^"]*\"   return SENTENCE; 

S+	      {yylval.str_val = strdup( yytext );return TYPE;};

{DIGIT}+    {yylval.int_val = atoi(yytext);return INT;};

{DIGIT}+"."{DIGIT}*         {yylval.double_val = atof(yytext);return DOUBLE;};

(?i:BeGiN)       return BEGI;
(?i:EnD)	 return EN;
(?i:MoVe)        return MOV;
(?i:AdD)         return AD;
(?i:ReAd)        return REA;
(?i:To)          return TOO;
(?i:PrInT)       return PRIN;

{ID}		    {yylval.str_val = strdup( yytext );return ID;};

"{"[^}\n]*"}"     /* eat up one-line comments */

[ \t\n]+          /* eat up whitespace */

"."           return PERIO;

[,]           return COMMA;

%% 


main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
  
    yyparse();

    
}
