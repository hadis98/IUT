#ifndef COMMANDS_H
#define COMMANDS_H

#include "headers.h"
#include "general.h"
#include "print_messages.h"
#include "command_line_help.h"
#include "manage_files.h"

void copy_file_contents(FILE *fptr1, FILE *fptr2);
int get_number_of_users();

void execute_ls_command();

void execute_mkdir_command();

void execute_chgr_command();

int execute_pwd_command();

void increse_user_access_level(char[]);
bool is_user_eligible_tobe_admin(struct user);

void execute_create_command();
void handle_create_new_user_command(char[]);
bool make_directory(char[]);
bool handle_create_new_user_file(char[]);

void execute_su_command();
void switch_user_command(char[]);
bool handle_switch_user(bool, char[]);
void switch_user_login_successfully(char[]);

void execute_diff_command();
void handle_diff_files_command(char[], char[]);

void execute_cd_command();

void execute_cat_command();
void handle_cat_file_command(char[]);

void execute_wc_command();
void handle_word_count_command(char[]);

void execute_rm_command();
void execute_rm_dash_r_command();

void execute_cp_command();
void handle_copy_file_command(char[], char[]);

void execute_mv_command();
void handle_move_file_command(char[], char[]);

void execute_time_command();
void execute_time_dash_a_command();

void execute_passwd_command();
void handle_change_current_password(char[]);

void execute_passwd_dash_l_command();
void get_new_data_by_admin();
void handle_passwd_dash_l_command(char username[], char new_password[], char full_time[]);
bool is_username_exist(char[]);
bool is_expiration_time_valid(char[], char[]);
bool is_date_valid(int, int, int);
bool is_time_valid(int, int, int);
int get_integer_length(int);
bool has_time_valid_digits(char[]);

void execute_hide_command();
void handle_hide_file_command(char[]);

void execute_hide_dash_r_command();
void handle_show_file_command(char[]);

void execute_exif_command();
void handle_exif_file_command(char[]);
void print_file_properties(struct stat);

void execute_search_command();
void handle_search_directory(char[], bool);

void execute_greater_command(char[]);
void handle_redirection_greater_operand(char[], char[]);

void execute_greater_equal_command(char[]);
void handle_redirection_greater_equal_operand(char[], char[]);

void execute_exit_command();
void execute_level_command();
void handle_incorrect_command();

int get_password_strength(char[]);

#endif