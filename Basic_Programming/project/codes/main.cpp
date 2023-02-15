#include "headers.h"
#include "general.h"
#include "commands.h"
#include "command_line_help.h"
#include "manage_commands.h"
#include "user_login.h"

void init_base_address();
void handle_start_option_selection();
void init_configs();
void init_admin_config();

int NUMBER_OF_USERS = 0;
user users[1000], current_user;
char ROOT_DIRECTORY[120], USERSINFO_FILE_ADDRESS[120];

int main()
{

	init_base_address();
	handle_start_option_selection();
	NUMBER_OF_USERS = get_number_of_users();
	load_file_info();
	print_welcome_messages();
	handle_user_enter();
	handle_user_commands();

	return 0;
}

void init_base_address()
{
	char cwd[PATH_MAX];

	chdir("..");
	getcwd(cwd, sizeof(cwd));

	strcpy(ROOT_DIRECTORY, cwd);
	sprintf(USERSINFO_FILE_ADDRESS, "%s\\%s", cwd, USERSINFO_FILE);
}

void handle_start_option_selection()
{
	int is_init_config_selected = false;

	do
	{
		setcolor(1);
		printf("\n\nDo you want to start with initial admin file and dismiss updated usersinfo.txt file: y/n?\n");

		is_init_config_selected = getch();
	} while (is_init_config_selected != 'y' && is_init_config_selected != 'n');

	if (is_init_config_selected == 'y')
		init_configs();
}

void init_configs()
{
	if (has_extra_users())
	{
		printf("hello\n");
		delete_users_directories();
	}

	init_admin_config();
}

void init_admin_config()
{
	struct user admin_user;
	strcpy(admin_user.name, ADMIN_NAME);
	strcpy(admin_user.username, ADMIN_USERNAME);
	strcpy(admin_user.passwd, ADMIN_PASSWORD);
	admin_user.strength = get_password_strength(admin_user.passwd);
	admin_user.access = ADMIN_ACCESS;
	admin_user.mistakes = 0;
	strcpy(admin_user.time, ADMIN_TIME);

	if (!is_directory_exist(admin_user.username))
		make_directory(admin_user.username);

	FILE *fptr = fopen(USERSINFO_FILE_ADDRESS, "wb");
	fwrite(&admin_user, sizeof(struct user), 1, fptr);
	fclose(fptr);
}
