all: myfilexor

myfilexor:
	nasm -f elf64 -o myfilexor.o myfilexor.S 
	gcc myfilexor.o myfilexor.c  -g -o myfilexor

clean:
	rm -f myfilexor.o myfilexor