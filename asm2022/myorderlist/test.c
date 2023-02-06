#define _POSIX_C_SOURCE 200809L

#include <unistd.h>
#include <stdio.h>
#include <math.h>

long long li[] = {0x11, 0x3, 0x8};


void printlist(long long *list, int size) {

    int i = 0;
    char c = '0';



    while (i < size - 1) {
       
        write(1, &i, 1);
        write(1, ", ", 2);
        i++;
    }
    write(1, &list[size -1], 1);
    write(1, "\n", 1);
}
int main() {

    printlist(li, 3);

    return 0;
}