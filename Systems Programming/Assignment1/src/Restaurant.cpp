//
// Created by yuvi on 11/4/18.
//

#include "Restaurant.h"
#include <fstream>
#include "cstdlib"

using namespace std;

//Default Constructor
Restaurant::Restaurant():open(false),counterOfCustomers(0),tables(),menu(),actionsLog(){}

//Counstructor
Restaurant::Restaurant(const string &configFilePath):open(false),counterOfCustomers(0),tables(),menu(),actionsLog() {
    vector<string> data = readFile(configFilePath);

    //Initialize tables
    // data[0] holds num of tables,data[1] holds info of capacities
    int numOfTables = stoi(data[0]);
    initTables(numOfTables, data[1]);

    //Initialize menu
    initMenu(data);
}

//Copy Constructor
Restaurant::Restaurant(const Restaurant& other): open(other.open), counterOfCustomers(other.counterOfCustomers),tables(), menu(),actionsLog(){
    for (Table* curr: other.tables) {
        Table* toAdd = new Table(*curr);
        tables.push_back(toAdd);
    }

    for (BaseAction* curr: other.actionsLog) {
        BaseAction* toAdd = curr->clone();
        actionsLog.push_back(toAdd);
    }

    for (Dish curr: other.menu) {
        menu.push_back(curr);
    }
}

// Assignment Operator
Restaurant& Restaurant::operator=(const Restaurant& other){
    if(this != &other)
    {
        open = other.open;
        counterOfCustomers = other.counterOfCustomers;

        for(unsigned int i=0;i<(tables.size());i++) {
            delete tables[i];
        }
        tables.clear();
        for(unsigned int i=0;i<other.tables.size();i++) {
            Table* currTable = new Table(*other.tables[i]);
            tables.push_back(currTable);
        }

        for(unsigned int i=0;i<actionsLog.size();i++) {
            delete actionsLog[i];
        }
        actionsLog.clear();

        for(unsigned int i=0;i<other.actionsLog.size();i++) {
            BaseAction* currAction = other.actionsLog[i]->clone();
            actionsLog.push_back(currAction);
        }

        menu.clear();
        for (unsigned int i=0; i<other.menu.size(); i++) {
            menu.push_back(other.menu[i]);
        }
    }
    return *this;
}

//Destructor
Restaurant::~Restaurant(){
    for(unsigned int i=0;i<tables.size();i++)
        delete tables[i];
    tables.clear();

    for(unsigned int i=0;i<actionsLog.size();i++)
        delete actionsLog[i];
    actionsLog.clear();

    menu.clear();
}

// Move constructor
Restaurant::Restaurant(Restaurant&& other):
open(other.open),counterOfCustomers(other.counterOfCustomers),tables(other.tables),menu(std::move(other.menu)) ,actionsLog(other.actionsLog)
{
    other.tables.clear();
    other.actionsLog.clear();
}

// Move Assignment
Restaurant& Restaurant::operator=(Restaurant &&other){
    open = other.open;
    counterOfCustomers = other.counterOfCustomers;

    for(unsigned int i=0;i< tables.size();i++)
        delete tables[i];
    tables = other.tables;
    other.tables.clear();

    for(unsigned int i=0;i<actionsLog.size();i++)
        delete actionsLog[i];
    actionsLog = other.actionsLog;
    other.actionsLog.clear();

    menu.clear();
    for (unsigned int i=0; i<other.menu.size(); i++) {
        Dish d = (other.menu[i]).clone();
        menu.push_back(d);
    }
    other.menu.clear();

    return *this;
}

vector<Table *> Restaurant::getTables() {
    return tables;
}

vector<Dish> &Restaurant::getMenu() {
    return menu;
}

const vector<BaseAction*>& Restaurant::getActionsLog() const{
    return actionsLog;
}

int Restaurant::getNumOfTables() const {
    return tables.size();
}

Table *Restaurant::getTable(int ind) {  // returns nullptr if table doesn't exist
    Table* table = nullptr;
    if ((((unsigned)ind) >= 0) & (((unsigned)ind) < tables.size()))
        table = tables[ind];

    return table;
}

// returns vector with data from config file
vector<string> Restaurant::readFile(string config) {
    ifstream inFile;
    inFile.open(config);

    if (inFile.fail()) {
        cerr << "Error Opening File" << endl;
        exit(1);
    }

    string item;
    vector <string> data;
    while (getline(inFile,item)) {
        if (item != "" && item.at(0) != '#')
            data.push_back(item);
    }
    return data;
}

//Initializes tables according to config
 void Restaurant::initTables(int tablesNum, string capacity) {
    int end = 0;

    for(int i=0; end!=-1; i++) {

        end = capacity.find_first_of(",");

        if (end != -1) {
            string tableCapacity1 = capacity.substr(0, end);
            int tableCapacity = stoi(tableCapacity1);
            capacity = capacity.substr(end+1);

            Table* table = new Table(tableCapacity);
            tables.push_back(table);
        }

            // last table
        else {
            int tableCapacity = stoi(capacity);

            Table* table = new Table(tableCapacity);
            tables.push_back(table);
        }
    }

    return;
}

