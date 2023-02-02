
#include <iostream>
#include <string>
#include <vector>
#include "Data.hpp"

int main(int argc, char *argv[]) {
	std::string senha{"senha intermediaria que pode ter ate 256 caracteres e qqr elemento da tabela ascii"};
	bool descritografa = 0;
	std::cout << argc << "\n";
	if(argc > 1)
		descritografa = 1;
	//std::getline(std::cin, senha);
	//std::string s{"posso escrever algo assim?"};
    Data dados; 
	dados.gerarChave(senha);
	
	//criptografa
	if (!descritografa){
		while (dados.recebeTexto()){
			dados.mergeSort(); //o merge sort usou 100% de seu poder,mas nao foi capaz de lidar com o reversemergesort usando 0% do seu 
			dados.mergeShuffle();
			dados.imprimeSaida();
		}
		dados.mergeSort();
		dados.mergeShuffle();
		dados.imprimeSaida();
	}
	else{
		//descriptografa
		while (dados.recebeTexto()){
			dados.mergeShuffle();
			dados.reverseMergeSort(); // O coraçao de todo problema é o reverse merge sort
			dados.imprimeSaida();
		}
		dados.mergeShuffle();
		dados.reverseMergeSort(); // O coraçao de todo problema é o reverse merge sort
		dados.imprimeSaida();
	}
    return 0;
}