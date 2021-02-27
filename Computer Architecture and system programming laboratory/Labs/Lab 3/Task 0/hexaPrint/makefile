# All Targets
all: hexaPrint

# Tool invocations
# Executable "hexaPrint" depends on the files hexaPrint.o
hexaPrint: hexaPrint.o 
	gcc -m32 -g -Wall -o hexaPrint hexaPrint.o

# Depends on the source and header files
hexaPrint.o: hexaPrint.c
	gcc -g -Wall -m32  -c -o hexaPrint.o hexaPrint.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o hexaPrint
