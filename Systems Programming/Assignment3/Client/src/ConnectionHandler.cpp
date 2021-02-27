//
// Created by yuval1@wincs.cs.bgu.ac.il on 12/24/18.
//

#include "ConnectionHandler.h"

using boost::asio::ip::tcp;

using std::cin;
using std::cout;
using std::cerr;
using std::endl;
using std::string;

ConnectionHandler::ConnectionHandler(string host, short port): host_(host), port_(port), io_service_(), socket_(io_service_){}

ConnectionHandler::~ConnectionHandler() {
    close();
}

bool ConnectionHandler::connect() {

    try {
        tcp::endpoint endpoint(boost::asio::ip::address::from_string(host_), port_); // the server endpoint
        boost::system::error_code error;
        socket_.connect(endpoint, error);
        if (error)
            throw boost::system::system_error(error);
    }
    catch (std::exception& e) {
        return false;
    }
    return true;
}



bool ConnectionHandler::getBytes(char bytes[], unsigned int bytesToRead) {

    size_t tmp = 0;
    boost::system::error_code error;
    try {
        while (!error && bytesToRead > tmp ) {
            tmp += socket_.read_some(boost::asio::buffer(bytes+tmp, bytesToRead-tmp), error);
        }
        if(error)
            throw boost::system::system_error(error);
    } catch (std::exception& e) {
        return false;
    }
    return true;
}

bool ConnectionHandler::sendBytes(const char bytes[], int bytesToWrite) {
    int bytesWritten = 0;

    boost::system::error_code error;
    try {
        while (!error && bytesWritten<bytesToWrite) {
            bytesWritten += socket_.write_some(boost::asio::buffer(bytes + bytesWritten, bytesToWrite - bytesWritten), error);
        }
        if(error)
            throw boost::system::system_error(error);
    } catch (std::exception& e) {
        return false;
    }
    return true;
}


// Close down the connection properly.
void ConnectionHandler::close() {
    try{
        socket_.close();
    } catch (...) {
    }
}
