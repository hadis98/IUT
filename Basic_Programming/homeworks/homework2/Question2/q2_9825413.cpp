#include <stdio.h>
int main ()
{
	int a,b,c,d,e,f;
	scanf("%d%d",&a,&b);
	scanf("%d%d",&c,&d);
	scanf("%d%d",&e,&f);
	if(a==c&&b==d)
	printf("%d %d",e,f);

	else if(a==c&&b==f)
	printf("%d %d",e,d);


		else if(a==c&&d==f)
	printf("%d %d",e,b);  //


		 else if(a==e&&b==d)
	printf("%d %d",c,f);

	else if(a==e&&b==f)
	printf("%d %d",c,d);

	else if(a==e&&d==f)
	printf("%d %d",c,b);     //
	
    	else if(c==e&&b==f)
	printf("%d %d",a,d);

		else if(c==e&&b==d)
	printf("%d %d",a,f);

		else 
	printf("%d %d",a,b);

return 0;

}

