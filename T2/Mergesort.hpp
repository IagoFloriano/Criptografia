#ifndef MERGESORT_HPP
#define MERGESORT_HPP

#include <vector>
#include <iostream>
#include <tuple>

class Mergesort
{
private:
	/* data */
public:
	static void mergeSort(std::vector<char> &arr, int l, int r, std::vector<std::tuple<bool,bool>> &weights);	

	static void reverseMergeSort(std::vector<char> &arr,std::vector<std::tuple<bool,bool>> &weights);
	
	static void mergeShuffle(std::vector<char> &arr, int l, int r);

};




#endif