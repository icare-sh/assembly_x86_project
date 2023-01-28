
all: myadd/myadd mymul/mymul fibonnaci/fibonnaci mydiv/mydiv myitoa/myitoa myorderlist/myorderlist myfilexor/myfilexor

myadd/myadd:
	nasm -f elf64 -o myadd/myadd.o myadd/myadd.S
	gcc myadd/myadd.o myadd/myadd.c -o myadd/myadd

mymul/mymul:
	nasm -f elf64 -o mymul/mymul.o mymul/mymul.S
	gcc mymul/mymul.o mymul/mymul.c -o mymul/mymul

fibonnaci/fibonnaci:
	nasm -f elf64 -o fibonnaci/fibonnaci.o fibonnaci/fibonnaci.S
	gcc fibonnaci/fibonnaci.o fibonnaci/fibonnaci.c -o fibonnaci/fibonnaci

mydiv/mydiv:
	nasm -f elf64 -o mydiv/mydiv.o mydiv/mydiv.S
	gcc mydiv/mydiv.o mydiv/mydiv.c -o mydiv/mydiv

myitoa/myitoa:
	nasm -f elf64 -o myitoa/myitoa.o myitoa/myitoa.S
	gcc myitoa/myitoa.o myitoa/myitoa.c -o myitoa/myitoa

myorderlist/myorderlist:
	nasm -f elf64 -o myorderlist/myorderlist.o myorderlist/myorderlist.S
	gcc myorderlist/myorderlist.o myorderlist/myorderlist.c -o myorderlist/myorderlist

myfilexor/myfilexor:
	nasm -f elf64 -o myfilexor/myfilexor.o myfilexor/myfilexor.S
	gcc myfilexor/myfilexor.o myfilexor/myfilexor.c -o myfilexor/myfilexor

clean:
	find . -iname '*.o' -delete

distclean: clean
	rm -f fibonnaci/fibonnaci


