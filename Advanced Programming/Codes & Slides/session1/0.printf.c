#include <stdio.h>
int main()
{

    int integer = 9876;
    float decimal = 987.6543;

    //  Prints the number right justified within 6 columns
    printf("4 digit integer right justified to 6 column: %6d\n", integer); //"   9876"
	
	
	printf("4 digit integer right justified to 6 column: %06d\n", integer); //"009876"
  
  // Tries to print number right justified to 3 digits but the number is not right adjusted because there are only 4 numbers
    printf("4 digit integer right justified to 3 column: %3d\n", integer); //9876

    // Rounds to two digit places
    printf("Floating point number rounded to 2 digits: %.2f\n",decimal); //987.65

    // Rounds to 0 digit places
    printf("Floating point number rounded to 0 digits: %.f\n",987.6543); // 988

    // Prints the number in exponential notation(scientific notation)
    printf("Floating point number in exponential form: %e\n",987.6543);  // 9.876543e+02
    return 0;
}   

ANOTHER :

#include<stdio.h>

main()
{
	printf(":%s:\n", "Hello, world!");
	printf(":%15s:\n", "Hello, world!");
	printf(":%.10s:\n", "Hello, world!");
	printf(":%-10s:\n", "Hello, world!");
	printf(":%-15s:\n", "Hello, world!");
	printf(":%.15s:\n", "Hello, world!");
	printf(":%15.10s:\n", "Hello, world!");
	printf(":%-15.10s:\n", "Hello, world!");
}


Output:
:Hello, world!:
:  Hello, world!:
:Hello, wor:
:Hello, world!:
:Hello, world!  :
:Hello, world!:
:     Hello, wor:
:Hello, wor     :
 
 
 Question: How to fill with specific characters (padding)?

Description:

    The printf(“:%s:\n”, “Hello, world!”); statement prints the string (nothing special happens.)
    The printf(“:%15s:\n”, “Hello, world!”); statement prints the string, but print 15 characters. If the string is smaller the “empty” positions will be filled with “whitespace.”
    The printf(“:%.10s:\n”, “Hello, world!”); statement prints the string, but print only 10 characters of the string.
    The printf(“:%-10s:\n”, “Hello, world!”); statement prints the string, but prints at least 10 characters. If the string is smaller “whitespace” is added at the end. (See next example.)
    The printf(“:%-15s:\n”, “Hello, world!”); statement prints the string, but prints at least 15 characters. The string in this case is shorter than the defined 15 character, thus “whitespace” is added at the end (defined by the minus sign.)
    The printf(“:%.15s:\n”, “Hello, world!”); statement prints the string, but print only 15 characters of the string. In this case the string is shorter than 15, thus the whole string is printed.
    The printf(“:%15.10s:\n”, “Hello, world!”); statement prints the string, but print 15 characters.
    If the string is smaller the “empty” positions will be filled with “whitespace.” But it will only print a maximum of 10 characters, thus only part of new string (old string plus the whitespace positions) is printed.
    The printf(“:%-15.10s:\n”, “Hello, world!”); statement prints the string, but it does the exact same thing as the previous statement, accept the “whitespace” is added at the end.

	
(src: https://www.codingunit.com/printf-format-specifiers-format-conversions-and-formatted-output)
	