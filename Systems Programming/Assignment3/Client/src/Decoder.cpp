//
// Created by yuval1@wincs.cs.bgu.ac.il on 1/5/19.
//

#include "Decoder.h"


Decoder:: Decoder(): output(), finished(false), bytesCounter(0), opcode(), msgOpcode(), counter(), usersNum(0), bytes() {
}


// returns true if message finished
bool Decoder:: decodeNextByte(char nextByte[], string& answer) {

    //cout << "Bytes Counter: " << bytesCounter << endl;

    finished = false;
    char byte = nextByte[0];

    switch (bytesCounter) {
        case 0: {
            bytes.push_back(byte);
            break;
        }
        case 1: {
            bytes.push_back(byte);
            opcode = getShort();
            break;
        }
    }
    if (bytesCounter > 1) {
        switch (opcode) {
            case 9: {   // notification
                if (bytesCounter==2) {
                    output += "NOTIFICATION ";

                    if (byte == '0') {     // notification type
                        output +=  "PM ";
                    }
                    else {
                        output += "Public ";
                    }
                }
                else {
                    if (counter==0) {
                        if (byte != '\0') {
                            bytes.push_back(byte);
                        }
                        else {
                            string postingUser = popString();
                            output += postingUser + " ";
                            counter++;
                        }
                    }

                    else {
                        if (byte != '\0') {
                            bytes.push_back(byte);
                        }
                        else {
                            string content = popString();
                            output += content;

                            answer = output;
                            completeAndReset();
                        }
                    }
                }
                break;
            }

            case 10: { // ack

                if (bytesCounter == 2) {
                    output += "ACK ";
                    setMsgOpcode(byte);
                }

                if(bytesCounter == 3) {
                    setMsgOpcode(byte);
                    switch (msgOpcode) {
                        case 1:
                        case 2:
                        case 3:
                        case 5:
                        case 6: {
                            answer = output;
                            completeAndReset();
                            break;
                        }
                    }
                }
                if (bytesCounter >= 4) {
                    switch (msgOpcode) {
                        case 4: {
                            if (extractUsersList(byte)) {
                                answer = output;
                                completeAndReset();
                            }
                            break;
                        }
                        case 7: {
                            if (extractUsersList(byte)) {
                                answer = output;
                                completeAndReset();
                            }
                            break;
                        }
                        case 8: {
                            if (bytesCounter < 10) {
                                getShortAndAdd(byte);
                            }
                            if (bytesCounter==9) {
                                answer = output;
                                completeAndReset();
                            }
                            break;
                        }
                    }
                }
                break;
            }

            case 11: {   // error

                if (bytesCounter==2) {
                    output += "ERROR ";
                    setMsgOpcode(byte);
                }
                if (bytesCounter==3) {
                    setMsgOpcode(byte);
                    answer = output;
                    completeAndReset();
                }
                break;
            }

        }
    }

    bytesCounter++;

    return finished;
}



void Decoder::completeAndReset() {
    finished = true;
    output = "";
    bytesCounter = -1;
    opcode = 0;
    msgOpcode = 0;
    usersNum = 0;
    counter = 0;
}

// returns true if finished to read users list
bool Decoder::extractUsersList(char byte) {
    bool isFinished = false;

    if (bytesCounter <= 5) {
        setUsersNum(byte);
    }
    if (bytesCounter > 5) {

        if (counter < usersNum) {
            if (byte != '\0') {     //appending bytes of username
                bytes.push_back(byte);
            }
            else {     //end of bytes of username
                string username = popString();
                output += username + " ";
                counter++;
            }
        }
        if (counter==usersNum) {
            isFinished = true;
            counter=0;
        }
    }
    return isFinished;
}

void Decoder::setUsersNum(char byte) {
    switch (bytesCounter) {
        case 4: {
            bytes.push_back(byte);
            break;
        }
        case 5: {
            bytes.push_back(byte);
            usersNum = getShort();
            output += " " + to_string(usersNum) + " ";
            break;
        }
    }
}

void Decoder::getShortAndAdd(char byte) {
    switch (counter) {
        case 0: {
            bytes.push_back(byte);
            counter++;

            break;
        }
        case 1: {
            bytes.push_back(byte);
            output += " " + to_string(getShort());
            counter=0;
            break;
        }
    }
}


short Decoder:: getShort () {
    char tmp[2];
    tmp[0] = bytes.at(0);
    tmp[1] = bytes.at(1);

    bytes.clear();

    return bytesToShort(tmp);
}

void Decoder:: setMsgOpcode (char byte) {
    switch (bytesCounter) {
        case 2: {
            bytes.push_back(byte);
            break;
        }
        case 3: {
            bytes.push_back(byte);
            msgOpcode = getShort();
            output += to_string(msgOpcode);
            break;
        }
    }
}

string Decoder:: popString() {
    char tmp[bytes.size()];
    for (unsigned int i=0; i<bytes.size(); i++) {
        tmp[i] = bytes.at(i);
    }
    bytes.clear();

    string str;
    for (char curr: tmp) {    // builds string from bytes
        str.push_back(curr);
    }

    return str;
}

short Decoder::bytesToShort(char* bytesArr) {
    short result = (short)((bytesArr[0] & 0xff) << 8);
    result += (short)(bytesArr[1] & 0xff);
    return result;
}



