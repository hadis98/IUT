//#pragma once
#ifndef  LINKED_H
#define LINKED_H
#include "pair.h"
#include <iostream>
using namespace std;
class linked
{
private:

public:
    Pair* head = NULL;
    linked();
    ~linked();
   // void add_data(Pair data);
    linked* insert(Pair data);
    Pair get_avg();
    float get_error(float, float);
    const float get_B0(linked lind);
    const float get_B1(linked link);
    void show_list();
};
#endif

