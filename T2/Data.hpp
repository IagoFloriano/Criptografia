#ifndef DATA_HPP
#define DATA_HPP

#include <vector>
#include <string>
#include <iostream>
#include <array>
#include "Mergesort.hpp"
#include <tuple>

class Data{
private:
	/* data */
	std::vector<char> texto;
	unsigned int tam_texto;
	std::vector<std::tuple<bool,bool>> chave;
public:
	Data();
	~Data();
	void gerarChave(std::string chave);
	bool recebeTexto();
	void mergeSort();
	void imprimeSaida();
	void reverseMergeSort(); // O coraçao de todo problema é o reverse merge sort
	void mergeShuffle();
};



#endif