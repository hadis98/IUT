// Reading a text file and storing in a object

#include <iostream>
#include <fstream>
using namespace std;
#include <iomanip>
// basic file operations
struct student {
	char name[20];
	int age;
	float avg;
};
int main() {
	student st;
	ofstream myfile;
	char junc[100];
	myfile.open("sample1.txt", ios::app);
	if (myfile.is_open() == false)
		return -1;
	while (true) {
		cout << "enter name and press Enter \n";
		cin.getline(st.name,19);
		if (strcmp(st.name, "\0") == 0)
			break;
		cout << "enter age and average:\n";
		cin >> st.age >> st.avg;
		cin.ignore();
		myfile << setfill(' ') << setw(20) << left << st.name;
		myfile << st.age << "\t" << st.avg << "\n";

		myfile << st.name << "***" << st.age << "***" << st.avg << "\n";

		myfile.write((char*)&st, sizeof(st));

		myfile.write("\n", 1);
		myfile.flush();

	}

	myfile.close();
	ifstream infile;
	infile.open("sample1.txt");
	if (infile.is_open() == false)
		return -1;

	infile.seekg(0, ios::end);
	int size = infile.tellg();
	infile.seekg(0, ios_base::beg);

	while (infile.tellg() < size)
	{

		char buffer[1000];
		infile >> st.name >> st.age >> st.avg;
		infile.ignore();
		if (infile.eof() == true)
			break;
		cout << "first read \n";
		cout << st.name << "\t" << st.age << "\t" << st.avg << "\n";

		infile.getline(buffer, 1000);
		char * ptr = strstr(buffer, "***");
		strncpy(st.name, buffer, ptr - buffer);
		char * ptr2 = strstr(ptr + 3, "***");
		st.age = atoi(ptr + 3);
		st.avg = atof(ptr2 + 3);
		cout << "second read \n";
		cout << st.name << "\t" << st.age << "\t" << st.avg << "\n";


		infile.read((char*)&st, sizeof(st));
		infile.read((char*)junc, 1);

		cout << "third read \n";
		cout << st.name << "	" << st.age << "	" << st.avg << "\n";
	}
	return 0;
}
