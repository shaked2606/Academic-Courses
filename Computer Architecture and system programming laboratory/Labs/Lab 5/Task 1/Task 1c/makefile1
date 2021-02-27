# All Targets
all: task1

# Tool invocations
# Executable "task0" depends on the files patch.o util.o start.o
task1: task1.o LineParser.o
	gcc -m32 -g -Wall -o task1 task1.o LineParser.o 

# Depends on the source and header files
task1.o: task1.c
	gcc -g -Wall -m32  -c task1.c -o task1.o

LineParser.o: LineParser.c
	gcc -g -Wall -m32  -c LineParser.c -o LineParser.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o task1
