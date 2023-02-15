#include "commands.h"

void execute_ls_command()
{
    setcolor(14);
    system("dir /b");
    printf("\n");
}

void execute_mkdir_command()
{
    char directory_name[100];

    getchar();
    gets(directory_name);

    if (!CreateDirectory(directory_name, NULL))
    {
        printf("error happend\n");
        return;
    }

    print_directory_successfully_created();
}

void execute_chgr_command()
{
    char username[100];
    scanf("%s", username);
    increse_user_access_level(username);
}

void increse_user_access_level(char username[])
{
    char cwd[PATH_MAX];
    char current_address[1000];
    bool is_user_found = false;

    if (current_user.access != 1)
    {
        print_permission_denied_error();
        return;
    }

    getcwd(cwd, sizeof(cwd));
    strcpy(current_address, cwd);

    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fread(&users[i], sizeof(struct user), 1, fptr);

        if (is_strings_equal(users[i].username, username) && is_user_eligible_tobe_admin(users[i]))
        {
            is_user_found = true;
            users[i].access = 1;
            print_new_admin(users[i].username);
            fclose(fptr);
            write_usersinfo_file();
            break;
        }
    }

    if (!is_user_found)
        print_admin_create_error(username);

    fclose(fptr);
    chdir(current_address);
}

bool is_user_eligible_tobe_admin(struct user selected_user)
{
    return selected_user.access == 0 && selected_user.mistakes < 11 && selected_user.strength > 75;
}

void execute_create_command()
{
    char *user_name;

    user_name = (char *)malloc(sizeof(char));
    scanf("%s", user_name);

    if (current_user.access == 1)
    {
        handle_create_new_user_command(user_name);
        return;
    }

    print_permission_denied_error();
}

void handle_create_new_user_command(char user_name[])
{
    char cwd[PATH_MAX];
    char current_working_directory_copy[1000];

    setcolor(11);
    getcwd(cwd, sizeof(cwd));
    strcpy(current_working_directory_copy, cwd);

    chdir(ROOT_DIRECTORY);
    getcwd(cwd, sizeof(cwd));

    if (!make_directory(user_name))
    {
        chdir(current_working_directory_copy);
        return;
    }

    if (!handle_create_new_user_file(user_name))
        NUMBER_OF_USERS--;

    chdir(current_working_directory_copy);
    printf("\n");
}

bool make_directory(char directory_name[])
{
    if (is_directory_exist(directory_name))
    {
        printf("directory already exist!!!\n");
        print_directory_create_error();
        return false;
    }

    CreateDirectory(directory_name, NULL);
    return true;
}

bool handle_create_new_user_file(char file_name[])
{
    print_enter_name();
    scanf("%s", users[NUMBER_OF_USERS].name);

    strcpy(users[NUMBER_OF_USERS].username, file_name);

    getchar();
    print_enter_password();
    gets(users[NUMBER_OF_USERS].passwd);

    int entered_password_strength;
    entered_password_strength = get_password_strength(users[NUMBER_OF_USERS].passwd);

    while (entered_password_strength < MIN_PASSWORD_STRENGTH)
    {
        print_weak_password_error();
        gets(users[NUMBER_OF_USERS].passwd);
        entered_password_strength = get_password_strength(users[NUMBER_OF_USERS].passwd);
    }

    print_successfully_save_password();

    char date[11], time[9], date_copy[11], time_copy[9], full_time_format[30];
    do
    {
        print_enter_time();
        scanf("%s%s", date, time);
        strcpy(date_copy, date);
        strcpy(time_copy, time);

    } while (!is_expiration_time_valid(date, time));

    strcpy(full_time_format, "");
    strcat(full_time_format, date_copy);
    strcat(full_time_format, " ");
    strcat(full_time_format, time_copy);

    strcpy(users[NUMBER_OF_USERS].time, full_time_format);
    users[NUMBER_OF_USERS].strength = entered_password_strength;
    users[NUMBER_OF_USERS].access = 0;
    users[NUMBER_OF_USERS].mistakes = 0;

    bool is_user_added = false;
    NUMBER_OF_USERS++;
    is_user_added = write_usersinfo_file();

    if (is_user_added)
    {
        print_successfully_save_new_user();
        return true;
    }

    print_save_new_user_error();
    return false;
}

