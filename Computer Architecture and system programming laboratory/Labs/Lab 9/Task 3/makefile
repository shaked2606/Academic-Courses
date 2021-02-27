# All Targets
all: virus

virus: virus.o
	ld -nostdlib -m elf_i386 virus.o -o virus

virus.o: virus.s
	nasm -f elf -o virus.o virus.s

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o virus
