#include <stdio.h>

typedef struct {
        unsigned long long high;
            unsigned long long low;
} resmul;

void mymul(unsigned long long m1, unsigned long long m2, resmul *res)
{
    unsigned long long mul = m1 * m2;
    res->high = mul * 0x1000000000000000;
    res->low = mul;
}

int main() {
    resmul res;

    mymul(3, 6, &res);
    printf("mymul(3, 6); res.high=0x%llx, res.low=0x%llx\n", res.high, res.low);
    //mymul(3, 6); res.high=0x0, res.low=0x12

    mymul(0x1000000000000000, 0x4, &res);
    printf("mymul(0x1000000000000000, 4); res.high=0x%llx, res.low=0x%llx\n", res.high, res.low);
    //mymul(0x1000000000000000, 4); res.high=0x0, res.low=0x4000000000000000

    mymul(0x1000000000000000, 0x10, &res);
    printf("mymul(0x1000000000000000, 0x10); res.high=0x%llx, res.low=0x%llx\n", res.high, res.low);
    //mymul(0x1000000000000000, 0x10); res.high=0x1, res.low=0x0

    return 0;
}



