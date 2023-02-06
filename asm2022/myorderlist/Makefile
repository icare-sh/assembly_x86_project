
all: myorderlist

myorderlist:
	nasm -f elf64 -o myorderlist.o myorderlist.S 
	gcc myorderlist.o myorderlist.c  -g -o myorderlist

clean:
	rm -f myorderlist.o myorderlist