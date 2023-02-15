#include "manage_commands.h"

void handle_user_commands()
{

    while (1)
    {
        print_user_directory_details(current_user);

        if (get_user_commands() == -1)
        {
            break;
        }
    }
}

int get_user_commands()
{
    char user_command[1000];

    scanf("%s", user_command);

    if (is_strings_equal(user_command, "ls"))
    {
        execute_ls_command();
    }
    else if (is_strings_equal(user_command, "mkdir"))
    {
        execute_mkdir_command();
    }
    else if (is_strings_equal(user_command, "EXIT") || is_strings_equal(user_command, "exit"))
    {
        execute_exit_command();
        return -1;
    }
    else if (is_strings_equal(user_command, "pwd"))
    {
        execute_pwd_command();
    }
    else if (is_strings_equal(user_command, "chgr"))
    {
        execute_chgr_command();
    }
    else if (is_strings_equal(user_command, "create"))
    {
        execute_create_command();
    }
    else if (is_strings_equal(user_command, "su"))
    {
        execute_su_command();
    }
    else if (is_strings_equal(user_command, "diff"))
    {
        execute_diff_command();
    }
    else if (is_strings_equal(user_command, "cd"))
    {
        execute_cd_command();
    }
    else if (is_strings_equal(user_command, "cat"))
    {
        execute_cat_command();
    }
    else if (is_strings_equal(user_command, "wc"))
    {
        execute_wc_command();
    }
    else if (is_strings_equal(user_command, "rm"))
    {
        execute_rm_command();
    }
    else if (is_strings_equal(user_command, "rm-r"))
    {
        execute_rm_dash_r_command();
    }
    else if (is_strings_equal(user_command, "cp"))
    {
        execute_cp_command();
    }
    else if (is_strings_equal(user_command, "mv"))
    {
        execute_mv_command();
    }
    else if (is_strings_equal(user_command, "help"))
    {
        execute_help_command();
    }
    else if (is_strings_equal(user_command, "time"))
    {
        execute_time_command();
    }
    else if (is_strings_equal(user_command, "time-a"))
    {
        execute_time_dash_a_command();
    }
    else if (is_strings_equal(user_command, "level"))
    {
        execute_level_command();
    }
    else if (is_strings_equal(user_command, "passwd"))
    {
        execute_passwd_command();
    }
    else if (is_strings_equal(user_command, "passwd-l"))
    {
        execute_passwd_dash_l_command();
    }
    else if (is_strings_equal(user_command, "hide"))
    {
        execute_hide_command();
    }
    else if (is_strings_equal(user_command, "hide-r"))
    {
        execute_hide_dash_r_command();
    }
    else if (is_strings_equal(user_command, "exif"))
    {
        execute_exif_command();
    }
    else if (is_strings_equal(user_command, "search"))
    {
        execute_search_command();
    }
    else if (is_strings_equal(user_command, "info"))
    {
        print_users_info();
    }

    else
    {
        char redirection_command[3];
        scanf("%s", redirection_command);

        if (is_strings_equal(redirection_command, ">>"))
        {
            execute_greater_equal_command(user_command);
        }
        else if (is_strings_equal(redirection_command, ">"))
        {
            execute_greater_command(user_command);
        }
        else
        {
            handle_incorrect_command();
        }
    }
}