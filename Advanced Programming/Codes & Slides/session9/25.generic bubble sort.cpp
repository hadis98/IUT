#include <iostream>
using namespace std;

template <class X> void bubble(X *items,int count)
{
  X t;

  for(int a=1; a<count; a++)
    for(int b=count-1; b>=a; b--)
      if(items[b-1] > items[b]) {
        t = items[b-1];
        items[b-1] = items[b];
        items[b] = t;
      }
}

int main()
{
  int iarray[7] = {7, 5, 4, 3, 9, 8, 6};
  double darray[5] = {4.3, 2.5, -0.9, 10.2, 3.0};

  cout << "Here is unsorted integer array: ";
  for(int i=0;  i<7; i++)
    cout << iarray[i] << ' ';
  cout << endl;

  bubble(iarray, 7);

  cout << "Here is sorted integer array: ";
  for(int i=0;  i<7; i++)
    cout << iarray[i] << ' ';
  cout << endl;

  cout << "Here is unsorted double array: ";
  for(int i=0;  i<5; i++)
    cout << darray[i] << ' ';
  cout << endl;

  bubble(darray, 5);

  cout << "Here is sorted double array: ";
  for(int i=0;  i<5; i++)
    cout << darray[i] << ' ';
  cout << endl;

  return 0;
}


/* 
Output:

Here is unsorted integer array: 7 5 4 3 9 8 6
Here is sorted integer array: 3 4 5 6 7 8 9
Here is unsorted double array: 4.3 2.5 -0.9 10.2 3
Here is sorted double array: -0.9 2.5 3 4.3 10.2


*/