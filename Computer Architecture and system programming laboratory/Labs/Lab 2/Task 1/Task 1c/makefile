# All Targets
all: code

# Tool invocations
# Executable "code" depends on the files code.o
code: code.o 
	gcc -m32 -g -Wall -o code code.o

# Depends on the source and header files
code.o: code.c
	gcc -g -Wall -m32  -c -o code.o code.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o code
