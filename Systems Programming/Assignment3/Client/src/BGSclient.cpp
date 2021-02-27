//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/26/18.
//

#include "Encoder.h"
#include "Decoder.h"
#include "Protocol.h"
#include "ConnectionHandler.h"
#include "KeyboardThread.h"

#include <thread>

int main (int argc, char *argv[]) {

    if (argc < 3) {
        return -1;
    }

    // Connect to Server
    std::string host = argv[1];
    short port = stoi(argv[2]);

    Encoder *enc = new Encoder();
    Decoder dec;

    ConnectionHandler handler(host, port);

    if (!handler.connect()) {
        delete enc;
        return 1;
    }

    KeyboardThread task;
    std::thread th1(&KeyboardThread::run, &task,std::ref(*enc),std::ref(handler));

    Protocol protocol;

    bool shouldTerminate = false;

    while (!shouldTerminate) {
        char byte[1];

        handler.getBytes(byte, 1);

        string answer;
        bool isFinished = dec.decodeNextByte(byte, answer);
        if (isFinished) {
            shouldTerminate = protocol.process(std::ref(task), answer);
        }
    }

    th1.join();
    delete enc;

    return 0;
}
