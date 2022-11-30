//#pragma once 
#ifndef PAIR_H
#define PAIR_H
#include <iostream>
using namespace std;
#include <stdio.h>
class Pair
{
private:
    float x;
    float y;
    static int counter;

public:
    Pair();
    Pair(float _x, float _y);
    static int get_counter();
    float get_x();
    float get_y();
    Pair* next = (Pair*)malloc(sizeof(400));
    void setcounter();//added
    ~Pair();
};
#endif