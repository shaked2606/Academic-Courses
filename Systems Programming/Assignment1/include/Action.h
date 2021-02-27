#ifndef ACTION_H_
#define ACTION_H_

#include <string>
#include <iostream>
#include <vector>
#include "Customer.h"


enum ActionStatus{
    PENDING, COMPLETED, ERROR
};

//Forward declaration
class Restaurant;

class BaseAction{
public:
    BaseAction();
    BaseAction(const BaseAction& other);
    virtual ~BaseAction()=0;

	virtual void act(Restaurant& restaurant)=0;
	virtual std::string toString() const=0;
    ActionStatus getStatus() const;
	virtual BaseAction* clone()=0;

protected:
    void complete();
    void error(std::string errorMsg);
    std::string getErrorMsg() const;
private:
    std::string errorMsg;
    ActionStatus status;
};


class OpenTable : public BaseAction {
public:
    OpenTable(int id, std::vector<Customer *> &customersList);
    ~OpenTable();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
	const int tableId;
	std::vector<Customer *> customers;
	std::string log;
	void createLog();
};


class Order : public BaseAction {
public:
    Order(int id);
    ~Order();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
    const int tableId;
};


class MoveCustomer : public BaseAction {
public:
    MoveCustomer(int src, int dst, int customerId);
    ~MoveCustomer();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
    const int srcTable;
    const int dstTable;
    const int id;
    bool checkMove(Restaurant &restaurant);
};


class Close : public BaseAction {
public:
    Close(int id);
    ~Close();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
    const int tableId;
};


class CloseAll : public BaseAction {
public:
    CloseAll();
    ~CloseAll();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
};


class PrintMenu : public BaseAction {
public:
    PrintMenu();
    ~PrintMenu();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
    std::string whatType(int type);
};


class PrintTableStatus : public BaseAction {
public:
    PrintTableStatus(int id);
    ~PrintTableStatus();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
    const int tableId;
    std::string log;
};


class PrintActionsLog : public BaseAction {
public:
    PrintActionsLog();
    ~PrintActionsLog();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
	std::string log;
};


class BackupRestaurant : public BaseAction {
public:
    BackupRestaurant();
    ~BackupRestaurant();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();
private:
};


class RestoreResturant : public BaseAction {
public:
    RestoreResturant();
    ~RestoreResturant();
    void act(Restaurant &restaurant);
    std::string toString() const;
	BaseAction* clone();

};


#endif