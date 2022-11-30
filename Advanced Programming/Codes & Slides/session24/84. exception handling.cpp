#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;
class time_exception{};
class task_exception{};

class mytime{
public:
	mytime(int h = 0, int m = 0, int s = 0)
	{
		if (h >= 0 && h < 25 && m >= 0 && m < 60 && s >= 0 && s < 60)
		{
			hour = h;
			minute = m;
			second = s;
		}
		else
			exit(1);
	}
	friend ostream& operator<<(ostream & out, mytime obj);
private:
	int hour, minute, second;
};
//Defining the friend function
ostream& operator<<(ostream& out, mytime obj)
{
	out << setfill('0') << setw(2) << obj.hour << ":" << setw(2) << obj.minute << ":" << setw(2) << obj.second << endl;
	return out;
}

//The Tasks class 
class tasks{
public:
	tasks(char* name, mytime st)
	{
		if (strlen(name) < 100)

		{
			strcpy_s(task_name, name);
			t_start = st;
		}
		else
			exit(1);
	}
	void print()
	{
		cout << "the task name: " << task_name << " starts at " << t_start << endl;
	}
private:
	char task_name[100];
	mytime t_start;
};




//functions of the program
mytime read_time(ifstream & input_file)
{
	int t_hour, t_min, t_sec;
	char c;
	input_file >> t_hour >> c >> t_min >> c >> t_sec;
	//ERROR Detection
	if (t_hour < 0 || t_hour > 24 || t_min < 0 || t_min >= 60 || t_sec < 0 || t_sec >= 60)
		throw time_exception();
	return mytime(t_hour, t_min, t_sec);

}
tasks read_task(ifstream & input_file){
	char t_name[1000];
	input_file >> t_name;
	mytime t_time = read_time(input_file);
	//ERROR HANDLING
	if (strlen(t_name) > 100)
	{
		throw task_exception();
	}
	tasks s(t_name, t_time);
	return s;
}

int main()
{
	
	ifstream myfile;
	myfile.open("input2.txt");
	int count;
	myfile >> count;
	
		for (int i = 0; i < count; i++)
		{
			try
			{
			tasks s = read_task(myfile);
			s.print();
			}
			catch (time_exception e1){
				cout << "error happened for time \n";
			}
			catch (task_exception e2){
				cout << "error happened for task name\n";
			}
		
		}
	myfile.close();

	system("pause");
}

