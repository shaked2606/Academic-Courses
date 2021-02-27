//
// Created by yuvi on 11/4/18.
//

#include "Customer.h"
#include <iostream>

using namespace std;

/*Customer Class*/

//Constructor
Customer::Customer(string c_name, int c_id): name(c_name), id(c_id) {}

//Copy Constructor
Customer::Customer(const Customer &other): name(other.name), id(other.id) {}

//Destructor
Customer::~Customer() {}

string Customer::getName() const {
    return name;
}

int Customer::getId() const {
    return id;
}


/*VegetarianCustomer Class*/

//Constructor
VegetarianCustomer::VegetarianCustomer(string name, int id): Customer(name, id) {}

//Copy Constructor
VegetarianCustomer::VegetarianCustomer(const VegetarianCustomer &other): Customer(other) {}

//Destructor
VegetarianCustomer::~VegetarianCustomer() {}

//Derived method - order
vector<int> VegetarianCustomer::order(const vector<Dish> &menu) {
    int vegId = -1;
    bool vegFound = false;

    int bevId = -1;
    int maxBevPrice = 0;

    for (unsigned int i = 0; i < menu.size(); i++) {
        Dish currDish = menu[i];
        if (!vegFound && (currDish.getType() == VEG)) {
            vegId = currDish.getId();
            vegFound = true;
        }
        else if (currDish.getType() == BVG && currDish.getPrice() > maxBevPrice) {
            maxBevPrice = currDish.getPrice();
            bevId = currDish.getId();
        }
    }

    if (vegId == -1 || bevId == -1) {
        vector<int> ret{};
        return ret;
    }
    else{
        vector<int> ret{vegId, bevId};
        return ret;
    }
}

//Derieved Method - toString
string VegetarianCustomer::toString() const{
    return getName()+",veg";
}

Customer* VegetarianCustomer::clone(){
    VegetarianCustomer* customer = new VegetarianCustomer(*this);
    return customer;
}

/*CheapCustomer*/

//Constructor
CheapCustomer::CheapCustomer(string name, int id): Customer(name, id),firstOrder(true) {}

//Copy Constructor
CheapCustomer::CheapCustomer(const CheapCustomer &other): Customer(other),firstOrder(other.firstOrder) {}

//Destructor
CheapCustomer::~CheapCustomer() {}

//Derived method - order
vector<int> CheapCustomer::order(const vector<Dish> &menu) {
    if (firstOrder & ((unsigned)menu.size()>0)) {
        int dishId = menu[0].getId();
        int minPriceDish = menu[0].getPrice();

        for (unsigned int i = 1; i < menu.size(); i++) {
            Dish currDish = menu[i];
            if (currDish.getPrice() < minPriceDish) {
                dishId = currDish.getId();
                minPriceDish = currDish.getPrice();
            }
        }
        firstOrder = false;
        vector<int> ret{dishId};

        return ret;
    }

    vector<int> ret {};
    return ret;
}

//Derieved Method - toString
string CheapCustomer::toString() const{
    string ret = getName()+",chp";
    return ret;
}

Customer* CheapCustomer::clone(){
    CheapCustomer* customer = new CheapCustomer(*this);
    return customer;
}

/*SpicyCustomer Class*/

//Constructor
SpicyCustomer::SpicyCustomer(string name, int id): Customer(name, id),firstOrder(true) {}

//Copy Constructor
SpicyCustomer::SpicyCustomer(const SpicyCustomer &other): Customer(other),firstOrder(other.firstOrder){}

//Destructor
SpicyCustomer::~SpicyCustomer() {}

