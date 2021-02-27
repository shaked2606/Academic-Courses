# All Targets
all: addresses

# Tool invocations
# Executable "addresses" depends on the files addresses.o
addresses: addresses.o 
	gcc -m32 -g -Wall -o addresses addresses.o

# Depends on the source and header files
addresses.o: addresses.c
	gcc -g -Wall -m32  -c -o addresses.o addresses.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o addresses
