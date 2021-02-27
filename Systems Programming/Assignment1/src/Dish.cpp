//
// Created by yuvi on 11/4/18.
//
#include "Dish.h"

using namespace std;

//Constructor
Dish::Dish(int d_id, std::string d_name, int d_price, DishType d_type):
        id(d_id), name(d_name), price(d_price), type(d_type) {
}

int Dish::getId() const {
    return id;
}

string Dish::getName() const {
    return name;
}

int Dish::getPrice() const {
    return price;
}

DishType Dish::getType() const {
    return type;
}

Dish Dish::clone() const {
    Dish d(id, name, price, type);
    return d;
}
