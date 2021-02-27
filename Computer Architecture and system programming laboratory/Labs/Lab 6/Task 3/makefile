# All Targets
all: task3

# Tool invocations
task3: task3.o LineParser.o
	gcc -m32 -g -Wall -o task3 task3.o LineParser.o 

# Depends on the source and header files
task3.o: task3.c
	gcc -g -Wall -m32  -c task3.c -o task3.o

LineParser.o: LineParser.c
	gcc -g -Wall -m32  -c LineParser.c -o LineParser.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o task3
