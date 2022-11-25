#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main()
{
	int v1, v2;
	char prefix[100];
	char file_address[200];
	printf("Enter two numbers: ");
	scanf("%d %d", &v1, &v2);
	printf("Enter prefix: ");
	scanf("%s", prefix);
	printf("enter file address: ");
	scanf("%s", file_address);
	char command[400] = "sudo adduser ";	
	for (int i = v1; i <= v2; i++)
	{
		strcat(command, prefix);
		strcat(command, "-");
		char s1[10];
		sprintf(s1, "%d", i);
		strcat(command, s1);
		printf("%s\n", command);
		system(command);
		char command_file[400] = "sudo cp ";
		strcat(command_file, file_address);
		strcat(command_file, " /home/");
		strcat(command_file, prefix);
		strcat(command_file, "-");
		strcat(command_file, s1);
		strcat(command_file, "/");
		printf("%s", command_file);
		system(command_file);
		memset(command, '\0', sizeof(command));
		strcpy(command, "sudo adduser ");
		memset(command_file, '\0', sizeof(command_file));
		strcpy(command_file, "sudo cp ");
	}
}