int get_number_of_users()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");
    int counter = 0;
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {
        counter++;
    }

    fclose(fptr);
    return counter;
}

void execute_su_command()
{
    char username[100];

    scanf("%s", username);
    getchar();
    switch_user_command(username);
}

void switch_user_command(char entered_username[])
{
    char cwd[PATH_MAX];
    char origin_address[1000];

    getcwd(cwd, sizeof(cwd));
    strcpy(origin_address, cwd);

    bool is_switch_occured = false;

    if (current_user.access == 1)
        is_switch_occured = handle_switch_user(true, entered_username);
    else
        is_switch_occured = !handle_switch_user(false, entered_username);

    if (!is_switch_occured)
        chdir(origin_address);
}

bool handle_switch_user(bool is_admin, char entered_username[])
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");
    bool user_found = false;
    char entered_password[100];
    struct user temp_user;

    if (!is_admin)
    {
        print_take_user_password(entered_username);
        gets(entered_password);
    }

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fread(&users[i], sizeof(struct user), 1, fptr);

        if (is_strings_equal(users[i].username, entered_username) && (is_admin || (!is_admin && is_strings_equal(users[i].passwd, entered_password))))
        {
            if (is_session_timeout(users[i].time))
            {
                print_timeout_user_session(entered_username);
                fclose(fptr);
                return false;
            }
            current_user = users[i];
            user_found = true;
            break;
        }
    }

    if (user_found)
    {
        switch_user_login_successfully(entered_username);
        fclose(fptr);
        return true;
    }

    print_permission_denied_error();
    fclose(fptr);
    return false;
}

void switch_user_login_successfully(char entered_username[])
{
    char new_user_directory_address[1000];
    strcpy(new_user_directory_address, ROOT_DIRECTORY);
    strcat(new_user_directory_address, entered_username);
    print_welcome_user_login(entered_username);

    chdir(new_user_directory_address);
    getchar();
    system("cls");
}

void execute_diff_command()
{
    char file1_name[100];
    char file2_name[100];

    scanf("%s%s", file1_name, file2_name);
    handle_diff_files_command(file1_name, file2_name);
}

void handle_diff_files_command(char file1_name[], char file2_name[])
{
    char ch1, ch2;

    FILE *fp1 = fopen(file1_name, "rb");
    FILE *fp2 = fopen(file2_name, "rb");

    if (fp1 == NULL || fp2 == NULL)
    {
        printf("no such file:(");
        return;
    }

    int difference_number = 0, difference_position = 0, difference_line = 1;

    char diff_command[100] = "fc ";
    strcat(diff_command, file1_name);
    strcat(diff_command, " ");
    strcat(diff_command, file2_name);
    system(diff_command);

    do
    {
        ch1 = getc(fp1);
        ch2 = getc(fp2);

        difference_position++;
        if (ch1 == '\n' && ch2 == '\n')
        {
            difference_line++;
            difference_position = 0;
        }

        if (ch1 != ch2)
        {
            difference_number++;
            printf("Line Number : %d \tError Position : %d \tCharacter of first file: %c\tCharacter of second file: %c\n", difference_line, difference_position, ch1, ch2);
        }

    } while (ch1 != EOF || ch2 != EOF);

    printf("Total number of differences: %d\t\n", difference_number);
    fclose(fp1);
    fclose(fp2);
    return;
}

//! error
// todo
void execute_cd_command()
{
    char directory_address[1000];

    getchar();
    gets(directory_address);
    chdir(directory_address);
    printf("\n");
}

void execute_cat_command()
{
    char file_name[1000];
    scanf("%s", file_name);

    handle_cat_file_command(file_name);
    printf("\n");
}

