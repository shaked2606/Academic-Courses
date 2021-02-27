//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/26/18.
//

#ifndef CLIENT_PROTOCOL_H
#define CLIENT_PROTOCOL_H

#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include <stdlib.h>
#include "KeyboardThread.h"

using namespace std;

class Protocol {
public:
    Protocol();
    bool process(KeyboardThread &keyboard, string answer);


private:
    string output;

};


#endif //CLIENT_PROTOCOL_H
