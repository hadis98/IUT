#include "print_messages.h"

void print_welcome_messages()
{
    setcolor(1);
    printf("\n\n\n\n\n\n\n\n\t\t\t\t\t**********************************\n");
    setcolor(2);
    printf("\t\t\t\t\t\t******************\n");
    setcolor(5);    
    printf("\t\t\t\t\tWELCOME TO MY COLOURFUL TERMINAL=) \n\t\t\t\t\t\tHOPE YOU ENGOY IT.\n");
    setcolor(2);
    printf("\t\t\t\t\t\t******************\n");
    setcolor(1);
    printf("\t\t\t\t\t**********************************\n\n\n\n");
    setcolor(14);
    printf("\t\t\twrite \"exit\" to close the terminal\n\t\t\twrite \"help\" to see a introduction of commands\n");
    printf("\t\t\tpress the enter key to start=)");
    getchar();
    system("cls");
}

void print_user_exist_error()
{
    setcolor(4);
    printf("user does not exist!!\n");
}

void print_enter_user_successfully(char username[])
{
    system("cls");
    Cyan();
    printf("\n\n\n\n\t\t\t\t\t\\WELCOME USER %s", username);
    getchar();
}

void print_enter_retry()
{
    boldred();
    printf("TRY AGAIN TO ENTER:)\n");
}

void print_enter_name()
{
    Boldcyan();
    printf("enter name: ");
}

void print_enter_username()
{
    Boldcyan();
    printf("enter username: ");
}

void print_enter_password()
{
    Boldcyan();
    printf("enter password: ");
}

void print_enter_current_password()
{
    setcolor(9);
    printf("please enter your current password: ");
}

void print_take_user_password(char username[])
{
    setcolor(11);
    printf("\nplease enter user %s password: ", username);
}

void print_timeout_user_session(char username[])
{
    setcolor(12);
    printf("the time for user %s has finished:(\nso this user cannot access to terminal any more:(\n", username);
}

void print_enter_new_password()
{
    setcolor(2);
    printf("please enter your new password: ");
}

void print_enter_time()
{
    setcolor(11);
    printf("please enter the time in following format\n");
    setcolor(14);
    printf("yyyy/mm/dd hh:mm:ss\n");
}

void print_weak_password_error()
{
    setcolor(4);
    printf("the password is too weak:(enter another password: ");
}

void print_successfully_save_password()
{
    setcolor(2);
    printf("your password saved:)\n");
}

void print_successfully_update_password()
{
    setcolor(2);
    printf("your new password saved:)\n");
}

void print_successfully_admin_update_password(char username[])
{
    setcolor(2);
    printf("the new password of user %s saved:)\n", username);
}

void print_user_not_found_error()
{
    setcolor(12);
    printf("user not found:(");
}

void print_incorrect_password_error()
{
    setcolor(12);
    printf("incorrect password:(\n");
}

void print_directory_successfully_created()
{
    setcolor(2);
    printf("Directory created successfully\n");
}

void print_directory_create_error()
{
    boldred();
    printf("Unable to create directory:( ");
    printf(strerror(errno));
    printf("\n");
}

void print_permission_denied_error()
{
    boldred();
    printf("permission denied:(\n");
}

void print_search_failed_error()
{
    boldred();
    printf("search failed:(\n");
    printf(strerror(errno));
    printf("\n");
}

void print_successfully_save_new_user()
{
    setcolor(11);
    printf("information of new user saved successfully:)\nuser created;)\n");
}

void print_save_new_user_error()
{
    setcolor(12);
    printf("error saving data:(\n");
}

void print_welcome_user_login(char username[])
{
    setcolor(9);
    printf("WELCOME %s USER:)", username);
}

void print_file_exist_error(char file_name[])
{
    setcolor(4);
    printf("file %s doesnt exist:(\n", file_name);
}

void print_already_exist_warning(char file_name[])
{
    printf("the %s already exist\ndo you want to overwrite it:y/n ?\n", file_name);
}

void print_file_moved_successfully(char file_name[])
{
    setcolor(2);
    printf("file %s moved successfully:)", file_name);
}

void print_new_admin(char username[])
{
    setcolor(2);
    printf("user with %s  username became admin:)\n", username);
}

void print_admin_create_error(char username[])
{
    setcolor(12);
    printf("user %s cannot be admin:(\n", username);
}

void print_wc_command_info(char file_name[], int num_lines, int num_words, int num_characters)
{
    setcolor(11);
    printf("in the %s file \nnumber of lines:%d \nnumber of words: %d \nnumber of characters : %d", file_name, num_lines, num_words, num_characters);
}

void print_delete_file_successfully()
{
    setcolor(2);
    printf("deleted successfully\n");
}

void print_rm_command_error(bool is_directory)
{
    boldred();
    if (is_directory)
    {
        printf("directory cannot be deleted or doesnt exist\n");
        return;
    }

    printf("file cannot be deleted or doesnt exist\n");
}

void print_user_directory_details(struct user current_user)
{
    char cwd[1024];

    chdir(ROOT_DIRECTORY);
    chdir(current_user.username);
    getcwd(cwd, sizeof(cwd));

    if (current_user.access == 0)
    {
        print_normal_user_directory_info(current_user, cwd);
    }
    else
    {
        print_admin_user_directory_info(current_user, cwd);
    }
}

void print_incorrect_command()
{
    boldred();
    printf("incorrect command\n");
}

void print_endof_program()
{
    setcolor(5);
    printf("END OF PROGRAM..\nGOOD BYE:)");
}

void print_keep_file_question(char file_name[])
{
    setcolor(11);
    printf("keep file %s? y/n\n", file_name);
}

void print_exif_file_error(char file_name[])
{
    boldred();
    printf("Unable to get file properties:(\nPlease check whether '%s' file exists.\n", file_name);
}

void print_file_copy_successfully()
{
    setcolor(2);
    printf("file copied successfully:)");
}

void print_normal_user_directory_info(struct user current_user, char cwd[])
{
    setcolor(11);
    printf("%s@%s:", current_user.name, current_user.username);
    setcolor(9);
    printf("Dir: %s", cwd);
    setcolor(11);
    printf("$");
}

void print_admin_user_directory_info(struct user current_user, char cwd[])
{
    setcolor(5);
    printf("[adminstrator]");
    setcolor(3);
    printf("%s@%s:", current_user.name, current_user.username);
    printf("Dir:%s", cwd);
    setcolor(5);
    printf("#");
}
