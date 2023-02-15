#include "command_line_help.h"

void execute_help_command()
{
    int selected_command;

    do
    {
        help_command_summery();
        selected_command = get_help_selected_choice();

        if (handle_help_command_selection(selected_command) == -1)
            break;

    } while (1);
}

void help_command_summery()
{
    system("cls");
    setcolor(6);
    printf("\n\t\t\t\t*********   HELP   *********");
    printf("\n\n\t\tMENU-----:\n ");
    printf("\t\there are commands and a short introduction\n");
    printf("\t\tenter one of below numbers\n");
    setcolor(14);
    printf("\t\t1.cd directoryname\n\t\t2.pwd\n\t\t3.mkdir directoryname\n\t\t4.wc filename\n\t\t5.cat filename\n\t\t6.rm and rm-r filename"
           "\n\t\t7.cp filename1 filename2\n\t\t8.mv filename1 filename2\n\t\t"
           "9.ls\n\t\t10.>> or >\n\t\t11.create username\n\t\t12.su username\n\t\t13.passwd\n\t\t"
           "14.diff filename1 filename2\n\t\t15.exif filename\n\t\t16.chgr username\n\t\t17.time\n\t\t18.time-a\n\t\t19.hide/hide-r\n\t\t"
           "20.search filename or directory\n\t\t21.EXIT\n");
}

int get_help_selected_choice()
{
    int selected_command;

    setcolor(14);
    printf("\t\tenter your choice :");
    
    scanf("%d", &selected_command);
    printf("\n");
    return selected_command;
}

int handle_help_command_selection(int selected_command)
{
    switch (selected_command)
    {
        setcolor(15);
    case 1:
        printf("command cd : it changes the directory.\nnote that you can use it with  absolute or relative address.\n"
               "an example for relative address : cd ../root/filename\nan example for absolute address : cd C:/Users/Win 10/Desktop/root/");
        getch();
        break;
    case 2:
        printf("command pwd : it will show the address of where you are:)");
        getch();
        break;
    case 3:
        mkdir_command_help();
        break;
    case 4:
        printf("command wc filename :it will show the number of lines and words and characters of a file.");
        getch();
        break;
    case 5:
        printf("command cat filename : it will show the contents of a file.");
        getch();
        break;
    case 6:
        printf("commad rm filename : it will delete a file\ncommand rm-r filename : it will delete a directory. ");
        getch();
        break;
    case 7:
        printf("command cp filename1 filename2 : it will copy the contents of file1 to file2.\n"
               "note that it will ask you to choose wethere you want to delete the contents of  file2 or not:)");
        getch();
        break;
    case 8:
        printf("command mv filename1 filename2 : it will move the contents of file1 to file2.so file1 will remove:-)\n"
               "note that it will ask you to choose wethere you want to delete the contents of  file2 or not:)");
        getch();
        break;
    case 9:
        printf("command ls : it will show you the files and directories in the situation that you are.");
        getch();
        break;
    case 10:
        redirection_command_help();
        getch();
        break;
    case 11:
        printf("command create username : it will create a user and a directory for user with his/her username.");
        getch();
        break;
    case 12:
        printf("command su username : it will change the current user to the username you inserted.");
        getch();
        break;
    case 13:
        printf("command passwd : it will change the password of the current user and"
               " if the current user is admin then with command (passwd-l time username) admin can change the password of a user and set a time for user.");
        getch();
        break;
    case 14:
        printf("command diff filename1 filename2 : it will show the places of where two files are differents and show how many different they have.");
        getch();
        break;
    case 15:
        printf("command exif filename : it will show you some information about"
               "a file like the time it was created and the last time it has changed");
        getch();
        break;
    case 16:
        printf("command chgr username : it will change the normal user to admin in 3conditions:\n1."
               "first: the users`mistakes should be less than 11\n2.second: the users`password should have strength more than 75"
               "\n3.the time for user should be okay:)");
        getch();
        break;
    case 17:
        printf("command time :it will show the systems`time:)");
        getch();
        break;
    case 18:
        printf("command time-a :it will show the time more accurate:)");
        getch();
        break;
    case 19:
        printf("command hide filename :it will disappeare the file.\n"
               "so when you print (ls) it will not be displayed.\ncommand hide-r filename: it acts as opposite of hide."
               "\nit will  show the file or directory:)");
        getch();
        break;
    case 20:
        printf("command search filename or directoryname:\nit will show the address of file or directory:)");
        getch();
        break;
    case 21:
        getchar();
        system("cls");
        return -1;
    default:
        setcolor(4);
        printf("enter a valid number!");
        getch();
    }
}

void mkdir_command_help()
{
    printf("command mkdir : it will make a directory.\n"
           "note that you can use address and say where you want to make the directory"
           "\nan example for relative address : mkdir ../root/filename\nan example for absolute address : cd C:/Users/Win 10/Desktop/root/");
    getch();
}

void redirection_command_help()
{
    printf("command > : if you write a word then put (>) and then enter the name of file"
           " like(hello > filename) it will append the word(hello) to the file.\nnote that using (>) will delete your file.\n"
           "also you can say : filename1 > filename2.\nit will copy or move the file1 to file2"
           " and the contents of file2 will remove.\n\ncommand >> : if you write a word then put"
           "(>>) and then enter the name of file like (hello >> filename) it will append the word(hello) to the file."
           "\nnote that using (>>) will not delete your file\n"
           "also you can say : filename1 >> filename2.\nit will copy or move the file1 to file2"
           " and the contents of file2 will not remove.");
    getch();
}
