#include <stdio.h>
#include <stdlib.h>

#define TEXTSIZE 1024

void descriptografa(char *entrada, char *saida){
  char normal[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
  char subs[]   = {'P', 'F', 'J', 'W', 'B', 'A', 'H', 'U', 'R', 'M', '6', 'K', 'D', 'T', 'Z', 'Q', 'N', 'E', 'L', 'V', '6', 'I', 'G', 'C', 'O', 'S'};
  for(int i = 0; i < TEXTSIZE; i++){
    if(entrada[i] <= 'Z' && entrada[i] >= 'A'){
      saida[i] = subs[entrada[i] -'A'];
    }
    else if(entrada[i] == '_'){
      saida[i] = ' ';
    }
    else {
      saida [i] = entrada[i];
    }

    if(saida[i] == '\0')
      break;
  }
  printf("%s", saida);
}

int main(){
  char *entrada, *saida;
  entrada = malloc(TEXTSIZE * sizeof(char));
  saida = malloc(TEXTSIZE * sizeof(char));
  char temp = getchar();
  int i;
  for(i = 0; i < TEXTSIZE -1 && temp != EOF; i++){
    entrada[i] = temp;
    temp = getchar();
  }
  entrada[i] = '\0';

  descriptografa(entrada, saida);

  printf("entrada:\n%s\n", entrada);
  printf("saida:\n%s\n", saida);
}
