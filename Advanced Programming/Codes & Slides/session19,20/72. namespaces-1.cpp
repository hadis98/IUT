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
		CounterNameSpace::upperbound = 100; 
		CounterNameSpace::lowerbound = 0;
		CounterNameSpace::counter ob1(10);
		int i;
		do {
			i = ob1.run(); 
			cout << i << " ";
		} while (i > CounterNameSpace::lowerbound);
		cout << endl;
		CounterNameSpace::counter ob2(20);
		do {
			i = ob2.run(); 
			cout << i << " ";
		} while (i > CounterNameSpace::lowerbound); 
		cout << endl;
		ob2.reset(100);
		CounterNameSpace::lowerbound = 90;
		do {
			i = ob2.run();
			cout << i << " ";
		} while (i > CounterNameSpace::lowerbound); 
		return 0;
	}