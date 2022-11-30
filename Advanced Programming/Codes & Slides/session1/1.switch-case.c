# include <stdio.h>

int main() {

	char operators;
	double firstNumber, secondNumber;

	printf("Enter an operator (+, -, *, /): ");
	scanf("%c", &operators);

	printf("Enter two operands: ");
	scanf("%lf %lf", &firstNumber, &secondNumber);

	switch (operators)
	{
	case '+':
		printf("%.1lf + %.1lf = %.1lf", firstNumber, secondNumber, firstNumber + secondNumber);
		break;

	case '-':
		printf("%.1lf - %.1lf = %.1lf", firstNumber, secondNumber, firstNumber - secondNumber);
		break;

	case '*':
		printf("%.1lf * %.1lf = %.1lf", firstNumber, secondNumber, firstNumber*secondNumber);
		break;

	case '/':
		printf("%.1lf / %.1lf = %.1lf", firstNumber, secondNumber, firstNumber / firstNumber);
		break;

		// operator is doesn't match any case constant (+, -, *, /)
	default:
		printf("Error! operator is not correct");
	}

	return 0;
}