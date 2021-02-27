//
// Created by yuval1@wincs.cs.bgu.ac.il on 1/5/19.
//

#ifndef CLIENT_ENCODER_H
#define CLIENT_ENCODER_H



#include <string>
#include <vector>
#include <sstream>
#include <iostream>

using namespace std;

class Encoder {


public:
    Encoder();
    vector<char> encode(string message);
    void stringToBytes(string message);
    void shortToBytes(short num);
    std::vector<std::string> split(std::string strToSplit, char delimeter);

private:
    string output;
    bool finished;
    int bytesCounter;
    int opcode;
    int msgOpcode;
    int counter;
    short usersNum;
    vector<char> bytes;
};

#endif //CLIENT_ENCODER_H
