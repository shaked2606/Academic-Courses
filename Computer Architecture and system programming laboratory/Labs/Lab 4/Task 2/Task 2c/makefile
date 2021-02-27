# All Targets
all: flame2

# Tool invocations
# Executable "task0" depends on the files new_main.o util.o start.o
flame2: flame2.o start.o util.o
	ld -m elf_i386 start.o flame2.o util.o -o flame2

# Depends on the source and header files
flame2.o: flame2.c
	gcc -g -m32 -Wall -ansi -c -nostdlib -fno-stack-protector flame2.c -o flame2.o

util.o: util.c
	gcc -g -m32 -Wall -ansi -c -nostdlib -fno-stack-protector util.c -o util.o

start.o: start.s
	nasm -f elf -o start.o start.s

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o flame2
