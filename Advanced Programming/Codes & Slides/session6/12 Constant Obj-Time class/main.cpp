#include "Time.h"
int main()
{
	Time wakeUp(6, 45, 0); // non-constant object
	const Time noon(12, 0, 0); // constant object
						// object	function	
	wakeUp.setHour(18); // non-const  non-const

	//noon.setHour(12); // const	non-const

	wakeUp.getHour();	// non-const		const
	noon.getMinute();   // const		const
	noon.printUniversal(); // const		const
	//noon.printStandard(); //const		non-const
	return 0;
}