
all: mymul

mymul:
	nasm -f elf64 -o mymul.o mymul.S
	gcc mymul.o mymul.c -o mymul

clean:
	rm -f *.o mymul