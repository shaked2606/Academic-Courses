//
// Created by yuval1@wincs.cs.bgu.ac.il on 1/5/19.
//

#ifndef CLIENT_DECODER_H
#define CLIENT_DECODER_H

#include <string>
#include <vector>
#include <sstream>
#include <iostream>

using namespace std;

class Decoder {


public:
    Decoder();
    bool decodeNextByte(char nextByte[], string& answer);
    void completeAndReset();
    short bytesToShort(char* bytesArr);
    short getShort();
    void getShortAndAdd(char byte);
    void setMsgOpcode(char byte);
    string popString();
    bool extractUsersList(char byte);

private:
    string output;
    bool finished;
    int bytesCounter;
    int opcode;
    int msgOpcode;
    int counter;
    short usersNum;
    vector<char> bytes;

    void setUsersNum(char byte);
};


#endif //CLIENT_DECODER_H
