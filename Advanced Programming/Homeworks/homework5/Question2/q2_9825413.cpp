#include <iostream>
using namespace std;
class polynomial
{
private:
    int  coef[21];
    string str;
public:
    polynomial();
    polynomial(const polynomial &);//copy constructor
    friend istream & operator>>(istream &in , polynomial &po);//cin 
    friend ostream & operator<<(ostream &out,const polynomial  &po);//cout
    polynomial operator+(const polynomial po);//***** po1+po2
    polynomial operator-(const polynomial po);//***** po1-po2
    polynomial operator*(const polynomial po);//***** po1*po2 //$$$$
    polynomial operator-(const int);//***** po - int
    polynomial operator+(const int);//***** po + int
    polynomial operator*(const int);//***** po * int
    friend polynomial operator+(const int , const polynomial);//***** int + po
    friend polynomial operator-(const int ,const polynomial);//***** int - po
    friend polynomial operator*(const int ,const polynomial);//***** int * po
    friend polynomial operator-(const polynomial po);//****** -po 

};

polynomial::polynomial(/* args */)
{
    for (int i = 0; i < 21; i++)
    {
        coef[i]=0;
    }
}
polynomial::polynomial(const polynomial &obj)
{
    
    for (int i = 0; i < 21; i++)
    {
        this->coef[i]=obj.coef[i];
    }
    
}
istream & operator>>(istream &in , polynomial &po)
{
    in>>po.str;
    int i = 0;
    for(;i<po.str.length();i++)
{
        if(po.str[i]=='+')//*********************** + ***********************
        {
            if(po.str[i+1]=='x')
            { 
            string answer;
               i++;
                if(po.str[i+1]=='^')
                { 
                     i++;
                    while (po.str[i+1]>='0' && po.str[i+1]<='9')
                    {
                       answer+=po.str[i+1];//*********** answer
                      i++;
                    }
                    po.coef[stoi(answer)]=1;
                }
                else
                    po.coef[1]=1;
            }
            else
            {
                string answer,answer2;
            while (po.str[i+1]>='0' && po.str[i+1]<='9')
            {
                answer+=po.str[i+1];//********** answer
                i++;
            }
           
            if(po.str[i+1]=='x')
            { i++;
                if(po.str[i+1]=='^')//3
                { i++; 
                      while (po.str[i+1]>='0' && po.str[i+1]<='9')
                    {
                        answer2+=po.str[i+1];
                        i++;
                    }
                    po.coef[stoi(answer2)]=stoi(answer);
                }
                else
                    po.coef[1]=stoi(answer);
                
            }
            else
                po.coef[0]=stoi(answer);

            }
        }
        else if(po.str[i]=='-')//************** - ***************
        {
             if(po.str[i+1]=='x')
            {     string answer;
               i++;
                if(po.str[i+1]=='^')
                { cout<<i<<endl;
                     i++; 
                    while (po.str[i+1]>='0' && po.str[i+1]<='9')
                    {
                        cout<<i<<endl;
                       answer+=po.str[i+1];//*********** answer
                      i++;
                        cout<<i<<endl;
                    }
                    po.coef[stoi(answer)]=-1;
                    cout<<i<<endl;
                }
                else
                    po.coef[1]=-1;
            }
            else
            {

               string answer,answer2;
            while (po.str[i+1]>='0' && po.str[i+1]<='9')
            {
                answer+=po.str[i+1];//********* answer
                i++;
            }
            if(po.str[i+1]=='x')
            { i++;
                if(po.str[i+1]=='^')//3
                { i++; 
                      while (po.str[i+1]>='0' && po.str[i+1]<='9')
                    {
                        answer2+=po.str[i+1];//*********** answer2
                        i++;
                    }
                    po.coef[stoi(answer2)]=-stoi(answer);
                }
                else
                    po.coef[1]=-stoi(answer);
            }
            else
                po.coef[0]=-stoi(answer);
            }
        }
}
 return in;   
}
ostream& operator<<(ostream& out ,const polynomial &po )
{
    for (int i = 20; i >=0; i--)
    {
        if(po.coef[i])//***** if coef!=0
        {
            if (i==0)//tavan ==0
            {
                po.coef[i]>0? out<<"+"<<po.coef[i]: out<<po.coef[i];
            }
            else if (i==1)//tavan==1
            {
              if (po.coef[i]==1 || po.coef[i]==-1)
                    po.coef[i]>0? out<<"+"<<"x" : out<<"-"<<"x";
              else 
                    po.coef[i]>0? out<<"+"<<po.coef[i]<<"x" : out<<po.coef[i]<<"x";
              
            }
            else //tavan>1
            {
                if (po.coef[i]==1 || po.coef[i]==-1)
                    po.coef[i]>0 ? out<<"+"<<"x"<<"^"<<i : out<<"-"<<"x"<<"^"<<i;
                else 
                    po.coef[i]>0 ? out<<"+"<<po.coef[i]<<"x"<<"^"<<i : out<<po.coef[i]<<"x"<<"^"<<i;
            }
            
        }
    }
   return out; 
}
polynomial  polynomial::operator+(const polynomial po)
{
  polynomial answer;
  for (int i = 0; i < 21; i++)
  {
      answer.coef[i]=this->coef[i]+po.coef[i];
  }
  return answer;
}
polynomial  polynomial::operator-(const polynomial po)
{
  polynomial answer;
  for (int i = 0; i < 21; i++)
  {
      answer.coef[i]=this->coef[i]-po.coef[i];
  }
  return answer;
}

