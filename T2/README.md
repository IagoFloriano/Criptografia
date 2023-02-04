# trabalho de cripto parte 2 o inimigo é o mergesort

## o que temos ate agora 

- um merge sort
- um reversemergesort q funciona
- um merge shuffle   

- agora cada caractere  é atibuido a 4 letras ao  invez dos anteriores 8, isso aumenta a dificuldade 
- que deus tenha piedade do desperdicio de memoria que estamos usando

## para executar 

primeiramente compilar com make  

- criptografar:   
./teste -k <arquivo com a chave> < nome do arquivo a se criptografado   
caso o arg -k nao seja dado, a primeira linha sera usada como chave ate o primeiro \n   
- descriptografar:
./teste -d -k  <arquivo com a chave> < texto para descriptografar    
O -k segue as mesmas regras da criptografia   

## falta o relatorio
