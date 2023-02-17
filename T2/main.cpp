
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include "Data.hpp"

int main(int argc, char *argv[]) {
	bool descritografa = 0;
	std::string senha;
	for (int i = 1; i < argc; i++) {
        std::string arg(argv[i]);
        if (arg == "-d") {
			descritografa = 1;
        } else if (arg == "-k") {
            std::ifstream arquivo(argv[i+1]);
			std::getline(arquivo, senha);
			arquivo.close();
		}
	}
	if (senha.size() == 0){
		std::getline(std::cin , senha);
	}
    Data dados; 
	dados.gerarChave(senha);
	
	//criptografa
	if (!descritografa){
		while (dados.recebeTexto()){
			dados.mergeSort(); 											//o merge sort usou 100% de seu poder,mas nao foi capaz de lidar com o reversemergesort usando 0% do seu 
			dados.mergeShuffle();
			dados.imprimeSaida();
		}
		dados.mergeSort();
		dados.imprimeSaida();
	}
	else{
																		// ironicamente o reverse merge sort tem complexidade O(N) fazendo com que teoricamente seja mais facil descriptografar algo do que critografar
																		// o merge shuffle ainda eh O(n*log n)
		//descriptografa
		while (dados.recebeTexto()){
			dados.mergeShuffle();
			dados.reverseMergeSort(); 																// O coraçao de todo problema é o reverse merge sort
			dados.imprimeSaida();
		}
		dados.reverseMergeSort();																 // O coraçao de todo problema é o reverse merge sort
		dados.imprimeSaida();
	}
    return 0;
}