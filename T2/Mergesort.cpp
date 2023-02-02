#include "Mergesort.hpp"

void merge(std::vector<char> &arr, int l, int m, int r, std::vector<bool> &weights) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;

    std::vector<char> L, R;
    std::vector<int> weightL, weightR;

    for (i = 0; i < n1; i++) {
        L.push_back(arr[l + i]);
        weightL.push_back(weights[l + i]);
    }
    for (j = 0; j < n2; j++) {
        R.push_back(arr[m + 1 + j]);
        weightR.push_back(weights[m + 1 + j]);
    }

    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (weightL[i] <= weightR[j]) {
            arr[k] = L[i];
            weights[k] = weightL[i];
            i++;
        }
        else {
            arr[k] = R[j];
            weights[k] = weightR[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        weights[k] = weightL[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        weights[k] = weightR[j];
        j++;
        k++;
    }
}

void Mergesort::mergeSort(std::vector<char> &arr, int l, int r, std::vector<bool> &weights) {
    if (l < r) {
        int m = l + (r - l) / 2;

        mergeSort(arr, l, m, weights);
        mergeSort(arr, m + 1, r, weights);

        merge(arr, l, m, r, weights);
    }
}


void Mergesort::reverseMergeSort(std::vector<char> &arr,std::vector<bool> &weights){
	int corte = 0;
	for(long unsigned int  i = 0; i < arr.size(); i++){
		corte += static_cast<int>(weights[i]);
	}	
	std::cout << "corte: "<< corte <<"\n";
	corte = arr.size() - corte;
	std::vector<char> l(arr.begin(),arr.begin() + corte);
	std::vector<char> r(arr.begin() + corte,arr.end());

	for(long unsigned int i = 0; i < l.size() ; i++)
		std::cout << l[i];
	std::cout << "\n";
	for(long unsigned int i = 0; i < r.size() ; i++)
		std::cout << r[i];
	std::cout << "\n";	

	int l_count = 0;
	int r_count = 0;
	for(long unsigned int i = 0; i < arr.size(); i++){
		if (weights[i] == 1){
			arr[i] = r[r_count];
			r_count++;
		}
		else{
			arr[i] = l[l_count];
			l_count++;
		}

	}
}