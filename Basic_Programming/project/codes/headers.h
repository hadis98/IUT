
#ifndef HEADERS_H
#define HEADERS_H

#include <stdio.h>
#include <unistd.h>
#include <limits.h>
#include <process.h>
#include <io.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include <ctype.h>
#include <conio.h>
#include <time.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <errno.h>

#define MIN_PASSWORD_STRENGTH 34
#define ADMIN_NAME "hadis"
#define ADMIN_USERNAME "admin"
#define ADMIN_PASSWORD "1234"
#define ADMIN_TIME "2050/12/13 12:12:12"
#define ADMIN_ACCESS 1
#define USERSINFO_FILE "usersinfo.txt"

struct user
{
    char name[30];
    char username[30];
    char passwd[40];
    int strength;
    int access;
    int mistakes;
    char time[30];
};

extern user users[1000], current_user;
extern int NUMBER_OF_USERS;
extern int errno;
extern char ROOT_DIRECTORY[120], USERSINFO_FILE_ADDRESS[120];

#endif