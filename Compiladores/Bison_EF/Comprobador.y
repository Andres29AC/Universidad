%{
    #include <stdio.h>
    #include <string.h>
    #include <ctype.h>
    int yystopparser = 0;
    %}

%token IDENT ENTERO
%start Asignacion

%%
/* Gramatica de libre Contexto */
Asignacion  :IDENT '=' Expresion ';'
            |IDENT '=' Expresion ';' Asignacion
            ;
Expresion   :Expresion '+' Termino
            |Termino
Termino     :Termino '*' Factor
            |Factor
Factor      :ENTERO
            |IDENT
            |'(' Expresion ')'
            ;
%%
/*TODO: Analizador Lexico*/

FILE *Fuente;
int error=0;
int yylex(void){
        int c;
    c=fgetc(Fuente);

while (isspace(c))
    c=fgetc(Fuente);

if (isdigit(c))
    {
    c=fgetc(Fuente);
    while (isdigit(c))
        c=fgetc(Fuente);
    ungetc(c,Fuente);
    return(ENTERO);
}

if (isalpha(c))
{
    c=fgetc(Fuente);
    while(isalpha(c) || isdigit(c))
        c=fgetc(Fuente);
    ungetc(c,Fuente);
    return(IDENT);
}

if (strchr("=*+;()",c))
    return(c);
if (c==EOF)
    return(0);
yyerror("Ocurrio un error!!");
}
/*TODO: Manejador de Errores*/
yyerror(char *s){
    printf("%s\n",s);
    error=1;
}
/*TODO: Funcion Principal*/
/*Observacion:Tienes que estar dentro de la carpeta Bison*/
/*bison  -oparser.c  Comprobador.y*/
int main(){
    char nomArch[40];
    printf("Ingrese el nombre del Archivo: ");
    gets(nomArch);
    Fuente=fopen(nomArch,"r");
    if(Fuente==NULL){
        printf("No se pudo abrir el archivo");
        exit(1);
    }else
    yyparse();
    if (error==0)
    printf("Analisis Sintactico Correcto!! \n");
    else
    fclose(Fuente);
    getch();
}




