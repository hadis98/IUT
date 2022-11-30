#include <iostream>
#include <string>
using namespace std;

template <typename type1, typename type2>
type1 myFunc(type1 argument1, type2 argument2)
{
  cout << "argument1 = " << argument1 << " , argument2 = "
	   << argument2 << endl;
}
//***********
int main()
{
   int number = 100;
   string str="hello";
   myFunc(number, str);

   float number1 = 89.25;
   long int number2 = 3425331;
   myFunc(number1, number2);
   cin.get();
}
