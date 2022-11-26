#ifndef MEM_H
#define MEM_H

/* Series of functions used to add memory store functionality to the calculator */

char* variable_names[100]; 
// Flags for if the variables have been set
int variable_set[100];
// Number of variables defined
int variable_counter = 0; 
// Store values of the variables
double variable_values[100];

/* Add a variable name to the memory store */
int add_variable(char* var_name)
{
	int x; 
	/* Search for the variable and return its index if found */	
	for (x = 0; x<variable_counter; x++) {
		if (strcmp(var_name, variable_names[x]) == 0) {
				return x;
		}
	}

	/* Variable not found yet. */
	/* Define it and add it to the end of the array. */
	variable_counter++;
	//strdup() function is used to duplicate a string. 
	variable_names[x] = strdup(var_name); 
	return x;
}

/* Set a variables value in the memory store */
int set_variable(int index, double val)
{
	variable_values[index] = val;
	variable_set[index] = 1;
	
	return val;
}

#endif