void handle_cat_file_command(char file_name[])
{

    FILE *fptr = fopen(file_name, "rb");

    if (fptr == NULL)
    {
        print_file_exist_error(file_name);
        return;
    }

    char file_character;

    setcolor(15);
    while ((file_character = fgetc(fptr)) != EOF)
        printf("%c", file_character);

    fclose(fptr);
    return;
}

void execute_wc_command()
{
    char file_name[1000];
    scanf("%s", file_name);

    handle_word_count_command(file_name);
    printf("\n");
}

void handle_word_count_command(char file_name[])
{
    FILE *fptr = fopen(file_name, "rb");

    if (fptr == NULL)
    {
        print_file_exist_error(file_name);
        return;
    }

    int line_counter = 1, character_counter = 0, words_counter = 1;
    char file_character;

    while ((file_character = fgetc(fptr)) != EOF)
    {
        if (file_character == '\n')
            line_counter++;

        if (file_character == ' ' || file_character == '\n')
            words_counter++;

        character_counter++;
    }

    fclose(fptr);

    print_wc_command_info(file_name, line_counter, words_counter, character_counter);
    return;
}

void execute_rm_command()
{
    char file_name[100];
    scanf("%s", file_name);

    if (remove(file_name) == 0)
    {
        print_delete_file_successfully();
        return;
    }

    print_rm_command_error(false);
}

void execute_rm_dash_r_command()
{

    char directory_name[100];
    scanf("%s", directory_name);

    if (rmdir(directory_name) == 0)
    {
        print_delete_file_successfully();
        return;
    }

    print_rm_command_error(true);
}

void execute_cp_command()
{
    char file1_name[100];
    char file2_name[100];

    scanf("%s%s", file1_name, file2_name);
    handle_copy_file_command(file1_name, file2_name);
    printf("\n");
}

void handle_copy_file_command(char file1_name[], char file2_name[])
{
    FILE *fptr1 = fopen(file1_name, "rb");
    FILE *fptr2 = fopen(file2_name, "rb");

    if (fptr1 == NULL)
    {
        print_file_exist_error(file1_name);
        return;
    }

    if (fptr2 == NULL)
    {
        fclose(fptr2);
        fptr2 = fopen(file2_name, "wb");
    }
    else
    {
        fclose(fptr2);
        print_already_exist_warning(file2_name);

        int is_file_overwritten;
        is_file_overwritten = getch();

        while (is_file_overwritten != 'y' && is_file_overwritten != 'n')
        {
            print_already_exist_warning(file2_name);
            is_file_overwritten = getch();
        }

        if (is_file_overwritten == 'y')
            fptr2 = fopen(file2_name, "wb"); // overwrite , write binary mode
        else
            fptr2 = fopen(file2_name, "ab+"); // append , append binary mode
    }

    copy_file_contents(fptr1, fptr2);

    print_file_copy_successfully();
    return;
}

void execute_mv_command()
{
    char file1_name[100];
    char file2_name[100];

    scanf("%s%s", file1_name, file2_name);
    handle_move_file_command(file1_name, file2_name);
    printf("\n");
}

void handle_move_file_command(char file1_name[], char file2_name[])
{
    FILE *fptr1 = fopen(file1_name, "rb");
    FILE *fptr2 = fopen(file2_name, "rb");

    if (fptr1 == NULL)
    {
        print_file_exist_error(file1_name);
        return;
    }

    if (fptr2 == NULL)
    {
        fclose(fptr2);
        fptr2 = fopen(file2_name, "wb");
    }
    else
    {
        fclose(fptr2);
        print_already_exist_warning(file2_name);

        int is_file_overwritten;
        is_file_overwritten = getch();
        while (is_file_overwritten != 'y' && is_file_overwritten != 'n')
        {
            print_already_exist_warning(file2_name);
            is_file_overwritten = getch();
        }

        if (is_file_overwritten == 'y')
            fptr2 = fopen(file2_name, "wb"); // overwrite , write binary mode
        else
            fptr2 = fopen(file2_name, "ab+"); // append , append binary mode
    }

    copy_file_contents(fptr1, fptr2);

    if (remove(file1_name) == 0)
        print_file_moved_successfully(file1_name);
    else
        printf("cannot move file:(\n");
}

