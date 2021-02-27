#ifndef CUSTOMER_H_
#define CUSTOMER_H_

#include <vector>
#include <string>
#include "Dish.h"

class Customer{
public:
    Customer(std::string c_name, int c_id);
    Customer(const Customer &other);
    virtual ~Customer();

    std::string getName() const;
    int getId() const;

    virtual std::vector<int> order(const std::vector<Dish> &menu)=0;
    virtual std::string toString() const = 0;
    virtual Customer* clone()=0;

private:
    const std::string name;
    const int id;
};


class VegetarianCustomer : public Customer {
public:
    VegetarianCustomer(std::string name, int id);
    VegetarianCustomer(const VegetarianCustomer &other);
    ~VegetarianCustomer();

    std::vector<int> order(const std::vector<Dish> &menu);
    std::string toString() const;
    Customer* clone();

private:
};


class CheapCustomer : public Customer {
public:
    CheapCustomer(std::string name, int id);
    CheapCustomer(const CheapCustomer &other);
    ~CheapCustomer();

    std::vector<int> order(const std::vector<Dish> &menu);
    std::string toString() const;
    Customer* clone();

private:
    bool firstOrder;
};


class SpicyCustomer : public Customer {
public:
    SpicyCustomer(std::string name, int id);
    SpicyCustomer(const SpicyCustomer &other);
    ~SpicyCustomer();

    std::vector<int> order(const std::vector<Dish> &menu);
    std::string toString() const;
    Customer* clone();

private:
    bool firstOrder;
};


class AlchoholicCustomer : public Customer {
public:
    AlchoholicCustomer(std::string name, int id);
    AlchoholicCustomer(const AlchoholicCustomer &other);
    ~AlchoholicCustomer();

    std::vector<int> order(const std::vector<Dish> &menu);
    std::string toString() const;
    Customer* clone();

private:
     int minId;
     int minPrice;
     int ordersCount;
    std::vector<Dish> alcMenu;
};


#endif