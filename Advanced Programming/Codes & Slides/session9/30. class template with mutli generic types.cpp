#include <iostream>
#include <string>
using namespace std;

template <class type1, class type2>
class  myClass
{
 public:
    myClass(type1 , type2 );
    void show();
 private :
    type1 data1;
    type2 data2;
} ;
//********************
template <class type1, class type2>
myClass<type1, type2>::myClass(type1 a, type2 b)
{
     data1 = a;
     data2 = b;
}
//************************
template <class type1, class type2>
void myClass<type1, type2>::show()
{
     cout << "data1 = " << data1 << "     "
		  << "data2 = " << data2 << endl;
}


int main()
{
  myClass<int, double> object1(10, 0.23);
  myClass<char, string> object2('x', "Computer Science.");
  object1.show();  //show int, double
  object2.show();  //show char, string
  cin.get();
}

