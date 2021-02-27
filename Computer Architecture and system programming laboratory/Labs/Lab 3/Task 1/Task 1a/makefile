# All Targets
all: virusDetector

# Tool invocations
# Executable "virusDetector" depends on the files virusDetector.o
virusDetector: virusDetector.o 
	gcc -m32 -g -Wall -o virusDetector virusDetector.o

# Depends on the source and header files
virusDetector.o: virusDetector.c
	gcc -g -Wall -m32  -c -o virusDetector.o virusDetector.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o virusDetector
