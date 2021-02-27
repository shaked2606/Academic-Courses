//
// Created by yuvi on 11/4/18.
//

#include "Table.h"
#include <string>
#include <iostream>

//Constructor
Table::Table(int t_capacity): capacity(t_capacity), open(false),customersList(),orderList(){}

//Copy Constructor
Table::Table(const Table &other): capacity(other.capacity), open(other.open), customersList(), orderList(){

    // copy customers list
    for (Customer* curr: other.customersList) {
        Customer* toInsert = curr->clone();
        customersList.push_back(toInsert);
    }

    // copy orders list
    for (OrderPair curr: other.orderList) {
        orderList.push_back(curr);
    }
}

// Assignment Operator
Table& Table::operator= (const Table &other) {
    if (this!=&other) {
        capacity = other.capacity;
        open = other.open;

        // delete and copy customers list
        for(unsigned int i=0; i<customersList.size();i++) {
            delete customersList[i];
        }
        customersList.clear();

        for (Customer* curr: other.customersList) {
            Customer* toInsert = curr->clone();
            customersList.push_back(toInsert);
        }

        // delete and copy orders list
        orderList.clear();
        for (unsigned int i=0; i<other.orderList.size();i++) {
            orderList.push_back(other.orderList[i]);
        }
    }
    return *this;
}

//Destructor
Table::~Table() {
    for(unsigned int i=0; i<customersList.size();i++)
        delete customersList[i];
    customersList.clear();
    orderList.clear();
}

// Move constructor
Table::Table (Table&& other):
        capacity(other.capacity), open(other.open), customersList(other.customersList), orderList(other.orderList) {}

// Move assignment
Table& Table::operator=(Table &&other) {
    if (this!=&other) {
        capacity=other.capacity;
        open = other.open;

        // delete and move customers list
        for(unsigned int i=0; i<customersList.size();i++)
            delete customersList[i];
        customersList = other.customersList;
        other.customersList.clear();

        // delete and move order list
        orderList.clear();
        for (unsigned int i=0; i<other.orderList.size(); i++) {
            Dish toInsert(other.orderList[i].second);
            OrderPair tmp(other.orderList[i].first, toInsert);
            orderList.push_back(tmp);
        }
        other.orderList.clear();
    }

    return *this;
}

int Table::getCapacity() const {
    return capacity;
}

vector<Customer*>& Table::getCustomers() {
    return customersList;
}

vector<OrderPair>& Table::getOrders(){
    return orderList;
}

bool Table::isOpen(){
    return open;
}

int Table::getBill() {
    int bill = 0;

    for (unsigned int i = 0; i < orderList.size(); i++)
        bill += orderList[i].second.getPrice();

    return bill;
}

void Table::openTable() {
    open = true;
}

void Table::closeTable() {
    open = false;
    removeAllCustomers();
    orderList.clear();
}

Customer* Table::getCustomer(int id) {
    bool found = false;
    Customer *ret = nullptr;

    for (unsigned int i = 0; (!found) & (i < customersList.size()); i++) {
        if (customersList[i]->getId() == id) {
            found = true;
            ret = customersList[i];
        }
    }
    return ret;
}

void Table::addCustomer(Customer *customer) {
    if (((unsigned)customersList.size()) < ((unsigned)capacity)) {
        customersList.push_back(customer);
    }
}

void Table::removeCustomer(int id) {
    bool found = false;
    for (unsigned int i = 0; (!found) & (i < customersList.size()); i++) {
        if (customersList[i]->getId() == id) {
            found = true;
            customersList.erase(customersList.cbegin()+ i);
        }
    }
}

void Table::removeAllCustomers() {
    for(unsigned int i=0;i<customersList.size();i++)
        delete customersList[i];
    customersList.clear();
}

void Table::order(const std::vector<Dish> &menu) {
    // each customer orders according to strategy
    for(Customer* currCustomer: customersList) {
        vector<int> currOrder = currCustomer->order(menu);
        int customerId = currCustomer->getId();

        for(int dishId: currOrder) {
            OrderPair curr(customerId, menu[dishId]);
            orderList.push_back(curr);

            // print order
            cout <<  currCustomer->getName() << " ordered " << menu[dishId].getName() << endl;
        }
    }
}

void Table::addOrder(OrderPair order) {
    orderList.push_back(order);
}

// removes all orders of specific customer
void Table::removeAllCustOrders(int customerId) {
    vector<OrderPair> tmpList;

    for (OrderPair curr: orderList) {
        if (curr.first != customerId) {
            tmpList.push_back(curr);
        }
    }

    orderList.clear();

    for (OrderPair curr: tmpList) {
        orderList.push_back(curr);
    }
    tmpList.clear();
}