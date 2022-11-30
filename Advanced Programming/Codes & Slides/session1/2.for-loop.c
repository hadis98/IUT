#include <stdio.h>
int main()
{
    int num, count, sum = 0;

    printf("Enter a positive integer: ");
    scanf("%d", &num);

    // for loop terminates when n is less than count
    for(count = 1; count <= num; ++count)
    {
        sum += count;
    }

    printf("Sum = %d", sum);

    return 0;
}




1.
for (num=10; num<20; num=num+1)

2.
int num=10;
for (;num<20;num++)

3.
for (num=10; num<20; )
{
      //Code
      num++;
}

4.
int num=10;
for (;num<20;)
{
      //Statements
      num++;
}


