#include <vector>
#include <iostream>

template <typename T>
void merge(std::vector<T> &arr, int l, int m, int r, std::vector<int> &weights) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;

    std::vector<T> L, R;
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
        if (weightL[i] >= weightR[j]) {
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

template <typename T>
void mergeSort(std::vector<T> &arr, int l, int r, std::vector<int> &weights) {
    if (l < r) {
        int m = l + (r - l) / 2;

        mergeSort(arr, l, m, weights);
        mergeSort(arr, m + 1, r, weights);

        merge(arr, l, m, r, weights);
    }
}

int main() {
    std::vector<char> arr = {'P', 'a', 'l', 'a', 'v', 'r', 'a'};
    std::vector<int> weights = {0, 0, 1, 0, 1, 1 , 0};

    mergeSort(arr, 0, arr.size() - 1, weights);

    for (int i = 0; i < arr.size(); i++){
        std::cout << arr[i] << " ";
    }
    std::cout << '\n';

    return 0;
}