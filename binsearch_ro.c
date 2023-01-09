#include <stdio.h>

int bsearch_r (int *a, int x, int i, int j) {
    if (j < i) {
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
    int a[] = {-31, 0, 1, 2, 3, 4, 5, 83, 99, 782};
    int n = sizeof a / sizeof a[0];
    int x = 5;
    printf("{-31, 0, 1, 2, 3, 4, 5, 83, 99, 782}");
    int i = bsearch_r(a, x, 0, n - 1);
    printf("\nel valor del índice es %d\n", i);
    return 0;
}

//(a0 - a), (a1 - n), (a2 - x), (a3 - i)