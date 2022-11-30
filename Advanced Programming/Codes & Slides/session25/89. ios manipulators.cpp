#include <iostream>
#include <iomanip>
using namespace std;
int main()
{

	bool boolean = true;
	cout << std::boolalpha << boolean << endl;
	cout << std::noboolalpha<<boolean << endl;

	int xbase = 100;
	cout << hex << xbase<<endl;
	cout << oct << xbase << endl;
	cout << dec << xbase << endl;

	
	

	std::cout << std::setfill('x') << std::setw(10)<<std::left;
	std::cout << 77 << std::endl; //if 77 has more than 10 numbers they are all shown in the console
	cout << 124<<endl;

	std::cout << std::hex;
	std::cout << std::setiosflags(std::ios::showbase | std::ios::uppercase);
	//std::cout << std::ios::showbase << std::ios::uppercase;
	std::cout << 100 << std::endl;

	// oX64

	int x = std::cout.precision();
    double a = 3.1415926534;
	double b = 2006.0;
	double c = 1.0e-10;

	std::cout << "default:\n";
	std::cout <<std::oct<< a << '\n' << b << '\n' << c << '\n';

	std::cout.precision(5);

	std::cout << "precision 5:\n";
	std::cout << a << '\n' << b << '\n' << c << '\n';

	std::cout << '\n';

	std::cout << "fixed:\n" << std::fixed;
	std::cout << a << '\n' << b << '\n' << c << '\n';

	std::cout << '\n';
	
	
	std::cout << "scientific:\n" << std::scientific;
	std::cout << a << '\n' << b << '\n' << c << '\n';


	std::cout.precision(x);
	std::cout << "scientific2:\n" << std::scientific;
	std::cout << a << '\n' << b << '\n' << c << '\n';


	//std::cout.precision(x);
	cout << endl << std::defaultfloat << 100.32;
}
