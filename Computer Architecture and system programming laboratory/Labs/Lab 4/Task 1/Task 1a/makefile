# All Targets
all: encoder

# Tool invocations
# Executable "task0" depends on the files new_main.o util.o start.o
encoder: encoder.o start.o util.o
	ld -m elf_i386 start.o encoder.o util.o -o encoder

# Depends on the source and header files
encoder.o: encoder.c
	gcc -m32 -Wall -ansi -c -nostdlib -fno-stack-protector encoder.c -o encoder.o

util.o: util.c
	gcc -m32 -Wall -ansi -c -nostdlib -fno-stack-protector util.c -o util.o

start.o: start.s
	nasm -f elf -o start.o start.s

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o encoder
