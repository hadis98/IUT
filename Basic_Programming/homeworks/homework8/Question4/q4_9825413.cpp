#include<stdio.h>
#include<string.h>
int func1(char a[], char b[]);
int main()
{
	
	 int i = 0, m, j;
 char a[1000][1000];
  char t[1000];

 while (1)
 {
  scanf("%s ",a[i]);
  if (a[i][0] == 0)
   break;
  i++;
 }
 m = i;
 for (i = 0; i <= m; i++)
 {
  for (j = i + 1; j <= m; j++)
  {
   if (func1(a[i], a[j]) == -1)
   {
    strcpy(t, a[i]);
    strcpy(a[i], a[j]);
    strcpy(a[j], t);
   }
  }
 }
 for (i = 0; i<=m-2; i++)
 {
  printf("%s ", a[i]);
 }
 return 0;
}

int func1(char x[], char y[])
{
    if (x[0] >= 65 && x[0] <= 90 && y[0] >= 97 && y[0] <= 122)
 {
  if (x[0]+32 > y[0])
  {
   return -1;
  }
 }
  if (x[0] >= 97 && x[0] <= 122 && y[0] >= 65 && y[0] <= 90)
 {
  if (x[0] - 32 > y[0])
  {
   return -1;
  }
  if (x[0]-32==y[0])
  {
   return -1;
  }
 }
 if ( (x[0] > 96 && x[0] < 123 && y[0] > 96 && y[0] < 123)|| (x[0] >64 && x[0] < 91 && y[0] > 64 && y[0] <91) )
 {

   if (x[0] == y[0])
  {
   if (x[1] > y[1])
    return -1;
  }
  if (x[0] > y[0])
  {
   return -1;
  }

 }

}

















