#include <stdio.h>
#include <stdlib.h>

char *myfilexor(char *filepath, char key);

int main() {
    char *s;

    s = myfilexor("filetoxor.bin", 0x42);

    printf("myfilexor(\"filetodexor.bin\", 0x42)=%s\n", s);
    // Congratulation you have unxor the file
    free(s);
    return 0;
}

