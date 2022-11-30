#include <iostream>
using namespace std;
#include <stdio.h>
#include "model.h"
//#pragma warning(disable:4996)

int main()
{
    char* file = new char(100);
    cout << "enter the name of file: ";
    cin >> file;
    model model1(file);
    model1.info();
    float x;//added
    cout<<endl; 
    cout << "enter your X:" << endl;
    cin >> x;
    cout << "the predicted y is : " << model1.get_predict_y(x)<<endl;

    return 0;
}