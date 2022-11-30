#include <iostream>
#include <stdio.h> 
using namespace std;

void strconcat(char *s1, char *s2) {
	strcat(s1, s2);
}
void strconcat(char *s1, int i) {
	char temp[80];
	sprintf(temp, "%d", i);
	strcat(s1, temp);
}

void strconcat(char *s1, double i) {
	char temp[80];
	sprintf(temp, "%f", i);
	strcat(s1, temp);
}

//Yoda
int main() {
	char str[80];
	strcpy(str, "Hello ");
	int x;
	scanf("%d", &x);
	strconcat(str, x ); //"Hello 10"
	cout << str << "\n";
	strconcat(str, "there");
	cout << str << "\n";
	strconcat(str, 12.5);
	return 0;
}
