#include <stdio.h>
struct customer {
    int id;
    char name[150];
    unsigned long int balance;
}array[1000]; 
int size;
void  readFromFile();
void writeToFile(struct customer array[],int  size);

int main()
{
    int z;
  printf("enter the number of customers: ");
  scanf("%d",&size);
  writeToFile(array,size);
  readFromFile();

    return 0;
}
void writeToFile(struct customer array[],int  size)
{
FILE *fptr;
fptr=fopen("customers.dat","wb");
int i;
for(i=0;i<size;i++)
{
    printf("enetr id: ");
    scanf("%d",&array[i].id);
    printf("enter name: ");
    scanf("%s",array[i].name);
    printf("enter balance: ");
    scanf("%ld",&array[i].balance);

}
for(i=0;i<size;i++)
{
    fwrite(&array[i],sizeof(struct customer ),1,fptr);
}
fclose(fptr);
}
void  readFromFile()
{
FILE *fptr;
fptr=fopen("customers.dat","rb");
if(fptr==NULL)
{
    printf("file is not available");
    return ;
} 
char ch;
int i;
struct customer input[size];//!feof(fptr)
for(i=0;i<size;i++)
{
 fread(&input[i], sizeof(struct customer), 1, fptr);        
}
for(i=0;i<size;i++)
{
     printf ("id = %d\tname = %s\tbalance = %lu\n", input[i].id, 
        input[i].name, input[i].balance); 
}
fclose(fptr);
}

