#include <iostream> 
using namespace std;
namespace CounterNameSpace {
	int upperbound;
	int lowerbound;
	class counter {
		int count;
	public:
		counter(int n) {
			if (n <= upperbound)
				count = n;
			else
				count = upperbound;
		}
		void reset(int n) {
			if (n <= upperbound)
				count = n;
		}
		int run() {
			if (count > lowerbound)
				return count--;
			else
				return lowerbound;
		}
	};
}
int main() {
	// use only upperbound from CounterNameSpace
	using CounterNameSpace::upperbound;  //using std::cout
	// now, no qualification needed to set upperbound
	upperbound = 100;
	// qualification still needed for lowerbound, etc.
	CounterNameSpace::lowerbound = 0;
	CounterNameSpace::counter ob1(10);
	int i;
	do {
		i = ob1.run(); cout << i << " ";
	} while (i > CounterNameSpace::lowerbound); cout << endl;
	// now, use entire CounterNameSpace 
	using namespace CounterNameSpace;
	counter ob2(20);
	do {
		i = ob2.run(); 
		cout << i << " ";
	} while (i > lowerbound);
	cout << endl;
	ob2.reset(100);
	lowerbound = 90;
	do {
		i = ob2.run();
		cout << i << " ";
	} while (i > lowerbound);
	return 0;
}