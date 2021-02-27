CFLAGS:=-c -Wall -Weffc++ -g -std=c++11 -Iinclude
LDFLAGS:=-lboost_system -pthread

all: BGSclient
	g++ -o bin/BGSclient bin/ConnectionHandler.o bin/Encoder.o bin/Decoder.o bin/Protocol.o bin/KeyboardThread.o  bin/BGSclient.o  $(LDFLAGS)

BGSclient: bin/ConnectionHandler.o bin/Encoder.o bin/Decoder.o  bin/Protocol.o bin/KeyboardThread.o bin/BGSclient.o

bin/ConnectionHandler.o: src/ConnectionHandler.cpp
	g++ $(CFLAGS) -o bin/ConnectionHandler.o src/ConnectionHandler.cpp

bin/Protocol.o: src/Protocol.cpp
	g++ $(CFLAGS) -o bin/Protocol.o src/Protocol.cpp
	
bin/Encoder.o: src/Encoder.cpp
	g++ $(CFLAGS) -o bin/Encoder.o src/Encoder.cpp
	
bin/Decoder.o: src/Decoder.cpp
	g++ $(CFLAGS) -o bin/Decoder.o src/Decoder.cpp	

bin/KeyboardThread.o: src/KeyboardThread.cpp
	g++ $(CFLAGS) -o bin/KeyboardThread.o src/KeyboardThread.cpp

bin/BGSclient.o: src/BGSclient.cpp
	g++ $(CFLAGS) -o bin/BGSclient.o src/BGSclient.cpp


#Clean the build directory
clean: 
	rm -f bin/*