void execute_passwd_command()
{
    char entered_password[100];

    getchar();
    print_enter_current_password();
    gets(entered_password);

    handle_change_current_password(entered_password);
}

void handle_change_current_password(char entered_password[])
{
    char cwd[PATH_MAX];
    char current_address[1000];
    char new_password[100];
    int entered_password_strength;

    getcwd(cwd, sizeof(cwd));
    strcpy(current_address, cwd);

    if (!is_strings_equal(entered_password, current_user.passwd))
    {
        print_incorrect_password_error();
        return;
    }

    print_enter_new_password();

    gets(new_password);
    entered_password_strength = get_password_strength(new_password);

    while (entered_password_strength < MIN_PASSWORD_STRENGTH)
    {
        print_weak_password_error();
        gets(new_password);
        entered_password_strength = get_password_strength(new_password);
    }

    if (update_new_user_password_file(new_password, entered_password_strength))
    {
        print_successfully_update_password();
        chdir(current_address);
        return;
    }

    print_user_not_found_error();
    chdir(current_address);
    return;
}

void execute_passwd_dash_l_command()
{
    getchar();

    if (current_user.access == 1)
    {
        get_new_data_by_admin();
        return;
    }

    print_permission_denied_error();
}

void get_new_data_by_admin()
{
    char date[40], time[20], date_copy[40], time_copy[20], entered_username[100], new_password[100];

    scanf("%s%s", date, time);
    scanf("%s", entered_username);
    strcpy(date_copy, date);
    strcpy(time_copy, time);

    if (!is_username_exist(entered_username))
    {
        print_user_exist_error();
        return;
    }

    if (!is_expiration_time_valid(date, time))
    {
        setcolor(12);
        printf("invalid time format!\n");
        return;
    }

    strcat(date_copy, " ");
    strcat(date_copy, time_copy);
    getchar();

    print_enter_new_password();
    gets(new_password);

    handle_passwd_dash_l_command(entered_username, new_password, date_copy);
}

bool is_username_exist(char entered_username[])
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {
        if (is_strings_equal(temp_user.username, entered_username))
        {
            return true;
        }
    }

    fclose(fptr);
    return false;
}

bool is_expiration_time_valid(char entered_date[], char entered_time[]) // date : 2024/12/12  time2: 22:52:12
{
    if ((strlen(entered_date) != 10) || (strlen(entered_time) != 8))
    {
        return false;
    }

    int integer_date[3]; // includes year,month,day
    int integer_time[3]; // includes hour,minute , second
    int counter = 0;
    char *ptr_date = strtok(entered_date, "/");

    while (ptr_date != NULL)
    {
        if (!has_time_valid_digits(ptr_date))
            return false;

        integer_date[counter] = atoi(ptr_date);
        counter++;
        ptr_date = strtok(NULL, "/");
    }

    if (!is_date_valid(integer_date[0], integer_date[1], integer_date[2]))
        return false;

    counter = 0;

    char *ptr_time = strtok(entered_time, ":");

    while (ptr_time != NULL)
    {
        if (!has_time_valid_digits(ptr_time))
            return false;

        integer_time[counter] = atoi(ptr_time);
        counter++;
        ptr_time = strtok(NULL, ":");
    }

    if (!is_time_valid(integer_time[0], integer_time[1], integer_time[2]))
        return false;

    return true;
}

bool has_time_valid_digits(char entered_time[])
{
    for (int i = 0; i < strlen(entered_time); i++)
    {
        if (!isdigit(entered_time[i]))
            return false;
    }
    return true;
}

bool is_date_valid(int year, int month, int day)
{
    if (get_integer_length(year) != 4 ||
        get_integer_length(month) >= 3 ||
        get_integer_length(day) >= 3)
        return false;

    if (month <= 0 || month >= 13 || day <= 0 || day >= 32)
        return false;

    return true;
}