polynomial  polynomial::operator*(const polynomial po)
{
    polynomial answer;
for (int i = 0; i < 21; i++)
{
    for (int j = 0; j < 21; j++)
    {
        answer.coef[i+j]+=this->coef[i]*po.coef[j];
    }
    
}
return answer;
}
polynomial polynomial::operator*(const int x)
{
    polynomial answer;
    for (int i = 0; i < 21; i++)
    {
        answer.coef[i]=this->coef[i]*x;
    }
    return answer;
}
polynomial polynomial::operator-(const int x)
{
    polynomial answer=*this;
    answer.coef[0]-=x;
    return answer;
}
polynomial polynomial::operator+(const int x)
{
    polynomial answer=*this;
    answer.coef[0]+=x;
    return answer;
}
polynomial operator+(const int x, const polynomial po)
{
    polynomial answer=po;
    answer.coef[0]+=x;
    return answer;
}
polynomial operator-(const int x, const polynomial po)
{
    polynomial answer=po;
    for (int i = 0; i < 20; i++)
    {
        answer.coef[i]=-answer.coef[i];
    }
    answer.coef[0]+=x;
    return answer;
}
polynomial operator*(const int x, const polynomial po)
{
    polynomial answer=po;
    for (int i = 0; i < 21; i++)
    {
        answer.coef[i]=po.coef[i]*x;
    }
    return answer;
}
polynomial operator-(const polynomial po)// true
{
    polynomial answer=po;
    for (int i = 0; i < 21; i++)
    {
        answer.coef[i]=po.coef[i]*-1;
    }
    return answer;
}
int main()
{
polynomial p1,p2,p5;
cin>>p1>>p2;
cout<<p1<<endl;
cout<<p2<<endl;
polynomial p3=-p1;
polynomial p4=-p2;
cout<<"p3=-p1    "<<p3<<endl;
cout<<"p4=-p2    "<<p4<<endl;
cout<<"p1+p2= "<<p1+p2<<endl;
cout<<"p1 * p2= "<<p1*p2<<endl;
p5=2-p1;
cout<<"p5=   "<<p5<<endl;
cout<<"p1-p2= "<<p1-p2<<endl;
cout<<"2-p1= "<<2-p1<<endl;
cout<<"2+p1= "<<2+p1<<endl;
cout<<"2*p1= "<<2*p1<<endl;
cout<<"p2 * 3=   "<<p2*3<<endl;
cout<<"p2 + 2=   "<<p2+2<<endl;
cout<<"p2 - 2=   "<<p2-2<<endl;
polynomial po2(p1);//******* use copy constructor
cout<<"po2= "<<po2<<endl;
cout<<p1<<endl;
p1=p1+4;
cout<<"po2= "<<po2<<endl;
cout<<p1<<endl;
    return 0;
}