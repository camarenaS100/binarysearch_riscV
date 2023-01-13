#include <stdio.h>

int bsearch_r (int *a, int x, int i, int j) {
    if (j < i) {
        printf("\n\n %d < %d entonces %d no está en el arreglo", j, i, x);
        return -1;
    }
    int k = i + ((j - i) / 2);
    printf("\n (%d, %d)  k : %d\n", i, j, k);
    if (a[k] == x) {
        return k;
    }
    else if (a[k] < x) {
        printf("\n (k+1,j) : (%d, %d) porque %d < %d\n", k+1, j, a[k], x);
        return bsearch_r(a, x, k + 1, j);
    }
    else {
        printf("\n (i,k-1) : (%d, %d) porque %d !< %d\n", i, k-1, a[k], x);
        return bsearch_r(a, x, i, k - 1);
    }
}

int main () {
    int a[] = {-782, -499, -203, -120, -42, -24, -15, -7, -2,  0};
    int n = sizeof a / sizeof a[0];
    int x = -203;
    printf("{-782, -499, -203, -120, -42, -24, -15, -7, -2,  0}");
    int i = bsearch_r(a, x, 0, n - 1);
    printf("\nel valor del índice es %d\n", i);
    return 0;
}

//(a0 - a), (a1 - n), (a2 - x), (a3 - i)