bool is_time_valid(int hour, int minute, int second)
{
    if (get_integer_length(hour) >= 3 ||
        get_integer_length(minute) >= 3 ||
        get_integer_length(second) >= 3)
        return false;

    if (hour < 0 || hour > 24 || minute < 0 || minute > 60 || second < 0 || second > 60)
        return false;

    return true;
}

int get_integer_length(int value)
{
    int length = 1;
    while (value > 9)
    {
        length++;
        value /= 10;
    }

    return length;
}

void handle_passwd_dash_l_command(char username[], char new_password[], char full_time[])
{
    int password_strength;
    bool is_updated_successfully = false;

    password_strength = get_password_strength(new_password);

    while (password_strength < MIN_PASSWORD_STRENGTH)
    {
        print_weak_password_error();
        gets(new_password);
        password_strength = get_password_strength(new_password);
    }

    is_updated_successfully = update_password_file_by_admin(username, new_password, full_time, password_strength);

    if (!is_updated_successfully)
        print_user_not_found_error();
}

void execute_hide_command()
{
    getchar();
    char file_name[100];
    gets(file_name);
    handle_hide_file_command(file_name);
}

void handle_hide_file_command(char file_name[])
{
    char command[100];

    sprintf(command, "attrib +h %s", file_name);
    system(command);
}

void execute_hide_dash_r_command()
{
    char file_name[100];

    getchar();
    gets(file_name);

    handle_show_file_command(file_name);
}

void handle_show_file_command(char file_name[])
{
    char command[100];

    sprintf(command, "attrib -h %s", file_name);
    system(command);
}

void execute_exif_command()
{
    char file_name[100];

    getchar();
    gets(file_name);

    handle_exif_file_command(file_name);
    printf("\n");
}

void handle_exif_file_command(char file_name[])
{
    struct stat stats;
    //* stat() returns 0 on successful operation,
    //* otherwise returns -1 if unable to get file properties.

    if (stat(file_name, &stats) == 0)
    {
        print_file_properties(stats);
        return;
    }

    print_exif_file_error(file_name);
}

void print_file_properties(struct stat stats)
{
    setcolor(11);
    struct tm dt;

    // File permissions
    printf("\nFile access: ");
    if (stats.st_mode & R_OK)
        printf("read ");

    if (stats.st_mode & W_OK)
        printf("write ");

    if (stats.st_mode & X_OK)
        printf("execute");

    // File size
    printf("\nFile size: %d", stats.st_size);

    // Get file creation time in seconds and
    // convert seconds to date and time format
    dt = *(gmtime(&stats.st_ctime));
    printf("\nCreated on: %d/%d/%d %d:%d:%d",
           dt.tm_year + 1900, dt.tm_mon + 1, dt.tm_mday + 1,
           dt.tm_hour + 1, dt.tm_min + 1, dt.tm_sec + 1);

    // File modification time
    dt = *(gmtime(&stats.st_mtime));
    printf("\nModified on: %d/%d/%d %d:%d:%d",
           dt.tm_year + 1900, dt.tm_mon + 1, dt.tm_mday + 1,
           dt.tm_hour + 1, dt.tm_min + 1, dt.tm_sec + 1);
}

void execute_search_command()
{
    char entered_name[100];
    bool is_directory = false;

    getchar();
    gets(entered_name);

    FILE *fptr = fopen(entered_name, "rb");

    if (fptr == NULL)
    {
        is_directory = true;
        fclose(fptr);
    }

    handle_search_directory(entered_name, is_directory);
}

void handle_search_directory(char tobe_searched_name[], bool is_directory)
{
    setcolor(11);
    char tobe_searched_address[100];

    if (is_directory)
    {
        sprintf(tobe_searched_address, "dir %s /ad /s", tobe_searched_name);
    }
    else
    {
        sprintf(tobe_searched_address, "dir %s /s /b", tobe_searched_name);
    }

    system(tobe_searched_address);
}

void execute_greater_command(char file1_name[])
{
    char file2_name[100];
    scanf("%s", file2_name);
    handle_redirection_greater_operand(file1_name, file2_name);
}

