//
// Created by elimshak@wincs.cs.bgu.ac.il on 11/6/18.
//
#include "Action.h"
#include "Customer.h"
#include "Restaurant.h"
#include <vector>
#include <string>

extern Restaurant* backup;

/*BaseAction*/
BaseAction::BaseAction(): errorMsg(""),status(PENDING){}

//Copy Constructor
BaseAction::BaseAction(const BaseAction& other):errorMsg(other.errorMsg), status(other.status){}

BaseAction::~BaseAction() {}

ActionStatus BaseAction::getStatus() const{
    return status;
}

void BaseAction::act(Restaurant& restaurant) {}

void BaseAction::complete(){
    status = COMPLETED;
}

void BaseAction::error(std::string errorMsg){
    status = ERROR;
    this->errorMsg = errorMsg;
}

std::string BaseAction::getErrorMsg() const{
    return "Error: "+errorMsg;
}


/*OpenTable Class*/
OpenTable::OpenTable(int id, std::vector<Customer *> &customersList):
        tableId(id), customers(),log("") {

        for (Customer* curr: customersList) {
            customers.push_back(curr);
        }
}

OpenTable::~OpenTable() {
    if (getStatus()==2) {
        for(Customer* curr: customers) {
            delete curr;
        }
    }

    customers.clear();
}

void OpenTable::act(Restaurant &restaurant) {

    if (restaurant.getTable(tableId) == nullptr || restaurant.getTable(tableId)->isOpen()) {
        error("Table does not exist or is already open");
        cout << getErrorMsg() << endl;
    }

    else {
        Table *table = restaurant.getTable(tableId);

        if (((unsigned)table->getCapacity()) >= ((unsigned)customers.size())) { //there is enough available seats
            table->openTable();                                              //the table is now open
            for (unsigned int i = 0; i < customers.size(); i++) {
                table->addCustomer(customers[i]);                          //seat the customers in the table
            }
        }
        complete();
    }

    createLog();
}

void OpenTable::createLog() {
    log = "open " + to_string(tableId) + " ";

    for(unsigned int i=0;i<customers.size();i++)
        log += customers[i]->toString() + " ";
    if(this->getStatus()==2)
        log += this->getErrorMsg();
}

std::string OpenTable::toString() const {
    return log;
}

BaseAction* OpenTable::clone() {
    BaseAction* action = new OpenTable(*this);
    return action;
}

/*Order Class*/
Order::Order(int id):tableId(id){}

Order::~Order() {}

void Order::act(Restaurant &restaurant) {

    if (restaurant.getTable(tableId) == nullptr || !restaurant.getTable(tableId)->isOpen()) {
        error("Table does not exist or is not open");
        cout << getErrorMsg() << endl;
}
    else {
        Table *table = restaurant.getTable(tableId);
        table->order(restaurant.getMenu());   // takes orders, then prints
        complete();
    }
}

std::string Order::toString() const {
    string output = "order " + to_string(tableId) + " ";
    if(this->getStatus()==2)
        output += this->getErrorMsg();
    return output;
}

BaseAction* Order::clone() {
    BaseAction* action = new Order(*this);
    return action;
}

/*MoveCustomer Class*/
MoveCustomer::MoveCustomer(int src, int dst, int customerId): srcTable(src),dstTable(dst),id(customerId){}

MoveCustomer::~MoveCustomer() {}

void MoveCustomer::act(Restaurant &restaurant){
    if(checkMove(restaurant)) {
        Table* src = restaurant.getTable(srcTable);
        Table* dst = restaurant.getTable(dstTable);

        // moves customer
        Customer* toMove = src->getCustomer(id);
        dst->addCustomer(toMove);
        src->removeCustomer(id);

        // moves all orders made by customer
        for (unsigned int i=0; i<src->getOrders().size();i++)
           if (src->getOrders()[i].first==id) {
               dst->addOrder(src->getOrders()[i]);
           }

        src->removeAllCustOrders(id);

        if (src->getCustomers().size()==0)
             src->closeTable();
         complete();
    }

    else {
        error("Cannot move customer");
        cout << getErrorMsg() << endl;
    }
}

// checks whether it's possible to move customer
bool MoveCustomer::checkMove (Restaurant &restaurant) {
    bool output = true;
    Table* src = restaurant.getTable(srcTable);
    Table* dst = restaurant.getTable(dstTable);

    if (src==nullptr || dst==nullptr || !src->isOpen() || !dst->isOpen())
        output = false;

    if (output) {
        if (src->getCustomer(id) == nullptr || (unsigned(dst->getCapacity()) <= dst->getCustomers().size()))
            output = false;
    }

    return output;
}

std::string MoveCustomer::toString() const{
    string output = "move " + std::to_string(srcTable) + " " + std::to_string(dstTable) +" " +std::to_string(id) + " ";
    if(this->getStatus()==2)
        output += this->getErrorMsg();
    return output;
}

BaseAction* MoveCustomer::clone() {
    BaseAction* action = new MoveCustomer(*this);
    return action;
}


/*Close Class*/
Close::Close(int id):tableId(id){}

Close::~Close() {}

void Close::act(Restaurant &restaurant) {
    Table* table = restaurant.getTable(tableId);
    if (restaurant.getTable(tableId) == nullptr || !restaurant.getTable(tableId)->isOpen()) {
        error("Table does not exist or is not open");
        cout << getErrorMsg() << endl;
    }
    else {
        int bill = table->getBill();
        table->closeTable();
        complete();
        cout << "Table " << tableId << " was closed. Bill " << bill << "NIS\n";
    }
}

