#include <stdio.h>

long long myitoa(char *s);

int main() {

    printf("myitoa(\"5\")=%lli\n", myitoa("5")); // 5
    printf("myitoa(\"-5\")=%lli\n", myitoa("-5")); // -5
    printf("myitoa(\"-18\")=%lli\n", myitoa("-18")); // -18

}


