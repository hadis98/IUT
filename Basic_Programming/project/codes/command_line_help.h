
#ifndef COMMAND_LINE_HELP_H
#define COMMAND_LINE_HELP_H

#include "headers.h"
#include "general.h"

int get_help_selected_choice();
int handle_help_command_selection(int);

void redirection_command_help();
void mkdir_command_help();
void execute_help_command();
void help_command_summery();

#endif