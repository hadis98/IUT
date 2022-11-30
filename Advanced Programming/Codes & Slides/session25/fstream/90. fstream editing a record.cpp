
#include <iostream>
#include <fstream>
using namespace std;

struct student {
	char name[100];
	int age;
	float avg;
};

int main()
{
	student st;
	ifstream myfile;
	ofstream outfile;
	myfile.open("sample2.txt");
	outfile.open("sample2-edited.txt");
	if (myfile.is_open() == false)
		return -1;
	if (outfile.is_open() == false)
		return -1;
	char search_name[100];
	cout << "enter the name of student to search\n";
	cin >> search_name;

	while (myfile.eof() == false)
	{

		myfile >> st.name >> st.age >> st.avg;
		if(st.name[0]=='\0')
			break;
		if (strcmp(st.name, search_name) == 0)
		{
			cout << "record is found. Name= " << st.name << " Age=" << st.age << " Avg= " << st.avg <<
				"\n. Enter the new name, age and average\n";
			cin >> st.name >> st.age >> st.avg;
		}
		outfile << st.name << "\t" << st.age << "\t" << st.avg << "\n";
		outfile.flush();
	}

	myfile.close();
	outfile.close();

	remove("sample2.txt");
	rename("sample2-edited.txt", "sample2.txt");

	system("pause");


}
