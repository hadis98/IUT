#include "model.h"
#include <stdio.h>
model::model(char* address)
{
    FILE* fptr = fopen(address, "r");
    if (fptr == NULL)
    {
        cout << "file dosnt exist \n";

    }

    float a, b;
    while (fscanf(fptr, "%f \t%f", &a, &b) == 2)
    {
        Pair p(a, b);
       // link1.add_data(p);
        link1.insert(p);
    }
   // cout << "show list 1\n";
    //link1.show_list();
    Pair avg = link1.get_avg();
    float sum_sorat = 0;
    float sum_makhrag = 0;
    Pair* ptr = new Pair;
    ptr = link1.head;
    while (ptr != NULL)
    {
        sum_sorat += (ptr->get_x() - avg.get_x()) * (ptr->get_y() - avg.get_y());
        sum_makhrag += (ptr->get_x() - avg.get_x()) * (ptr->get_x() - avg.get_x());
        ptr = ptr->next;
    }

    B1 = sum_sorat / sum_makhrag;
    B0 = avg.get_y() - (B1 * avg.get_x());

}

float model::get_predict_y(float _x)
{
    float _y = B0 + B1 * _x;
    return _y;
}

void model::info()
{
    cout << "the information of model: \n";
    link1.show_list();
    cout << "the number of datas : " << Pair::get_counter()<<endl;
    cout << "the line equation is: " << "y=" << B1 << "x" << "+" << B0<<endl;
    cout<<"the error of model is : "<<link1.get_error(B0,B1)<<endl;
}
model::~model() {}