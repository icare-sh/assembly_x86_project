#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

long long li[] = {0x10, 0x3, 0x8};


char* Myitoa(int num, char* str)
{
    int i = 0;
    char* p = str;
    char* p1, *p2;
    unsigned long long u = num;

    do
    {
        int rem = u % 10;
        *(p + i++) = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
    } while (u /= 10);

    *(p + i) = '\0';

    p1 = p;
    p2 = p + i - 1;

    while (p1 < p2)
    {
        char tmp = *p1;
        *p1 = *p2;
        *p2 = tmp;
        p1++;
        p2--;
    }
    return p;
}



int main(void) {
  char *ptr;
  size_t size = 4096;

  ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if (ptr == MAP_FAILED) {
    perror("mmap");
    return 1;
  }

  int i = 0;
    for (i = 0; i < 3; i++) {
        char *str = Myitoa(li[i], ptr);
        printf("%s\n", str);
    }

  printf("Allocated memory at address %p with size %ld\n", ptr, size);
  munmap(ptr, size);
  return 0;
}