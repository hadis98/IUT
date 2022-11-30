#include <stdio.h>
int main ()
{
	int x,y;
	scanf("%d%d",&x,&y);
	if(x==y||x==y+2)
        {   
        	printf("%d",x+y-(x%2));
        	
		}
		
		else 
		printf("-1");
		
	return 0;	
		
}

