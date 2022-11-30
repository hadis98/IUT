#include <stdio.h>
union unionJob
{
   //defining a union
   char name[32];
   float salary;
   int workerNo;
} uJob;

struct structJob
{
   char name[32];
   float salary;
   int workerNo;
} sJob;

int main()
{
   printf("size of union = %d", sizeof(uJob));
   printf("\nsize of structure = %d", sizeof(sJob));
   return 0;
}


size of union = 32
size of structure = 40

src:

https://www.programiz.com/c-programming/c-unions


Usual applications:

struct Connection
{
    int type;
    union
    {
        struct Telnet telnet;
        struct SSH ssh;
        struct Web http;
    }
}my_connection;



switch (my_connection.type)
{
   case 0  :  /* access my_connection.telnet;*/ break;
   case 1:  /* access my_connection.ssh;*/ break;
   case 2:  /* access my_connection.http;*/ break;
}


int main(){
	my_connection.type=0;
   my_connection.telnet=kflgsfd;

}

//Sample with enum
enum Type { INTS, FLOATS, DOUBLE };
struct S
{
  Type s_type;
  union
  {
    int s_ints[2];
    float s_floats[2];
    double s_double;
  };
};

void do_something(struct S *s)
{
  switch(s->s_type)
  {
    case INTS:  // do something with s->s_ints
      break;

    case FLOATS:  // do something with s->s_floats
      break;

    case DOUBLE:  // do something with s->s_double
      break;
  }
}
