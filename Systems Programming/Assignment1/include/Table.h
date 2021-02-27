#ifndef TABLE_H_
#define TABLE_H_

#include <vector>
#include "Customer.h"
#include "Dish.h"

using namespace std;

typedef std::pair<int, Dish> OrderPair;

class Table{
public:
    Table(int t_capacity);
    Table (const Table &other);
    Table& operator= (const Table &other);
    ~Table();
    Table (Table&& other);
    Table& operator=(Table &&other);

    int getCapacity() const;
    std::vector<Customer*>& getCustomers();
    std::vector<OrderPair>& getOrders();
    bool isOpen();
    int getBill();

    void openTable();
    void closeTable();

    Customer* getCustomer(int id);
    void addCustomer(Customer* customer);
    void removeCustomer(int id);
    void removeAllCustomers();

    void order(const std::vector<Dish> &menu);
    void addOrder(OrderPair order);
    void removeAllCustOrders(int customerId);

private:
    int capacity;
    bool open;
    std::vector<Customer*> customersList;
    std::vector<OrderPair> orderList; //A list of pairs for each order in a table - (customer_id, Dish)
};


#endif