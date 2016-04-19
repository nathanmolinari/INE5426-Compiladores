#include <iostream>
#include "AnaliseSemantica/AnaliseSemantica.h"

extern AnaliseSemantica::Bloco* raizDoPrograma; //set on Bison file
extern int yyparse();

int main(int argc, char **argv)
{
    yyparse();                  //parses whole data
    raizDoPrograma->print();
    raizDoPrograma->executar();

    return 0;
}
