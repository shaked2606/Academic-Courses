# All Targets
all: task1c

# Tool invocations
# Executable "task1c" depends on the files task1c.o
task1c: task1c.o 
	gcc -m32 -g -Wall -o task1c task1c.o

# Depends on the source and header files
task1c.o: task1c.c
	gcc -g -Wall -m32  -c -o task1c.o task1c.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o task1c
