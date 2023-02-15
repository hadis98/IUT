#ifndef PRINT_MESSAGES_H
#define PRINT_MESSAGES_H

#include "headers.h"
#include "general.h"

void print_user_exist_error();
void print_welcome_messages();
void print_enter_retry();
void print_enter_user_successfully(char[]);
void print_enter_name();
void print_enter_username();
void print_enter_password();
void print_take_user_password(char[]);
void print_timeout_user_session(char[]);
void print_save_new_user_error();
void print_enter_time();
void print_successfully_update_password();
void print_successfully_save_password();
void print_successfully_save_new_user();
void print_directory_successfully_created();
void print_enter_new_password();
void print_directory_create_error();
void print_welcome_user_login(char[]);
void print_weak_password_error();
void print_user_not_found_error();
void print_incorrect_password_error();
void print_permission_denied_error();
void print_successfully_admin_update_password(char[]);
void print_user_directory_details(struct user);
void print_normal_user_directory_info(struct user, char[]);
void print_admin_user_directory_info(struct user, char[]);
void print_search_failed_error();
void print_file_exist_error(char[]);
void print_incorrect_command();
void print_new_admin(char[]);
void print_admin_create_error(char[]);
void print_wc_command_info(char[], int, int, int);
void print_delete_file_successfully();
void print_rm_command_error(bool);
void print_keep_file_question(char[]);
void print_endof_program();
void print_already_exist_warning(char[]);
void print_file_moved_successfully(char[]);
void print_enter_current_password();
void print_exif_file_error(char[]);
void print_file_copy_successfully();

#endif