#include "pair.h"
#include <iostream>
using namespace std;
Pair::Pair()
{
     x=0;
     y=0;
}
Pair::Pair(float _x, float _y)
{
    x = _x;
    y = _y;
    /*counter++;*/
    this->next = NULL;//added
}
void Pair::setcounter()//added
{
    counter++;//added
}
Pair::~Pair() { /*counter--;*/ }
int Pair::counter = 0;
int Pair::get_counter()
{
    //cout << "the counter is : " << counter << endl;
    return counter;
}
float Pair::get_x()
{
    //cout << "the x is : " << x << endl;
    return x;
}
float Pair::get_y()
{
    //cout << "the y is : " << y << endl;
    return y;
}
