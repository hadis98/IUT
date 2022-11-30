#include<stdio.h>
 
int main() {
   char s[50], s1[50];
   int i;
   gets(s);
   gets(s1);
 
   i = 0;
  while (s[i] == s1[i] && s[i] != '\0')
      i++;
   if (s[i] > s1[i])
      printf("1");
   else if (s[i] < s1[i])
      printf("-1");
   else
      printf("0");
 
   return (0);
}
