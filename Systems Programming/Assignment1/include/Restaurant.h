#ifndef RESTAURANT_H_
#define RESTAURANT_H_

#include <vector>
#include <string>
#include <iostream>
#include "Dish.h"
#include "Table.h"
#include "Action.h"
#include "Customer.h"


class Restaurant{		
public:
	Restaurant();
    Restaurant(const std::string &configFilePath);
    Restaurant(const Restaurant& other);
	Restaurant&operator=(const Restaurant& other);
    ~Restaurant();
    Restaurant(Restaurant&& other);
    Restaurant& operator=(Restaurant &&other);

	void start();
	int getNumOfTables() const;
	Table* getTable(int ind);
	const std::vector<BaseAction*>& getActionsLog() const; // Return a reference to the history of actions
	std::vector<Dish>& getMenu();
	vector<Table*> getTables();

private:
    bool open;
    int counterOfCustomers;
    std::vector<Table*> tables;
    std::vector<Dish> menu;
    std::vector<BaseAction*> actionsLog;

	std::vector<std::string> readFile(std::string config);
	void initTables(int tablesNum, std::string capacity);
	void initMenu (std::vector<std::string> data);

	void inputClient();
	std::string getName(std::string str);
	int getTableId(std::string str);
	BaseAction* ExecuteActionByName(std::string name_action,std::string input);
	vector<Customer*> ExtractCustomers(std::string input);
};

#endif