%{
#define YY_NO_UNPUT
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
extern int yylex(void);
void symbolOutOfRange();
void valueOutOfRange();
int i = 0;int j = -1;int k = -1;
#define BUFSIZE 4
char a[BUFSIZE][BUFSIZE];
int b[BUFSIZE];

  extern int yylineno;	
  extern char *yytext;	
%}

%union{
  int		int_val;
  double 	double_val;
  char *	str_val;	
}


%token	<int_val>	INT 
%token	<double_val>	DOUBLE
%token	<str_val>	SENTENCE 
%token	<str_val>	TYPE 
%token	<str_val>	BEGI
%token	<str_val> 	EN
%token	<str_val>	MOV 
%token	<str_val>	REA 
%token	<str_val>	TOO 
%token	<str_val>	PRIN 
%token	<str_val>	ID 
%token	<str_val>	EQUAL 
%token	<str_val>	PLUS 
%token	<str_val>	MINUS 
%token	<int_val>	PERIO 
%token	<str_val>	COMMA
%token	<str_val>	AD 

%type <str_val>		lines;
%type <str_val>		line;
%type <str_val>		rest;

%start  parsetree

%%

parsetree:      lines;

lines:		lines line 
	      | line 
	      ;

line:           BEGI PERIO        
              | EN PERIO	  {printf("successssssssssss");}
              | TYPE ID PERIO	  {sprintf(a[i],"%s",$2);
				   b[i] = strlen($1);
				   i++;
				  }
              | PRIN SENTENCE PERIO
              | PRIN SENTENCE rest PERIO
              | PRIN ID rest PERIO
              | PRIN ID PERIO	
              | MOV INT TOO ID PERIO{   char buf[BUFSIZE];
					sprintf(buf,"%d",$2);
					char *tem = $4;
					int t;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							j = i;
					}
					if(j == -1){
						printf("unknown symbolllllll\nwarning:only show the first error");
						exit(1);
					}
					else{
						t = b[j];
					}
					if(strlen(buf) > t){ 
						printf("int is larger than the datatype\nwarning:only show the first error");  
						exit(1);
					}
				     }
              | MOV DOUBLE TOO ID PERIO{char buf[BUFSIZE];
					sprintf(buf,"%f",$2);
					char *tem = $4;
					int t;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							j = i;
					}
					if(j == -1){ 
						printf("unknown symbolllllll\nwarning:only show the first error");
						exit(1);
					}
					else{
						t = b[j];
					}
					if(strlen(buf) > t){ 
						printf("double is larger than the datatype\nwarning:only show the first error");  
						exit(1);
					}
				     }
              | AD ID TOO ID PERIO{     char *tem = $2;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							j = i;
					}
					if(j == -1){ 
						printf("unknown symbolllllll\nwarning:only show the first error");
						exit(1);
					}
					tem = $4;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							k = i;
					}
					if(k == -1){ 
						printf("unknown symbol\nwarning:only show the first error");
 						exit(1);
					}
					if(b[k] < b[j]){ 
				       		printf("id is larger than the datatype\nwarning:only show the first error");
						exit(1);
					}
				  }
              | AD INT TOO ID PERIO{    char buf[BUFSIZE];
					sprintf(buf,"%d",$2);
					char *tem = $4;
					int t;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							j = i;
					}
					if(j == -1){ 
						printf("unknown symbolllllll\nwarning:only show the first error");
						exit(1);
					}
					else{
						t = b[j];
					}
					if(strlen(buf) > t){ 
						printf("int is larger than the datatype\nwarning:only show the first error");  
						exit(1);
					}
				  }
             | MOV ID TOO ID PERIO{     char *tem = $2;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							j = i;
					}
					if(j == -1){ 
						printf("unknown symbolllllll\nwarning:only show the first error");
						exit(1);
					}
					tem = $4;
					for(i = 0;i < BUFSIZE;i++){
        					if(strcmp(a[i],tem) == 0)
							k = i;
					}
					if(k == -1){ 
						printf("unknown symbol\nwarning:only show the first error");
 						exit(1);
					}
					if(b[k] < b[j]){ 
				       		printf("id is larger than the datatype\nwarning:only show the first error");
						exit(1);
					}
				  }
              | REA ID PERIO
              | REA ID rest PERIO
	      ;

rest:	        COMMA SENTENCE
              | COMMA ID
              | COMMA SENTENCE rest
              | COMMA ID rest
              ;



%%

void yyerror(char *s)
{
  
  printf("ERROR: at symbol %s on line %d\n",yytext,yylineno);
  exit(1);
}
