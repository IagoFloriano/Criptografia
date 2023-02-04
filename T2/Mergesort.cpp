#include "Mergesort.hpp"

void merge(std::vector<char> &arr, int l, int m, int r, std::vector<std::tuple<bool,bool>> &pesos) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;

    std::vector<char> L, R;
    std::vector<std::tuple<bool,bool>> pesoL, pesoR;

    for (i = 0; i < n1; i++) {
        L.push_back(arr[l + i]);
        pesoL.push_back(pesos[l + i]);
    }
    for (j = 0; j < n2; j++) {
        R.push_back(arr[m + 1 + j]);
        pesoR.push_back(pesos[m + 1 + j]);
    }

    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (std::get<0>(pesoL[i]) < std::get<0>(pesoR[j])) {
            arr[k] = L[i];
            pesos[k] = pesoL[i];
            i++;
        }
        else if(std::get<0>(pesoL[i]) > std::get<0>(pesoR[j])){
            arr[k] = R[j];
            pesos[k] = pesoR[j];
            j++;
        }
		else if(std::get<1>(pesoL[i]) > std::get<1>(pesoR[j])){
			arr[k] = R[j];
            pesos[k] = pesoR[j];
            j++;
		}
		else if(std::get<1>(pesoL[i]) < std::get<1>(pesoR[j])){
			 arr[k] = L[i];
            pesos[k] = pesoL[i];
            i++;
		}
		else{
			arr[k] = L[i];
            pesos[k] = pesoL[i];
            i++;
		}
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        pesos[k] = pesoL[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        pesos[k] = pesoR[j];
        j++;
        k++;
    }
}

void Mergesort::mergeSort(std::vector<char> &arr, int l, int r, std::vector<std::tuple<bool,bool>> &pesos) {
    if (l < r) {
        int m = l + (r - l) / 2;

        mergeSort(arr, l, m, pesos);
        mergeSort(arr, m + 1, r, pesos);

        merge(arr, l, m, r, pesos);
    }
}

void mergeShuffleMerge(std::vector<char> &arr, int l, int m, int r){
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;

    std::vector<char> L, R;

    for (i = 0; i < n1; i++) {
        L.push_back(arr[l + i]);
    }
    for (j = 0; j < n2; j++) {
        R.push_back(arr[m + 1 + j]);
    }

    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        arr[k] = R[j];
        j++;
        k++;
        arr[k] = L[i];
        i++;
        k++;
    }
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void Mergesort::mergeShuffle(std::vector<char> &arr, int l, int r){
     if (l < r) {
        int m = l + (r - l) / 2;

        mergeShuffle(arr, l, m);
        mergeShuffle(arr, m + 1, r);

        mergeShuffleMerge(arr, l, m, r);
    }
}

void Mergesort::reverseMergeSort(std::vector<char> &arr,std::vector<std::tuple<bool,bool>> &pesos){
	int corte_0 = 0;
	int corte_1 = 0;
	int corte_2 = 0;
	for(long unsigned int  i = 0; i < arr.size(); i++){
		//std::cerr << std::get<0>(pesos[i]) << " " << std::get<1>(pesos[i]) << "\n";
        if(std::get<0>(pesos[i]) && !std::get<1>(pesos[i])){
            corte_2++;
        }
		else if(!std::get<0>(pesos[i]) && std::get<1>(pesos[i])){
            corte_1++;
		}
		else if(!std::get<0>(pesos[i]) && !std::get<1>(pesos[i])){
            corte_0++;
		}
	}	
	corte_1 +=corte_0;
	corte_2 += corte_1;
	//std::cerr << "corte: "<< corte_0 <<"\n";
	//std::cerr << "corte: "<< corte_1 <<"\n";
	//std::cerr << "corte: "<< corte_2 <<"\n";

	std::vector<char> s0(arr.begin()			,arr.begin() + corte_0);
	std::vector<char> s1(arr.begin() + corte_0 	,arr.begin() + corte_1);
	std::vector<char> s2(arr.begin() + corte_1  ,arr.begin() + corte_2);
	std::vector<char> s3(arr.begin() + corte_2 	,arr.end());

	/*for(long unsigned int i = 0; i < s0.size() ; i++)
		std::cerr << s0[i];
	std::cerr << "\n-----------------------------\n";
	for(long unsigned int i = 0; i < s1.size() ; i++)
		std::cerr << s1[i];
	std::cerr << "\n";
	for(long unsigned int i = 0; i < s2.size() ; i++)
		std::cerr << s2[i];
	std::cerr << "\n-----------------------------\n";
	for(long unsigned int i = 0; i < s3.size() ; i++)
		std::cerr << s3[i];
	std::cerr << "\n";*/

	int s0_count = 0;
	int s1_count = 0;
	int s2_count = 0;
	int s3_count = 0;

	for(long unsigned int i = 0; i < arr.size(); i++){
		if(std::get<0>(pesos[i]) && !std::get<1>(pesos[i])){
            arr[i] = s2[s2_count];
			s2_count++;
        }
		else if(!std::get<0>(pesos[i]) && std::get<1>(pesos[i])){
            arr[i] = s1[s1_count];
			s1_count++;
		}
		else if(!std::get<0>(pesos[i]) && !std::get<1>(pesos[i])){
            arr[i] = s0[s0_count];
			s0_count++;
		}
		else {
            arr[i] = s3[s3_count];
			s3_count++;
		}
	}
}