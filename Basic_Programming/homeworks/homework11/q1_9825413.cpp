 #include<stdio.h>
  #include <stdlib.h>
       struct person
       {
               int id;
              char name[25];
             
             
       };

       int main()
       {
	     int i;
	   scanf("%d",&i);
              FILE *fp;
              char ch;
              int number,number2;
              struct person s;

              fp = fopen("f36590183.txt","rb");       

              if(fp == NULL)
              {
                     printf("Can't open file");
                     exit(0);
              }
            
              
              number = sizeof(s)*(i-1);
              
              printf("(i)th record in file:\n");
              
               fseek(fp,number,SEEK_SET);
              fread(&s,sizeof(s),1,fp);
               fclose(fp);
              
              printf("%d:%s",s.id,s.name);

             
              return 0;
       }
