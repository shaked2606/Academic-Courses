//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/27/18.
//

#include "KeyboardThread.h"


KeyboardThread::KeyboardThread():shouldTerminate(false), isLoggedIn(false){}

KeyboardThread::~KeyboardThread() {}

void KeyboardThread::setIsLoggedIn(bool loggedIn) {
  this->isLoggedIn = loggedIn;
}

void KeyboardThread::run(Encoder &enc, ConnectionHandler &handler) {

    while (!shouldTerminate) {
        string line;
        getline(cin, line);

        if (line=="LOGOUT" && isLoggedIn) {
            shouldTerminate=true;
        }

        vector<char> toSend = enc.encode(line);
        char arr[toSend.size()];

        for (unsigned int i = 0; i < toSend.size() && i < toSend.size(); i++) {
            arr[i] = toSend.at(i);
        }

        if (!handler.sendBytes(arr, toSend.size())) {
            break;
        }

        toSend.clear();
    }
}