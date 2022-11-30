#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
 struct address
 {
    char city[200];
    char street[200];
    char alley[200];
    long int code_posti;

};
struct apartment
{
  double areaOFcunstruction;
    double basic_price;
    int numberOFfloor;
    bool elevator;
    address address1;
    double whole_price;
    
};

struct villa 
{
    double areaOFcunstruction;
    double areaOFyard;
    double basic_price;
     address address1;
    int numberOFfloors;
    double whole_price;

};
struct sale
{
    char type_home[200];//apartment or villa
   long int commission;//income for businessman
    char conditionsOFsale[100];//cash or cheque
     double whole_price;
    apartment apart1;
    villa vil1;
};
struct node
{
    sale sale1;
    struct node* next;
    
};
node *start=NULL;
//(node*)malloc(sizeof(node));
void record_new();
void record_new_villa();
void record_new_apartment();
void record_new_sale();
void view_info();
int numberOFhouse();
void view_by_price();
void bubbleSort();
void searchBYpriceANDarea(double ,double );
void searchBYstreet(char []);
int bubbleSort2();
void swap_double(double * , double*);
void swap_int(int* a, int* b);
void swap_long_int(long int* , long int* );
int main()
{
    while (1)
    {
        printf("1.record new villa or apartment \n");
        printf("2.view apartments & villas & sales\n");
        printf("3.view houses by price\n");
        printf("4.search1: find houses that have price fewer than x and have area of cunstruction more than y\n");
        printf("5.search2: find houses that are in a specified street\n");
        printf("6.the number of houses\n");
        printf("7.Exit\n");
        int n;
        scanf("%d",&n);
        switch (n)
        {
        case 1:
            record_new();
            break;
        case 2:
            view_info();
            break;
        case 3:
           view_by_price();
            break;
        case 4:
            double price,area;
            printf("enter the price: ");
            scanf("%lf",&price);
            printf("enter area: ");
            scanf("%lf",&area);
            searchBYpriceANDarea(area,price);
            break;
        case 5:
            printf("enter the name of street: ");
            char name[200];
            scanf("%s",name);
            searchBYstreet(name);
            break;
        case 6:
            printf("the number of houses is %d\n",numberOFhouse());
            break;
        case 7:
            return 0;
            break;
        default:
            printf("enter a number from given range:)\n");
            break;
        }
    }
    
  

    return 0;

}
void record_new()
{
    printf("choose :\n");
    printf("record new villa(enter 'villa')\n");
    printf("record new apartment(enter 'apartment')\n");
    printf("record new sale (enter 'sale')\n");
    char choice[50];
    scanf("%s",choice);
    if (strcmp(choice,"villa")==0)
    {
        record_new_villa();
    }
    else //if (strcmp(choice,"apartment")==0)
    {
        record_new_apartment();
    }


}
void record_new_villa()
{
     struct node* temp,*ptr;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return;
    }
    printf("enter the details of new villa:\n");
    printf("1.enter area of construction: ");
    scanf("%lf",&temp->sale1.vil1.areaOFcunstruction);
    printf("2.enter the area of yard:");
    scanf("%lf",&temp->sale1.vil1.areaOFyard);
    printf("3.enter the basic price: ");
    scanf("%lf",&temp->sale1.vil1.basic_price);
    printf("4.enter number of floors: ");
    scanf("%d",&temp->sale1.vil1.numberOFfloors);
    printf("5.enter address:\nA:enter the city:");
    scanf("%s",temp->sale1.vil1.address1.city);
    printf("B:enter the street:");
    scanf("%s",temp->sale1.vil1.address1.street);
    printf("C:enter the alley:");
    scanf("%s",temp->sale1.vil1.address1.alley);
    printf("D: enter the post code ");
    scanf("%ld",&temp->sale1.vil1.address1.code_posti);
    temp->sale1.vil1.whole_price=(temp->sale1.vil1.areaOFcunstruction+(temp->sale1.vil1.areaOFyard*0.3)) * temp->sale1.vil1.basic_price;
    temp->sale1.whole_price=temp->sale1.vil1.whole_price;
    printf("6.enter the commision:");
    scanf("%ld",&temp->sale1.commission);
    printf("7.enter the conditions: (enter 'cash' or 'cheque')");
    scanf("%s",temp->sale1.conditionsOFsale);
    printf("\n\n");
    strcpy(temp->sale1.type_home,"villa");

    if(start==NULL)
    {
        start=temp;
        temp->next=NULL;
    }
    else
    {
        ptr=start;

        while (ptr->next!=NULL)
        {
            ptr=ptr->next;
        }
        ptr->next=temp;
        temp->next=NULL;
    }
}
void record_new_apartment()
{
     struct node* temp,*ptr;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return;
    }
    printf("enter the details of new apartment:\n");
    printf("1.enter area of construction: ");
    scanf("%lf",&temp->sale1.apart1.areaOFcunstruction);
    printf("2.enter the basic price: ");
    scanf("%lf",&temp->sale1.apart1.basic_price);
    printf("3.enter number of floor: ");
    scanf("%d",&temp->sale1.apart1.numberOFfloor);
    printf("4.apartment has elevator?('y') or ('n')");
    char ans;
    getchar();
    scanf("%c",&ans);
    if(ans=='y') temp->sale1.apart1.elevator=true;
    else temp->sale1.apart1.elevator=false;
    printf("5.enter address:\nA:enter the city:");
    scanf("%s",temp->sale1.apart1.address1.city);
    printf("B:enter the street:");
    scanf("%s",temp->sale1.apart1.address1.street);
    printf("C:enter the alley:");
    scanf("%s",temp->sale1.apart1.address1.alley);
    printf("D: enter the post code :");
    scanf("%ld",&temp->sale1.apart1.address1.code_posti);
    temp->sale1.apart1.whole_price=temp->sale1.apart1.basic_price*temp->sale1.apart1.areaOFcunstruction;
    temp->sale1.whole_price=temp->sale1.apart1.whole_price;
     printf("6.enter the commision:");
    scanf("%ld",&temp->sale1.commission);
    printf("7.enter the conditions: (enter 'cash' or 'cheque')");
    scanf("%s",temp->sale1.conditionsOFsale);
    strcpy(temp->sale1.type_home,"apartment");
        if(start==NULL)
    {
        start=temp;
        temp->next=NULL;
    }
    else
    {
        ptr=start;

        while (ptr->next!=NULL)
        {
            ptr=ptr->next;
        }
        ptr->next=temp;
        temp->next=NULL;
    }
}
void view_info()
{
     struct node* temp;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return;
    }
    if (start==NULL)
    {
        printf("list is empty\n");
        return;
    }
    temp=start;
    while (temp!=NULL)
    {
        if (strcmp(temp->sale1.type_home,"villa")==0)
        {
            printf("the informations of villa: \n");
            printf("1.the area of construction: %lf \n",temp->sale1.vil1.areaOFcunstruction);
            printf("2.the area of yard is : %lf \n",temp->sale1.vil1.areaOFyard);
            printf("3.the basic price of villa: %lf \n",temp->sale1.vil1.basic_price);
            printf("4.the number of floors in villa: %d \n",temp->sale1.vil1.numberOFfloors);
            printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.vil1.address1.city,temp->sale1.vil1.address1.street,temp->sale1.vil1.address1.alley,temp->sale1.vil1.address1.code_posti);
            printf("6.the Whole price of villa: %lf \n",temp->sale1.vil1.whole_price);
            printf("7.the commission: %ld \n",temp->sale1.commission);
            printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
            printf("\t\t\t####################################\n\n");
            temp=temp->next;
        }
        else    
        {
            printf("the information of apartment: \n");
            printf("1.the area of construction: %lf \n",temp->sale1.apart1.areaOFcunstruction);
            printf("2.the basic price of apartment: %lf \n",temp->sale1.apart1.basic_price);
            printf("3.the number of floor in apartment: %d \n",temp->sale1.apart1.numberOFfloor);
            if(temp->sale1.apart1.elevator) printf("4.the apartment has elevator\n");
            else printf("4.the apartment has not elevator\n");
            printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.apart1.address1.city,temp->sale1.apart1.address1.street,temp->sale1.apart1.address1.alley,temp->sale1.apart1.address1.code_posti);
            printf("6.the Whole price of apartment: %lf \n",temp->sale1.apart1.whole_price);
            printf("7.the commission: %ld \n",temp->sale1.commission);
            printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
            printf("\t\t\t####################################\n\n");
            temp=temp->next;
            
        }
        

        
    }
    
      
}

