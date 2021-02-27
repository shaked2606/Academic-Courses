# All Targets
all: myshell

# Tool invocations
# Executable "task0" depends on the files patch.o util.o start.o
myshell: myshell.o LineParser.o
	gcc -m32 -g -Wall -o myshell myshell.o LineParser.o 

# Depends on the source and header files
myshell.o: myshell.c
	gcc -g -Wall -m32  -c myshell.c -o myshell.o

LineParser.o: LineParser.c
	gcc -g -Wall -m32  -c LineParser.c -o LineParser.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o myshell
