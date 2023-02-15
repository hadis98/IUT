#include "user_login.h"

void handle_user_enter()
{
    bool is_error_occured = false;

    char entered_username[100];
    char entered_password[100];

    system("cls");
    print_enter_username();
    gets(entered_username);

    print_enter_password();
    gets(entered_password);

    FILE *fptr = fopen(USERSINFO_FILE, "rb");
    struct user temp_user;

    if (is_user_exist(entered_username, entered_password))
    {
        temp_user = get_user_structure(entered_username, entered_password);
        if (is_session_timeout(temp_user.time))
        {
            is_error_occured = true;
            print_timeout_user_session(entered_username);
        }
        else
        {
            current_user = temp_user;
            print_enter_user_successfully(entered_username);
            fclose(fptr);
        }
    }
    else
    {
        is_error_occured = true;
    }
    
    if (is_error_occured)
    {
        print_permission_denied_error();
        do
        {
            print_enter_retry();
            print_enter_username();
            gets(entered_username);

            print_enter_password();
            gets(entered_password);

            if (is_user_exist(entered_username, entered_password))
            {
                temp_user = get_user_structure(entered_username, entered_password);
                if (is_session_timeout(temp_user.time))
                {
                    print_timeout_user_session(entered_username);
                }
            }

        } while (!is_user_exist(entered_username, entered_password) || is_session_timeout(temp_user.time));

        current_user = temp_user;
        print_enter_user_successfully(entered_username);
        fclose(fptr);
    }
}

bool is_user_exist(char entered_username[], char entered_password[])
{
    FILE *fptr = fopen(USERSINFO_FILE, "rb");
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {
        if (is_strings_equal(temp_user.username, entered_username) && is_strings_equal(temp_user.passwd, entered_password))
        {
            return true;
        }
    }

    fclose(fptr);
    return false;
}

struct user get_user_structure(char entered_username[], char entered_password[])
{
    FILE *fptr = fopen(USERSINFO_FILE, "rb");
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {

        if (is_strings_equal(temp_user.username, entered_username) && is_strings_equal(temp_user.passwd, entered_password))
        {
            return temp_user;
        }
    }

    fclose(fptr);
}