//Initializes menu according to config
 void Restaurant::initMenu (vector<string> data) {

    int idCounter = 0;
    if(data.size()>=2){
        for (unsigned int i = 2; i < data.size(); i++) {
            string currDish = data[i];

            int comma = currDish.find_first_of(',');
            string name = currDish.substr(0, comma);  //dish name
            currDish = currDish.substr(comma + 1);

            comma = currDish.find_first_of(',');
            string type_s = currDish.substr(0, comma);  //dish type

            DishType type;

            if (type_s == "VEG")
                type = VEG;

            else if (type_s == "SPC")
                type = SPC;

            else if (type_s == "BVG")
                type = BVG;

            else if (type_s == "ALC")
                type = ALC;

            currDish = currDish.substr(comma + 1);   //dish price- end of string
            int price = stoi(currDish);
            Dish dish(idCounter, name, price, type);
            menu.push_back(dish);
            idCounter++;
        }
    }
    return;
}


void Restaurant::start() {
    open = true;
    cout << "Restaurant is now open! " << endl;
    inputClient();
}

// receives command from user and performs it
void Restaurant::inputClient() {
    string input("");
    string name_action;
    while(name_action != "closeall") {
        getline(cin,input);
        name_action = getName(input);                     //extracting the name of the action from the input
        if (input.size() > name_action.size())
            input = input.substr(name_action.size() + 1); //input without the first part of the name action

        BaseAction* action = ExecuteActionByName(name_action,input); //executing the action by name of action + input details
        actionsLog.push_back(action);
    }
}

// returns name of action from text
string Restaurant::getName(string str) {
    string nameOfAction(str);
    int end = str.find_first_of(" ");
    if(end != -1)
        nameOfAction = str.substr(0,end);

    return nameOfAction;
}

// returns table id from text
int Restaurant::getTableId(string str) {
    int tableId;
    int end = str.find_first_of(" ");
    if(end != -1)
        tableId = stoi(str.substr(0,end));

    else
        tableId = stoi(str);

    return tableId;
}

//processes input and performs actions
BaseAction* Restaurant::ExecuteActionByName(string name_action, string input) {
    BaseAction *action;
    int sizeOfCustomerslist = 0;

    if (name_action == "open") {
        int table_id = stoi(input.substr(0, 2));
        input = input.substr(2);
        vector<Customer *> customersList = ExtractCustomers(input);
        action = new OpenTable(table_id, customersList);
        sizeOfCustomerslist = customersList.size();
    }

    else if (name_action == "order") {
        int tableId = getTableId(input);
        action = new Order(tableId);
    }

    else if (name_action == "move") {
        int src = stoi(input.substr(0, 2));  // source table

        input = input.substr(2);
        int dst = stoi(input.substr(0, 2));  // destination table

        input = input.substr(2);
        int id = stoi(input); //now we have just the id of the customer

        action = new MoveCustomer(src, dst, id);
    }

    else if (name_action == "close")
        action = new Close(stoi(input));

    else if (name_action == "closeall")
        action = new CloseAll();

    else if (name_action == "menu")
        action = new PrintMenu();

    else if (name_action == "status")
        action = new PrintTableStatus(stoi(input));

    else if (name_action == "log")
        action = new PrintActionsLog();

    else if (name_action == "backup")
        action = new BackupRestaurant();

    else if (name_action == "restore")
        action = new RestoreResturant();

    action->act(*this);    // perform action

    //if OpenTable got an error- change back counter
    if(name_action == "open" &&action->getStatus() == 2)
        counterOfCustomers-=sizeOfCustomerslist; // because the action didn't execute
    return action;
}

// returns customers list according to text
vector<Customer*> Restaurant::ExtractCustomers(string input) {
    vector<Customer *> customersList;
    string name = "";
    string strategy = "";
    while (input != "") {
        int ch = input.find_first_of(',');       //index of comma
        name = input.substr(0, ch);             //customer's name
        input = input.substr(ch+1);           //remove name and comma
        ch = input.find_first_of(' ');       //index of space

        strategy = input.substr(0, ch);      //customer's strategy
        if(input != strategy)
            input = input.substr(ch + 1);      //remove strategy and space
        else                                //no more customers
            input = "";

        if (strategy == "chp")
            customersList.push_back(new CheapCustomer(name, counterOfCustomers));

        else if (strategy == "veg")
            customersList.push_back(new VegetarianCustomer(name, counterOfCustomers));

        else if (strategy == "spc")
            customersList.push_back(new SpicyCustomer(name, counterOfCustomers));

        else if (strategy == "alc")
            customersList.push_back(new AlchoholicCustomer(name, counterOfCustomers));
        counterOfCustomers++;
    }
    return customersList;
}