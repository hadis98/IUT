#include "manage_files.h"

bool update_usersinfo_file()
{
    if (read_usersinfo_file())
    {
        write_usersinfo_file();
        return true;
    }

    return false;
}

bool read_usersinfo_file()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fread(&users[i], sizeof(struct user), 1, fptr);

        if (is_strings_equal(users[i].username, current_user.username))
        {
            users[i] = current_user;
            fclose(fptr);
            return true;
        }
    }

    fclose(fptr);
    return false;
}

bool write_usersinfo_file()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "wb");

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fwrite(&users[i], sizeof(struct user), 1, fptr);
    }

    fclose(fptr);

    if (fwrite != 0)
        return true;

    return false;
}

bool update_new_user_password_file(char new_password[], int entered_password_strength)
{

    strcpy(current_user.passwd, new_password);
    current_user.strength = entered_password_strength;

    if (update_usersinfo_file())
        return true;

    return false;
}

bool update_password_file_by_admin(char username[], char new_password[], char entered_time[], int password_strength)
{

    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fread(&users[i], sizeof(struct user), 1, fptr);

        if (is_strings_equal(users[i].username, username))
        {
            users[i].strength = password_strength;
            strcpy(users[i].passwd, new_password);
            strcpy(users[i].time, entered_time);
            fclose(fptr);

            if (write_usersinfo_file())
            {
                print_successfully_admin_update_password(username);
                return true;
            }
        }
    }

    return false;
}

void load_file_info()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");

    int counter = 0;
    struct user temp;

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        fread(&users[i], sizeof(struct user), 1, fptr);
    }

    fclose(fptr);
}

void print_users_info()
{
    printf("number of users: %d\n", NUMBER_OF_USERS);

    for (int i = 0; i < NUMBER_OF_USERS; i++)
    {
        printf("username: %s , password: %s , strength: %d, mistakes:%d, access: %d , time: %s\n", users[i].username, users[i].passwd, users[i].strength, users[i].mistakes, users[i].access, users[i].time);
    }
}

bool has_extra_users()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {
        if (temp_user.username != ADMIN_USERNAME)
            return true;
    }

    fclose(fptr);
    return false;
}

void delete_users_directories()
{
    FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "rb");
    struct user temp_user;

    while (fread(&temp_user, sizeof(struct user), 1, fptr))
    {
        if (!is_strings_equal(temp_user.username, ADMIN_USERNAME) && is_directory_exist(temp_user.username))
            rmdir(temp_user.username);
    }

    fclose(fptr);
}

bool is_directory_exist(char directory_name[])
{
    struct stat sb;
    if (stat(directory_name, &sb) == 0 && S_ISDIR(sb.st_mode))
        return true;

    return false;
}

void rmtree(const char path[])
{
    size_t path_len;
    char *full_path;
    DIR *dir;
    struct stat stat_path, stat_entry;
    struct dirent *entry;

    stat(path, &stat_path);

    // if path does not exists or is not dir
    if (S_ISDIR(stat_path.st_mode) == 0)
    {
        fprintf(stderr, "%s: %s\n", "Is not directory", path);
    }

    // if not possible to read the directory for this user
    if ((dir = opendir(path)) == NULL)
    {
        fprintf(stderr, "%s: %s\n", "Can`t open directory", path);
    }

    path_len = strlen(path);

    // iteration through entries in the directory
    while ((entry = readdir(dir)) != NULL)
    {

        // skip entries "." and ".."
        if (!strcmp(entry->d_name, ".") || !strcmp(entry->d_name, ".."))
            continue;

        // determinate a full path of an entry
        full_path = (char *)calloc(path_len + strlen(entry->d_name) + 1, sizeof(char));
        strcpy(full_path, path);
        strcat(full_path, "/");
        strcat(full_path, entry->d_name);

        // stat for the entry
        stat(full_path, &stat_entry);

        // recursively remove a nested directory
        if (S_ISDIR(stat_entry.st_mode) != 0)
        {
            rmtree(full_path);
            continue;
        }

        // remove a file object
        if (unlink(full_path) == 0)
            printf("Removed a file: %s\n", full_path);
        else
            printf("Can`t remove a file: %s\n", full_path);
        free(full_path);
    }

    // remove the devastated directory and close the object of it
    if (rmdir(path) == 0)
        printf("Removed a directory: %s\n", path);
    else
        printf("Can`t remove a directory: %s\n", path);

    closedir(dir);
}