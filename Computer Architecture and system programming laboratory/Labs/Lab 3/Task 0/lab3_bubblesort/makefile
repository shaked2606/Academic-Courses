# All Targets
all: lab3_bubblesort

# Tool invocations
# Executable "lab3_bubblesort" depends on the files lab3_bubblesort.o
lab3_bubblesort: lab3_bubblesort.o 
	gcc -m32 -g -Wall -o lab3_bubblesort lab3_bubblesort.o

# Depends on the source and header files
lab3_bubblesort.o: lab3_bubblesort.c
	gcc -g -Wall -m32  -c -o lab3_bubblesort.o lab3_bubblesort.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o lab3_bubblesort
