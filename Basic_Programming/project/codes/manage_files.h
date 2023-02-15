
#ifndef MANAGE_FILES_H
#define MANAGE_FILES_H

#include "headers.h"
#include "general.h"
#include "print_messages.h"

bool update_usersinfo_file();
bool read_usersinfo_file();
bool write_usersinfo_file();
bool update_new_user_password_file(char[], int);
bool update_password_file_by_admin(char[], char[], char[], int);
void load_file_info();
void print_users_info();
bool has_extra_users();
void delete_users_directories();
bool is_directory_exist(char[]);
void rmtree(const char[]);

#endif
