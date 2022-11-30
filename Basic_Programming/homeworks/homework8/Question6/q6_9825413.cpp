#include <stdio.h>
int main()
{
long long  int n=3,i,j,k=0,m=3,z,sum=0,e,p,i1;
long long  int f[100][100];
 long long  int g[100][100];
long long int h[100][100];
  for(i=0;i<6;i++)
  {
    for(j=0;j<6;j++)
    {
      scanf("%lld",&f[i][j]);
    }
  }
    for(i=0;i<3;i++)
  {
    for(j=0;j<3;j++)
    {
      scanf("%lld",&g[i][j]);
    }
  }
  e=0,k=0,n=3;
  while(e<5 && k<5 && n<8) 
  {   sum=0;
  	          for(i=0;i<3;i++)
       { 
    for(j=k,p=0;j<n,p<3;j++,p++)
    { 
     sum+=f[i][j]*g[i][p];
    }
    
    } 
    h[0][e]=sum;
    e++;
    k++;
    n++;
  }
    e=0,k=0,n=3;
  while(e<5 && k<5 && n<8) 
  {   sum=0;
  	          for(i=1,i1=0;i<4,i1<3;i++,i1++)
       { 
    for(j=k,p=0;j<n,p<3;j++,p++)
    { 
     sum+=f[i][j]*g[i1][p];
    }
    
    } 
    h[1][e]=sum;
    e++;
    k++;
    n++;
  }
     e=0,k=0,n=3;
  while(e<5 && k<5 && n<8) 
  {   sum=0;
  	          for(i1=0,i=2;i<5,i1<3;i++,i1++)
       { 
    for(j=k,p=0;j<n,p<3;j++,p++)
    { 
     sum+=f[i][j]*g[i1][p];
    }
    
    } 
    h[2][e]=sum;
    e++;
    k++;
    n++;
  }
      e=0,k=0,n=3;
  while(e<5 && k<5 && n<8) 
  {   sum=0;
  	          for(i1=0,i=3;i<6,i1<3;i++,i1++)
       { 
    for(j=k,p=0;j<n,p<3;j++,p++)
    { 
     sum+=f[i][j]*g[i1][p];
    }
    
    } 
    h[3][e]=sum;
    e++;
    k++;
    n++;
  }
    for(i=0;i<4;i++)
  {
    for(j=0;j<4;j++)
    {
      printf("%d ",h[i][j]);
    }
    printf("\n");
  }

  return 0;
}
