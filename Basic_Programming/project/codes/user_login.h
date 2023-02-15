
#ifndef USER_LOGIN_H
#define USER_LOGIN_H

#include "headers.h"
#include "general.h"
#include "print_messages.h"

void handle_user_enter();
bool is_user_exist(char[], char[]);
struct user get_user_structure(char[], char[]);

#endif