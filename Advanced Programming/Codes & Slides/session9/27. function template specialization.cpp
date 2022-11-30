#include <iostream>
using namespace std;
template <class X> void swapArgs(X &a, X &b)
{
   X temp;
   temp = a;
   a = b;
   b = temp;
   cout << "Inside template swapArgs\n";
}

// template <> void swapArgs <int> (int &a, int &b)
void swapArgs(int &a, int &b)
{
   int temp;
   temp = a;
   a = b;
   b = temp;
   cout << "Inside swapArgs specialization\n";
}

//***************
int main()
{
   int i = 10, j = 20;
   double x = 10.1,  y = 23.3;
   char a = 'x', b = 'z';
   cout << "Original i, j : " << i << " , " << j << endl;
   cout << "Original x, y : " << x << " , " << y << endl;
   cout << "Original a, b : " << a << " , " << b << endl;
   cout << endl;
   swapArgs(i, j); //calls specialized swapargs
   cout << "Swaped i, j : " << i << " , " << j << endl;
   cout << endl;
   swapArgs(x, y); //calls generic swapargs
   cout << "Swaped x, y : " << x << " , " << y << endl;
   cout << endl;
   swapArgs(a, b); //calls generic swapargs
   cout << "Swaped a, b : " << a << " , " << b << endl;
   cin.get();
}

