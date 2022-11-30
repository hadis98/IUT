#include <stdio.h>
#include <string.h>

struct  Rational {
    int a;
    int b;
}c,d;

char c1[10],d1[10];
void get(struct Rational *i);
void print(struct Rational o);
void simplify(struct Rational *q);
struct Rational add(struct Rational q1, struct Rational q2);
struct Rational subtract(struct Rational q1,struct  Rational q2);
struct Rational multiply(struct Rational q1,struct  Rational q2);
struct Rational division(struct Rational q1,struct Rational q2);
int kmm(int f, int g);
int bmm(int f ,int g);

int main()
{
    char s[100];
    int n=0;
   while(1)
   { 
   //fgets(s,100,stdin);
   gets(s);
       if(s[0]=='n') //new character
    {
        if(n==0)
        {    
         strcpy(c1 , &s[4]);
               get(&c);
                n++;
        }
       else if(n==1)
       {
          strcpy(d1 , &s[4]);
            get(&d);
       }
    }
    if(s[1]=='+')  
	{
		if(add(c,d).b<0 && add(c,d).b>0)  printf("-%d/%d\n",add(c,d).a,-add(c,d).b);
		else if(add(c,d).b<0 && add(c,d).b<0) printf("%d/%d\n",-add(c,d).a,-add(c,d).b);
		else printf("%d/%d\n",add(c,d).a,add(c,d).b);
	}
    if(s[1]=='-')
	{
		if(s[0]==c1[0]) 
		{
			if(add(c,d).b<0 && add(c,d).b>0) printf("-%d/%d\n",subtract(c,d).a,-subtract(c,d).b);
			else if(add(c,d).b<0 && add(c,d).b<0) printf("%d/%d\n",-subtract(c,d).a,-subtract(c,d).b);
			else printf("%d/%d\n",subtract(c,d).a,subtract(c,d).b);
		 } 
		 else 
		 {
		 	if(add(d,c).b<0 && add(d,c).b>0) printf("-%d/%d\n",subtract(d,c).a,-subtract(d,c).b);
			else if(add(d,c).b<0 && add(d,c).b<0) printf("%d/%d\n",-subtract(d,c).a,-subtract(d,c).b);
			else printf("%d/%d\n",subtract(d,c).a,subtract(d,c).b);
		 }
	 } 
    if(s[1]=='*') 
      {
      	    if(multiply(c,d).b<0 )
      		printf("-%d/%d\n",multiply(c,d).a,-(multiply(c,d).b));
      		else 
      		printf("%d/%d\n",multiply(c,d).a,(multiply(c,d).b));
       }


    if(s[1]=='/') 
	{
		if(s[0]==c1[0])
		{
			if(division(c,d).b<0) printf("-%d/%d\n",division(c,d).a,-(division(c,d).b));
	               else printf("%d/%d\n",division(c,d).a,division(c,d).b);
		  }  
	 else  
	 {
	 	if(division(d,c).b<0) printf("-%d/%d\n",division(d,c).a,-(division(d,c).b));
	       else printf("%d/%d\n",division(d,c).a,division(d,c).b);
	 	
	 }
		
	}
    if(s[1]=='\0') 
    {
        if (s[0]==c1[0]) print(c);
        else print(d);
    }
      if(strcmp(s,"end")==0) return 0;
      
   }
    
    return 0;
}
void get(struct Rational *i)
{
    int h1,h2;
    scanf("%d%d",&h1,&h2);
    i->a=h1;
    i->b=h2;

}
void print(struct Rational o)
{
	if(o.b<0 && o.a>0)printf("-%d/%d\n",o.a,-o.b);
    else if(o.a<0 && o.b<0) printf("%d/%d\n",-o.a,-o.b);
    else printf("%d/%d\n",o.a,o.b);
}
void simplify(struct Rational *q)
{
  int res=bmm(q->a,q->b);//bmm surat & makhrag
  q->b=q->b / res;
  q->a=q->a / res;
}
int bmm(int f ,int g)
{
    return f%g==0 ?  g :  bmm(g%f,f); 
}
struct Rational add(struct Rational q1, struct Rational q2)// (+)
{
   simplify(&q1);
   simplify(&q2);
   int result=kmm(q1.b,q2.b);
   struct Rational res;
   res.a=(q1.a * (result/q1.b)+q2.a * (result / q2.b));
   res.b=result;
   simplify(&res);
   return res;


}
struct Rational subtract(struct Rational q1,struct  Rational q2) //(-)
{
    simplify(&q1);
   simplify(&q2);
   int result=kmm(q1.b,q2.b);
   struct Rational res;
   res.a=(q1.a * (result/q1.b)-q2.a * (result / q2.b));
   res.b=result;
   simplify(&res);
   return res;
}
struct Rational multiply(struct Rational q1,struct  Rational q2)// (*)
{
   simplify(&q1);
   simplify(&q2);
   struct Rational res;
   res.a=q1.a * q2.a;
   res.b=q1.b * q2.b;
   simplify(&res);
   return res;
}
struct Rational division(struct Rational q1,struct Rational q2)
{
	int temp;
	temp=q2.a;
	q2.a=q2.b;
	q2.b=temp;
  multiply(q1,q2);
}

int kmm(int f, int g)
{
    return (f*g) / bmm(f,g);
}
