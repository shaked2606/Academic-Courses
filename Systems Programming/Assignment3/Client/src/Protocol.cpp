//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/26/18.
//

#include "Protocol.h"

Protocol:: Protocol(): output() {}

// returns true if client should terminate
bool Protocol::process(KeyboardThread &keyboard, string answer) {
    std::cout << answer << endl;

    if (answer.at(0) == 'A') {  // ack message
        short msgOpcode = stoi(answer.substr(4, 1));

        switch (msgOpcode) {
            case 2: {
                keyboard.setIsLoggedIn(true);
                break;
            }
            case 3:   // logout message - user should terminate
                return true;
        }
    }

    return false;
}
