#include <stdio.h>

typedef struct {
    unsigned long long res;
    unsigned long long rest;
} resdiv;

char mydiv(unsigned long long val, unsigned long long div, resdiv *res);


int main() {
    resdiv  res;
    char    r;

    r = mydiv(6, 3, &res);
    printf("mydiv(6, 3); res.res=0x%llx, res.rest=0x%llx, r=%i\n", res.res, res.rest, r); // res = 2; rest=0; r=1

    r = mydiv(6, 4, &res);
    printf("mydiv(6, 4); res.res=0x%llx, res.rest=0x%llx, r=%i\n", res.res, res.rest, r); // res = 1; rest=2; r=1

    r = mydiv(6, 0, &res);
    printf("mydiv(6, 0); res.res=0x%llx, res.rest=0x%llx, r=%i\n", res.res, res.rest, r); // res = 0; rest=0; r=0

    return 0;
}
