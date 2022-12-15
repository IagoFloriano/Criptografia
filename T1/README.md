# Como funciona

São usados dois algoritmos de criptografia, play fair e viegenere.

Para cifrar ou decifrar algum texto será necessário duas chaves, chpf (chave play fair) e chvi (chave viegenere).

## A cifra:

Para a crifragem primeiro é usado o algoritmo de play fair na entrada e em seguida é feito o algoritmo de viegenere na saída do algoritmo play fair.

O algoritmo play fair usará chpf como chave, já o algoritmo viegenere usará chvi + a entrada como chave, isso para deixar a chave mais longa, deixando assim o algoritmo mais seguro.

## A decifra:

Para a decifragem é necessário utilizar as mesmas chaves usadas na cifragem.

A decifra usa o algoritmo de decifra de viegenere no texto desejado e a saída desse algoritmo é usado na decifra do algoritmo play fair.

A decifra de viegenere leva em conta que na cifra foi usado o texto de entrada como forma de aumentar a chave.

Como nesse algoritmo é usado o algoritmo play fair, a decifragem de um texto que foi cifrado por esse algoritmo pode ter alguns caracteres 'X' extras
e alguns caracteres 'J' podem ser equivalente ao caractere 'I' versão não cifrado do texto.

# Como usar

Para compilar use `make` (comando `make clean` pode ser útil para não ter tantos arquivos no diretório)

Para cifrar use `./criptografa < entrada.txt`

Para decifrar use `./descriptografa < entrada.txt`

entrada.txt deve ser da seguinte forma:
`[chpf] [chvi] [texto de entrada]`
onde a chpf (chave do play fair) e chvi (chave do viegenere) não podem conter espaços ou '\n'
já o texto de entrada deverá ser qualquer string desejada
(qualquer caractere que não é uma letra do padrão ASCII será deletado para ser feita a cifragem/decifragem)

## Exemplos:

### Exemplo de cifragem:

`./criptografia < criptEx.in > criptEx.out`

Esse exemplo usa o arquivo criptEx.in para cifrar, usandos as chaves e o texto de dentro do arquivo, e coloca a saída da cifra no arquivo criptEx.out

### Exemplo de decifragem:

`./descriptografia < decriptEx.in > decriptEx.out`

Esse exemplo usa o arquivo decriptEx.in para cifrar, usandos as chaves e o texto de dentro do arquivo, e coloca a saída da decifra no arquivo decriptEx.out
