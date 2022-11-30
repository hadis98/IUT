//#pragma once
#ifndef MODEL_H
#define MODEL_H
#include "linked.h"
#pragma warning(disable:4996)
class model
{
private:
    float B0, B1;
    linked link1;
public:
    model(char* address);
    ~model();
    float get_predict_y(float x);
    void info();
};
#endif

