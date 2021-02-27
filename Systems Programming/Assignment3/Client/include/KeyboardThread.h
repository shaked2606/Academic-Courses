//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/27/18.
//

#ifndef CLIENT_KEYBOARDTHREAD_H
#define CLIENT_KEYBOARDTHREAD_H

#include <iostream>
#include <string>
#include "ConnectionHandler.h"
#include "Encoder.h"

using namespace std;

class KeyboardThread {

private:
    bool shouldTerminate;
    bool isLoggedIn;

public:
    KeyboardThread();
    virtual ~KeyboardThread();
    void setIsLoggedIn(bool isLoggedIn);
    void run(Encoder &encdec, ConnectionHandler &handler);
};

#endif //CLIENT_KEYBOARDTHREAD_H