std::string Close::toString() const{
    string output = "close "+ to_string(tableId) + " ";
    if(this->getStatus()==2)
        output += this->getErrorMsg();
    return output;
}

BaseAction* Close::clone() {
    BaseAction* action = new Close(*this);
    return action;
}


/*CloseAll Class*/
CloseAll::CloseAll(){
}

CloseAll::~CloseAll() {}

void CloseAll::act(Restaurant &restaurant){
    vector<Table*> tables = restaurant.getTables();
    int billOfTable;

    // closing tables and printing bills
    for(unsigned int i=0;i<tables.size();i++) {
        if (tables[i]->isOpen()) {
            billOfTable = tables[i]->getBill();
            tables[i]->closeTable();
            cout << "Table " << i << " was closed. Bill " << billOfTable << "NIS" << endl;
        }
    }
}

std::string CloseAll::toString() const{
    return "closeall " + this->getErrorMsg();
}

BaseAction* CloseAll::clone() {
    BaseAction* action = new CloseAll(*this);
    return action;
}


/*PrintMenu Class*/
PrintMenu::PrintMenu() {}

PrintMenu::~PrintMenu() {}

void PrintMenu::act(Restaurant &restaurant) {
    vector<Dish> menu = restaurant.getMenu();
    string menuToPrint = "";

    for (unsigned int i = 0; i < menu.size(); i++) {
        Dish curr = menu[i];
        string name = curr.getName();

        int type = curr.getType();
        string type_s = whatType(type);

        int price = curr.getPrice();

        menuToPrint += name + " " + type_s + " " + to_string(price) + "NIS" + "\n";
    }

    cout << menuToPrint;

    complete();
}

string PrintMenu::whatType(int type) {
    string type_s("");
    if(type == 0)
        type_s = "VEG";
    else if(type == 1)
        type_s = "SPC";
    else if(type == 2)
        type_s = "BVG";
    else if(type == 3)
        type_s = "ALC";

    return type_s;
}

std::string PrintMenu::toString() const{
    string output = "menu ";
    return output;
}

BaseAction* PrintMenu::clone() {
    BaseAction* action = new PrintMenu(*this);
    return action;
}


/*PrintTableStatus Class*/
PrintTableStatus::PrintTableStatus(int id): tableId(id), log(""){}

PrintTableStatus::~PrintTableStatus() {}

void PrintTableStatus::act(Restaurant &restaurant) {
    Table *table = restaurant.getTable(tableId);
    string output;

    if (!table->isOpen())
        output = "Table " + to_string(tableId) + " status: closed"  + "\n";

    else {
        output = "Table " + to_string(tableId) + " status: open" + "\n";

        // adds customers
        output += "Customers:\n";
        vector<Customer *> customers = table->getCustomers();
        for (unsigned int i = 0; i < customers.size(); i++) {
            output += to_string(customers[i]->getId()) + " ";
            output += customers[i]->getName() + "\n";
        }

        // adds orders
        output += "Orders:\n";
        vector<OrderPair> orders = table->getOrders();
        for (unsigned int i = 0; i < orders.size(); i++) {
            string dishName = orders[i].second.getName();
            string dishPrice = to_string(orders[i].second.getPrice());
            string customerId = to_string(orders[i].first);

            output += dishName + " " + dishPrice + "NIS " + customerId + "\n";
        }

        output += "Current Bill: " + to_string(table->getBill()) + "NIS" + "\n";
    }

    cout << output;
    complete();
}

std::string PrintTableStatus::toString() const{
    string output = "status " + to_string(tableId) + " ";
 return output;
}

BaseAction* PrintTableStatus::clone() {
    BaseAction* action = new PrintTableStatus(*this);
    return action;
}


/*PrintActionsLog Class*/
PrintActionsLog::PrintActionsLog(): log("") {}

PrintActionsLog::~PrintActionsLog() {}

void PrintActionsLog::act(Restaurant &restaurant) {

    for (BaseAction* action: restaurant.getActionsLog()) {
        string actionString = action->toString();
        int actionStatus = action->getStatus();

        if (actionStatus == 2)       //enum 2 == ERROR
            log += actionString + "\n";

        else if (actionStatus == 0)             //using toString() methods of all actions
            log += actionString + "Pending\n";

        else if (actionStatus == 1)           //using toString() methods of all actions
            log += actionString + "Completed\n";

    }
    cout << log;
    complete();
}

std::string PrintActionsLog::toString() const{
    return "log ";
}

BaseAction* PrintActionsLog::clone() {
    BaseAction* action = new PrintActionsLog(*this);
    return action;
}


/*BackupRestaurant Class*/
BackupRestaurant::BackupRestaurant() {}

BackupRestaurant::~BackupRestaurant() {}

void BackupRestaurant::act(Restaurant &restaurant){
    if(backup==nullptr)
        backup = new Restaurant(restaurant);
    else
        *backup = restaurant;
    complete();
}

std::string BackupRestaurant::toString() const{
    return "backup ";
}

BaseAction* BackupRestaurant::clone() {
    BaseAction* action = new BackupRestaurant(*this);
    return action;
}


/*RestoreResturant Class*/
RestoreResturant::RestoreResturant(){}

RestoreResturant::~RestoreResturant() {}

void RestoreResturant::act(Restaurant &restaurant) {
    if (backup == nullptr) {
        error("No backup available");
        cout << getErrorMsg() << endl;
    }
    else {
        restaurant = *backup;
        complete();
    }
}

std::string RestoreResturant::toString() const{
    string output = "restore ";
    if(this->getStatus()==2)
        output += this->getErrorMsg();
    return output;
}

BaseAction* RestoreResturant::clone() {
    BaseAction* action = new RestoreResturant(*this);
    return action;
}