int numberOFhouse()
{
     struct node* temp;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return 0;
    }
    if (start==NULL)
    {
        return 0;
    }
    temp=start;
    int cnt=0;
    while (temp!=NULL)
    {
       cnt++;
       temp=temp->next;
    }
    
    return cnt;
}
/*
void swap(node* a,node* b)
{
   double temp=a->sale1.whole_price;
   a->sale1.whole_price=b->sale1.whole_price;
   b->sale1.whole_price=temp;

}
*/
void swap(node* a,node* b)
{
    
    if (strcmp(a->sale1.type_home,"villa")==0 && strcmp(b->sale1.type_home,"villa")==0)
    {
        swap_double(&a->sale1.vil1.areaOFcunstruction,&b->sale1.vil1.areaOFcunstruction);
        swap_double(&a->sale1.vil1.areaOFyard,&b->sale1.vil1.areaOFyard);//
        swap_double(&a->sale1.vil1.basic_price,&b->sale1.vil1.basic_price);
        swap_int(&a->sale1.vil1.numberOFfloors,&b->sale1.vil1.numberOFfloors);
        swap_double(&a->sale1.vil1.whole_price,&b->sale1.vil1.whole_price);
        swap_long_int(&a->sale1.vil1.address1.code_posti,&b->sale1.vil1.address1.code_posti);
        bool ans;
        ans=a->sale1.apart1.elevator;
        a->sale1.apart1.elevator=b->sale1.apart1.elevator;
        b->sale1.apart1.elevator=ans;
        char temp_city[200];
        strcpy(temp_city,a->sale1.vil1.address1.city);
        strcpy(a->sale1.vil1.address1.city,b->sale1.vil1.address1.city);
        strcpy(b->sale1.vil1.address1.city,temp_city);
        char temp_street[200];
         strcpy(temp_street,a->sale1.vil1.address1.street);
        strcpy(a->sale1.vil1.address1.street,b->sale1.vil1.address1.street);
        strcpy(b->sale1.vil1.address1.street,temp_street);
        char temp_alley[200];
         strcpy(temp_alley,a->sale1.vil1.address1.alley);
        strcpy(a->sale1.vil1.address1.alley,b->sale1.vil1.address1.alley);
        strcpy(b->sale1.vil1.address1.alley,temp_alley);
        swap_long_int(&a->sale1.commission,&b->sale1.commission);
        char temp_condition[200];
        strcpy(temp_condition,a->sale1.conditionsOFsale);
        strcpy(a->sale1.conditionsOFsale,b->sale1.conditionsOFsale);
        strcpy(b->sale1.conditionsOFsale,temp_condition);
        swap_double(&a->sale1.whole_price,&b->sale1.whole_price);
    }
    else if (strcmp(a->sale1.type_home,"apartment")==0 && strcmp(b->sale1.type_home,"apartment")==0)
    {
        swap_double(&a->sale1.apart1.areaOFcunstruction,&b->sale1.apart1.areaOFcunstruction);
        swap_double(&a->sale1.apart1.basic_price,&b->sale1.apart1.basic_price);
        swap_double(&a->sale1.apart1.whole_price,&b->sale1.apart1.whole_price);
        swap_int(&a->sale1.apart1.numberOFfloor,&b->sale1.apart1.numberOFfloor);
        swap_long_int(&a->sale1.vil1.address1.code_posti,&b->sale1.vil1.address1.code_posti);
          char temp_city[200];
        strcpy(temp_city,a->sale1.apart1.address1.city);
        strcpy(a->sale1.apart1.address1.city,b->sale1.apart1.address1.city);
        strcpy(b->sale1.apart1.address1.city,temp_city);
        char temp_street[200];
         strcpy(temp_street,a->sale1.apart1.address1.street);
        strcpy(a->sale1.apart1.address1.street,b->sale1.apart1.address1.street);
        strcpy(b->sale1.apart1.address1.street,temp_street);
        char temp_alley[200];
         strcpy(temp_alley,a->sale1.apart1.address1.alley);
        strcpy(a->sale1.apart1.address1.alley,b->sale1.apart1.address1.alley);
        strcpy(b->sale1.apart1.address1.alley,temp_alley);
        swap_long_int(&a->sale1.commission,&b->sale1.commission);
        char temp_condition[200];
        strcpy(temp_condition,a->sale1.conditionsOFsale);
        strcpy(a->sale1.conditionsOFsale,b->sale1.conditionsOFsale);
        strcpy(b->sale1.conditionsOFsale,temp_condition);
        swap_double(&a->sale1.whole_price,&b->sale1.whole_price);

    }
    else if (strcmp(a->sale1.type_home,"apartment")==0 && strcmp(b->sale1.type_home,"villa")==0)
    {
        swap_double(&a->sale1.apart1.areaOFcunstruction,&b->sale1.vil1.areaOFcunstruction);
        swap_double(&a->sale1.apart1.basic_price,&b->sale1.vil1.basic_price);
        swap_double(&a->sale1.apart1.whole_price,&b->sale1.vil1.whole_price);
        swap_int(&a->sale1.apart1.numberOFfloor,&b->sale1.vil1.numberOFfloors);
        swap_long_int(&a->sale1.apart1.address1.code_posti,&b->sale1.vil1.address1.code_posti);
        swap_double(&a->sale1.whole_price,&b->sale1.whole_price);
        char temp_city[200];
        strcpy(temp_city,a->sale1.apart1.address1.city);
        strcpy(a->sale1.apart1.address1.city,b->sale1.vil1.address1.city);
        strcpy(b->sale1.vil1.address1.city,temp_city);
        char temp_street[200];
         strcpy(temp_street,a->sale1.apart1.address1.street);
        strcpy(a->sale1.apart1.address1.street,b->sale1.vil1.address1.street);
        strcpy(b->sale1.vil1.address1.street,temp_street);
        char temp_alley[200];
         strcpy(temp_alley,a->sale1.apart1.address1.alley);
        strcpy(a->sale1.apart1.address1.alley,b->sale1.vil1.address1.alley);
        strcpy(b->sale1.vil1.address1.alley,temp_alley);
        swap_long_int(&a->sale1.commission,&b->sale1.commission);
        char temp_condition[200];
        strcpy(temp_condition,a->sale1.conditionsOFsale);
        strcpy(a->sale1.conditionsOFsale,b->sale1.conditionsOFsale);
        strcpy(b->sale1.conditionsOFsale,temp_condition);
    }
    else
    {
        swap_double(&a->sale1.vil1.areaOFcunstruction,&b->sale1.apart1.areaOFcunstruction);
        swap_double(&a->sale1.vil1.basic_price,&b->sale1.apart1.basic_price);
        swap_double(&a->sale1.vil1.whole_price,&b->sale1.apart1.whole_price);
        swap_int(&a->sale1.vil1.numberOFfloors,&b->sale1.apart1.numberOFfloor);
        swap_long_int(&a->sale1.vil1.address1.code_posti,&b->sale1.apart1.address1.code_posti);
        swap_double(&a->sale1.whole_price,&b->sale1.whole_price);
        char temp_city[200];
        strcpy(temp_city,a->sale1.vil1.address1.city);
        strcpy(a->sale1.vil1.address1.city,b->sale1.apart1.address1.city);
        strcpy(b->sale1.apart1.address1.city,temp_city);
        char temp_street[200];
         strcpy(temp_street,a->sale1.vil1.address1.street);
        strcpy(a->sale1.vil1.address1.street,b->sale1.apart1.address1.street);
        strcpy(b->sale1.apart1.address1.street,temp_street);
        char temp_alley[200];
         strcpy(temp_alley,a->sale1.vil1.address1.alley);
        strcpy(a->sale1.vil1.address1.alley,b->sale1.apart1.address1.alley);
        strcpy(b->sale1.apart1.address1.alley,temp_alley);
        swap_long_int(&a->sale1.commission,&b->sale1.commission);
        char temp_condition[200];
        strcpy(temp_condition,a->sale1.conditionsOFsale);
        strcpy(a->sale1.conditionsOFsale,b->sale1.conditionsOFsale);
        strcpy(b->sale1.conditionsOFsale,temp_condition);
    }
    
    
    
}
void searchBYstreet(char street[200])
{
    
    struct node* temp;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return ;
    }
	 temp = start;
     while (temp!=NULL)
     {
         if (strcmp(temp->sale1.type_home,"villa")==0)
         {
             if (strcmp(temp->sale1.vil1.address1.street,street)==0)
             {
                printf("the informations of villa: \n");
                printf("1.the area of construction: %lf \n",temp->sale1.vil1.areaOFcunstruction);
                printf("2.the area of yard is : %lf \n",temp->sale1.vil1.areaOFyard);
                printf("3.the basic price of villa: %lf \n",temp->sale1.vil1.basic_price);
                printf("4.the number of floors in villa: %d \n",temp->sale1.vil1.numberOFfloors);
                printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.vil1.address1.city,temp->sale1.vil1.address1.street,temp->sale1.vil1.address1.alley,temp->sale1.vil1.address1.code_posti);
                printf("6.the Whole price of villa: %lf \n",temp->sale1.vil1.whole_price);
                printf("7.the commission: %ld \n",temp->sale1.commission);
                printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
                printf("\t\t\t####################################\n\n");
                temp=temp->next;
             }

              else
                {
                    temp=temp->next;
                }
         }
          else 
          {
              if (strcmp(temp->sale1.apart1.address1.street,street)==0)
              {
                printf("the information of apartment: \n");
                printf("1.the area of construction: %lf \n",temp->sale1.apart1.areaOFcunstruction);
                printf("2.the basic price of apartment: %lf \n",temp->sale1.apart1.basic_price);
                printf("3.the number of floor in apartment: %d \n",temp->sale1.apart1.numberOFfloor);
                printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.apart1.address1.city,temp->sale1.apart1.address1.street,temp->sale1.apart1.address1.alley,temp->sale1.apart1.address1.code_posti);
                printf("6.the Whole price of apartment: %lf \n",temp->sale1.apart1.whole_price);
                printf("7.the commission: %ld \n",temp->sale1.commission);
                printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
                printf("\t\t\t####################################\n\n");
                temp=temp->next;
              }
              else
              {
                  temp=temp->next;
              }
          }
     }
}
void searchBYpriceANDarea(double area,double price)
{

    
    struct node* temp;
    temp=(struct node*)malloc(sizeof(struct node));
    if(temp==NULL)
    {
        printf("out of memory\n");
        return ;
    }
	 temp = start;
     while (temp!=NULL)
     {
          if (strcmp(temp->sale1.type_home,"villa")==0)
         {
            if (temp->sale1.vil1.basic_price<price && temp->sale1.vil1.areaOFcunstruction > area)
             {
                printf("the informations of villa: \n");
                printf("1.the area of construction: %lf \n",temp->sale1.vil1.areaOFcunstruction);
                printf("2.the area of yard is : %lf \n",temp->sale1.vil1.areaOFyard);
                printf("3.the basic price of villa: %lf \n",temp->sale1.vil1.basic_price);
                printf("4.the number of floors in villa: %d \n",temp->sale1.vil1.numberOFfloors);
                printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.vil1.address1.city,temp->sale1.vil1.address1.street,temp->sale1.vil1.address1.alley,temp->sale1.vil1.address1.code_posti);
                printf("6.the Whole price of villa: %lf \n",temp->sale1.vil1.whole_price);
                printf("7.the commission: %ld \n",temp->sale1.commission);
                printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
                printf("\t\t\t####################################\n\n");
                temp=temp->next;
             }
            else        
                {
                    temp=temp->next;
                }
             
         }
         else
         {
             if (temp->sale1.apart1.basic_price<price && temp->sale1.apart1.areaOFcunstruction > area)
             {
                    printf("the information of apartment: \n");
                    printf("1.the area of construction: %lf \n",temp->sale1.apart1.areaOFcunstruction);
                    printf("2.the basic price of apartment: %lf \n",temp->sale1.apart1.basic_price);
                    printf("3.the number of floor in apartment: %d \n",temp->sale1.apart1.numberOFfloor);
                    printf("5.address:\nCity: %s# Street: %s # Allay: %s # PostCode: %ld \n",temp->sale1.apart1.address1.city,temp->sale1.apart1.address1.street,temp->sale1.apart1.address1.alley,temp->sale1.apart1.address1.code_posti);
                    printf("6.the Whole price of apartment: %lf \n",temp->sale1.apart1.whole_price);
                    printf("7.the commission: %ld \n",temp->sale1.commission);
                    printf("8.the conditions of sale: %s \n\n",temp->sale1.conditionsOFsale);
                    printf("\t\t\t####################################\n\n");
                    temp=temp->next;
             }
             else
             {
                 temp=temp->next;
             }
             
             
         }
         
         
     }
     
}

void view_by_price()
{
    node*temp;
    node* temp2;
    temp=(struct node*)malloc(sizeof(struct node));
    temp2=(struct node*)malloc(sizeof(struct node));
    for (temp=start;temp->next!=NULL;temp=temp->next)
    {
        for(temp2=temp->next;temp2!=NULL;temp2=temp2->next)
        {
            if (temp->sale1.whole_price>temp2->sale1.whole_price)
            {
                swap(temp,temp2);
            }
            
        }
    }
    view_info();
} 
void swap_int(int *a, int *b)
{
    int temp=*a;
    *a=*b;
    *b=temp;
}
void swap_double(double *a , double* b)
{
    double temp=*a;
    *a=*b;
    *b=temp;
}
void swap_long_int(long int*a , long int* b)
{
    long int temp=*a;
    *a=*b;
    *b=temp;
}