void handle_redirection_greater_operand(char file1_name[], char file2_name[]) //>
{
    setcolor(11);
    FILE *fptr1 = fopen(file1_name, "rb");
    FILE *fptr2 = fopen(file2_name, "wb");

    if (fptr1 == NULL)
    {
        fprintf(fptr2, "%s", file1_name);
        fclose(fptr2);
        return;
    }

    if (fptr2 == NULL)
    {
        print_file_exist_error(file2_name);
        return;
    }

    print_keep_file_question(file1_name);
    int is_file_kept = getch();

    while (is_file_kept != 'y' && is_file_kept != 'n')
    {
        print_keep_file_question(file1_name);
        is_file_kept = getch();
    }

    copy_file_contents(fptr1, fptr2);

    if (is_file_kept == 'n')
    {
        remove(file1_name);
    }
}

void copy_file_contents(FILE *fptr1, FILE *fptr2)
{
    char ch;
    ch = fgetc(fptr1);

    while (!feof(fptr1))
    {
        fputc(ch, fptr2);
        ch = fgetc(fptr1);
    }

    fclose(fptr1);
    fclose(fptr2);
}

void execute_greater_equal_command(char file1_name[])
{
    char file2_name[100];
    scanf("%s", file2_name);
    handle_redirection_greater_equal_operand(file1_name, file2_name);
}

void handle_redirection_greater_equal_operand(char file1_name[], char file2_name[]) //>>
{

    FILE *fptr1 = fopen(file1_name, "rb");
    FILE *fptr2 = fopen(file2_name, "ab+");
    char ch;

    if (fptr1 == NULL)
    {
        fprintf(fptr2, "%s", file1_name);
        fclose(fptr2);
        return;
    }

    if (fptr2 == NULL)
    {
        print_file_exist_error(file2_name);
        return;
    }

    print_keep_file_question(file1_name);
    int is_file_kept = getch();

    while (is_file_kept != 'y' && is_file_kept != 'n')
    {
        print_keep_file_question(file1_name);
        is_file_kept = getch();
    }

    copy_file_contents(fptr1, fptr2);

    if (is_file_kept == 'n')
    {
        remove(file1_name);
    }
}

void handle_incorrect_command()
{
    current_user.mistakes++;
    print_incorrect_command();
    update_usersinfo_file();
}

int execute_pwd_command()
{
    char cwd[PATH_MAX];

    if (getcwd(cwd, sizeof(cwd)) != NULL)
    {
        setcolor(11);
        printf("\nCurrent working dir: %s\n", cwd);
        return 0;
    }
    else
    {
        perror("getcwd() error\n");
        return 1;
    }
}

void execute_exit_command()
{
    getchar();
    system("cls");
    print_endof_program();
}

void execute_time_command()
{
    time_t current_system_time;
    struct tm *current_local_time;

    current_system_time = time(NULL);
    current_local_time = localtime(&current_system_time);

    setcolor(2);
    printf("%02d:%02d:%02d\n",
           current_local_time->tm_hour,
           current_local_time->tm_min,
           current_local_time->tm_sec);
}

void execute_time_dash_a_command()
{
    char current_time_str[80];
    struct tm *current_local_time;

    time_t current_system_time;
    current_system_time = time(NULL);
    current_local_time = localtime(&current_system_time);

    setcolor(2);
    strftime(current_time_str,
             sizeof(current_time_str),
             "%B %A %Y-%m-%d %H:%M:%S %p %Z",
             current_local_time);

    puts(current_time_str);
    printf("\n");
}

void execute_level_command()
{
    printf("%d\n", current_user.access);
}

int get_password_strength(char entered_password[])
{
    int i, password_strength = 0;
    char character;

    for (i = 0; i < strlen(entered_password); i++)
    {
        character = entered_password[i];

        if (ispunct(character))
        {
            password_strength += 8;
        }

        if (isdigit(character))
        {
            password_strength += 3;
        }

        if (isalpha(character))
        {
            if (isupper(character))
                password_strength += 4;
            else
                password_strength += 2;
        }

        if (character == ' ')
        {
            password_strength += 1;
        }
    }

    return password_strength;
}
