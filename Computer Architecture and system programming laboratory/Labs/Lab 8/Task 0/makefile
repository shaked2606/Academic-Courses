# All Targets
all: myELF

# Tool invocations
myELF: myELF.o
	gcc -m32 -g -Wall -o myELF myELF.o

# Depends on the source and header files
myELF.o: myELF.c
	gcc -g -Wall -m32  -c myELF.c -o myELF.o


#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o myELF
