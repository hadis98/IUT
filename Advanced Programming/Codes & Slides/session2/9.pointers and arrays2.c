#include <stdio.h>
int main()
{
  int i, classes[6],sum = 0;
  printf("Enter 6 numbers:\n");
  for(i = 0; i < 6; ++i)
  {
      // (classes + i) is equivalent to &classes[i]
      scanf("%d",(classes + i));

      // *(classes + i) is equivalent to classes[i]
      sum += *(classes + i);
  }
  printf("Sum = %d", sum);
  return 0;
}




src: https://www.programiz.com/c-programming/c-pointers-arrays