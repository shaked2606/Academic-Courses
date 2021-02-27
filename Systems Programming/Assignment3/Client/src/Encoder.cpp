//
// Created by yuval1@wincs.cs.bgu.ac.il on 1/5/19.
//

#include "Encoder.h"

Encoder:: Encoder(): output(), finished(false), bytesCounter(0), opcode(), msgOpcode(), counter(), usersNum(0), bytes() {
}

//push string to the vector
void Encoder:: stringToBytes(string message) {
    for(unsigned int i=0; i<message.length(); ++i) {
        stringstream ss;
        ss << std::hex << (int) message.at(i);
        string hex = ss.str();

        for (unsigned int i = 0; i < hex.length(); i += 2) {
            std::string byteString = hex.substr(i, 2);
            char byte = (char) strtol(byteString.c_str(), NULL, 16);
            bytes.push_back(byte);
        }
    }
}

vector<char> Encoder:: encode(string message) {
    vector<std::string> splittedMessage = split(message,' ');
    vector<char> temp;
    string action = splittedMessage.at(0);
    short opcode;

    if (action=="REGISTER") {
        opcode = 01;
        shortToBytes(opcode);
        stringToBytes(splittedMessage.at(1));     //username
        bytes.push_back('\0');
        stringToBytes(splittedMessage.at(2));     //password
        bytes.push_back('\0');
    }

    if (action=="LOGIN") {
        opcode = 02;
        shortToBytes(opcode);
        stringToBytes(splittedMessage.at(1));       //username
        bytes.push_back('\0');
        stringToBytes(splittedMessage.at(2));      //password
        bytes.push_back('\0');
    }

    if(action == "LOGOUT"){
        opcode = 03;
        shortToBytes(opcode);
    }

    if(action == "FOLLOW"){

        opcode = 04;
        shortToBytes(opcode);

        int follow = stoi(splittedMessage.at(1));

        if(follow == 0){
            bytes.push_back(00);
        }
        else{
            if(follow == 1){
                bytes.push_back(01);
            }
        }

        short numOfUsers = stoi(splittedMessage.at(2));   //num of users
        shortToBytes(numOfUsers);

        //list of users
        for(unsigned int i=3;i<splittedMessage.size();i++) {
            stringToBytes(splittedMessage.at(i));
            bytes.push_back('\0');
        }
    }

    if(action == "POST"){
        opcode = 05;
        shortToBytes(opcode);

        for(unsigned int i=1; i<splittedMessage.size()-1;i++) {     //content
            stringToBytes(splittedMessage.at(i) + " ");
        }

        stringToBytes(splittedMessage.at(splittedMessage.size()-1));   //last word of content

        bytes.push_back('\0');
    }

    if(action == "PM"){
        opcode = 06;

        shortToBytes(opcode);

        stringToBytes(splittedMessage.at(1)); //username

        bytes.push_back('\0');

        for(unsigned int i=2; i<splittedMessage.size()-1;i++) {    //content
            stringToBytes(splittedMessage.at(i) + " ");
        }
        stringToBytes(splittedMessage.at(splittedMessage.size()-1));  //last word of content

        bytes.push_back('\0');
    }

    if(action == "USERLIST"){
        opcode = 07;
        shortToBytes(opcode);
    }

    if(action == "STAT") {
        opcode = 8;
        shortToBytes(opcode);
        stringToBytes(splittedMessage.at(1)); //username
        bytes.push_back('\0');
    }
    temp = bytes;
    bytes.clear();

    return temp;

}

void Encoder::shortToBytes(short num) {
    bytes.push_back(((num >> 8) & 0xFF));
    bytes.push_back((num & 0xFF));
}

std::vector<std::string> Encoder:: split(std::string strToSplit, char delimeter)
{
    std::stringstream ss(strToSplit);
    std::string item;
    std::vector<std::string> splittedStrings;
    while (std::getline(ss, item, delimeter))
    {
        splittedStrings.push_back(item);
    }
    return splittedStrings;
}




