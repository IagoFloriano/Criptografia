#include "Data.hpp"

Data::Data(/* args */){
	this->tam_texto = 0;
}

Data::~Data(){

}

void Data::gerarChave(std::string chave){
	for (char c : chave) {
    	for (int i = 7; i >= 0; --i) {
      		this->chave.push_back((c >> i) & 1);
    	}
  	}
	int i = 0;
	int tam = this->chave.size();
	while(tam < 2048){
		this->chave.push_back(this->chave[i]);
		i++;
		tam++;
	}
}


bool Data::recebeTexto(){
	char c;
	while (this->texto.size() < 2048 && std::cin.get(c)){
		this->texto.push_back(c);
	}
	//std::cerr<< "o tamanho é: " << this->texto.size(); 
	if (this->texto.size() == 2048){
		return 1;
	}
	return 0;	
}

void Data::imprimeSaida(){
	for(long unsigned int i = 0; i < this->texto.size() ; i++)
		std::cout << this->texto[i];
	this->texto.clear();
}

void Data::mergeSort() {
	std::vector<bool> chave_aux = this->chave;
	Mergesort::mergeSort(this->texto,0,this->texto.size() - 1,chave_aux);
}

void Data::reverseMergeSort(){
	Mergesort::reverseMergeSort(this->texto,this->chave);
}