//Derived method - order
vector<int>  SpicyCustomer::order(const vector<Dish> &menu){
    if(firstOrder) {
        int spcDishId = -1;
        int maxPrice = 0;

        // finds most expensive spicy dish
        for (unsigned int i = 0; i < menu.size(); i++) {
            Dish currDish = menu[i];
            if (currDish.getType() == SPC && currDish.getPrice() > maxPrice) {
                spcDishId = currDish.getId();
                maxPrice = currDish.getPrice();
            }
        }
        if(spcDishId != -1) {
            firstOrder = false;
            vector<int> ret {spcDishId};
            return ret;
        }
        else {
            vector<int> ret {};
            return ret;
        }
    }

    else {
        int bvgId;
        int chpPriceBvg;
        bool found = false;

        // finds cheapest beverage (non-alc)
        for (unsigned int i = 0; i < menu.size(); i++) {
            Dish currDish = menu[i];
            if ((currDish.getType() == BVG) & !found) {
                chpPriceBvg = currDish.getPrice();
                bvgId = currDish.getId();
                found = true;
            }

            else if ((currDish.getType()==BVG) && (chpPriceBvg > currDish.getPrice())) {
                bvgId = currDish.getId();
                chpPriceBvg = currDish.getPrice();
            }
        }
        if (found) {
            vector<int> ret{bvgId};
            return ret;
        } else {
            vector<int> ret{};
            return ret;
        }
    }
}

//Derieved Method - toString
string  SpicyCustomer::toString() const {
    string ret = getName() + ",spc";
    return ret;
}

Customer* SpicyCustomer::clone(){
    SpicyCustomer* customer = new SpicyCustomer(*this);
    return customer;
}

/*AlcoholicCustomer*/

//Constructor
AlchoholicCustomer::AlchoholicCustomer(std::string name, int id):Customer(name,id),minId(0),minPrice(0),ordersCount(0),alcMenu(){}

//Copy Constructor
AlchoholicCustomer::AlchoholicCustomer(const AlchoholicCustomer &other):Customer(other),minId(other.minId),minPrice(other.minPrice),ordersCount(other.ordersCount),alcMenu(other.alcMenu){}

//Destructor
AlchoholicCustomer::~AlchoholicCustomer(){}

//Derived method - order
std::vector<int> AlchoholicCustomer::order(const std::vector<Dish> &menu){
    vector<int> orders {};

    // first order
    if (ordersCount==0) {

        //Creating alcoholic menu
        for(int i=0;(unsigned)i<menu.size();i++) {
            if ((menu[i].getType()) == ALC)
                alcMenu.push_back(menu[i]);
        }

            // finding min alc dish, with smallest id
            if(((int)alcMenu.size())>0) {
                minPrice = alcMenu[0].getPrice();
                minId = alcMenu[0].getId();

                for (unsigned int i=1; i<(alcMenu.size()); i++) {
                    if (alcMenu[i].getPrice()<minPrice) {
                        minPrice = alcMenu[i].getPrice();
                        minId = alcMenu[i].getId();
                    }
                }
                orders.push_back(minId);
            }
    }

        // further orders
    else if((unsigned)ordersCount<alcMenu.size()) {
        int currMinPrice = (INT32_MAX);
        int currMinId=0;
        bool foundEqual = false;

        for (unsigned int i=0;((i<alcMenu.size())&(!foundEqual));i++) {
            int currPrice = alcMenu[i].getPrice();
            int currId = alcMenu[i].getId();

            if ((currPrice >= minPrice) & (currPrice<currMinPrice)) {
                if ((currPrice==minPrice) & (currId>minId)) {
                    minPrice = currPrice;
                    minId = currId;
                    foundEqual = true;
                }

                else if(currPrice > minPrice) {
                    currMinPrice = currPrice;
                    currMinId = currId;
                }
            }
        }

        if(!foundEqual) {
            minPrice = currMinPrice;
            minId = currMinId;
        }
        orders.push_back(minId);
    }
    ordersCount++;

    return orders;
}

//Derived method - toString
std::string AlchoholicCustomer::toString() const{
    string ret = getName()+",alc";
    return ret;
}

Customer* AlchoholicCustomer::clone(){
    AlchoholicCustomer* alc_customer = new AlchoholicCustomer(*this);
    return alc_customer;
}