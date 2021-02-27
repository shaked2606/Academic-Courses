# All Targets
all: task4

# Tool invocations
task4: task4.o LineParser.o
	gcc -m32 -g -Wall -o task4 task4.o LineParser.o 

# Depends on the source and header files
task4.o: task4.c
	gcc -g -Wall -m32  -c task4.c -o task4.o

LineParser.o: LineParser.c
	gcc -g -Wall -m32  -c LineParser.c -o LineParser.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o task4
