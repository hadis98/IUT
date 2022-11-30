#include <iostream>
#include <math.h>
#include <iomanip>  
using namespace std;
void sort_arr(float *,int );
class Coordinates
{
private:
    float x, y;
public:
    Coordinates();
    void set_x(float a){x=a;}
    void set_y(float b){y=b;}
    float get_x(){return x;}
    float get_y(){return y;}
};
Coordinates::Coordinates(){}
class shapes
{
protected:
        Coordinates array_coordin[8];
public:
    shapes();
    float get_Environment(int n);
    float get_Area( int);
     void set_coordin(Coordinates [], int);
    void get_Diameters(int);
    void get_Diameters2(int);
};

shapes::shapes()
{
}
void shapes::set_coordin(Coordinates ex[],int n)
{
for (int i = 0; i < n; i++)
    array_coordin[i]=ex[i];
}
float shapes::get_Area(int n)
{
        float area;
     int j=n-1;
    for (int i = 0; i < n; i++)
    {
        area+=(array_coordin[j].get_x()+array_coordin[i].get_x())*(array_coordin[j].get_y()-array_coordin[i].get_y());
        j=i;
    }
    
return abs(area/2.0);
}
float shapes::get_Environment(int n)
{
    float answer=sqrt(pow(array_coordin[0].get_x()-array_coordin[1].get_x() ,2)+(pow(array_coordin[0].get_y()-array_coordin[1].get_y() ,2)));
    return answer*n;
}
void shapes::get_Diameters(int n)
{
float array[n];
for (int i = 0; i < n; i++)
    array[i]=sqrt(pow(array_coordin[0].get_x()-array_coordin[i+2].get_x() ,2)+(pow(array_coordin[0].get_y()-array_coordin[i+2].get_y() ,2)));
sort_arr(array,n);
    for(int i=0 ; i< n;i++)
         cout<<setprecision(2)<<fixed<<array[i]<<" ";  
}
void shapes::get_Diameters2(int n)
{
float array[n];
for (int i = 0; i < n; i++)
    array[i]=sqrt(pow(array_coordin[i].get_x()-array_coordin[i+2].get_x() ,2)+(pow(array_coordin[i].get_y()-array_coordin[i+2].get_y() ,2)));
sort_arr(array,n);
    for(int i=0 ; i< n;i++)
         cout<<setprecision(2)<<fixed<<array[i]<<" ";  
}
//**********************************************************
class Triangle:public shapes         // mosalas
{
    string color;
public:
    Triangle(string);
    Triangle();
    void print_Triangle();
    float get_Environment();    
};
Triangle::Triangle(string str)
{
    color=str;
}
Triangle::Triangle(){}
float Triangle::get_Environment()
{
    float answer=0;
    for (int i = 0; i < 3; i++)
    {
        if(i==2)
            answer+=sqrt(pow(array_coordin[2].get_x()-array_coordin[0].get_x() ,2)+(pow(array_coordin[2].get_y()-array_coordin[0].get_y() ,2)));
        else 
             answer+=sqrt(pow(array_coordin[i].get_x()-array_coordin[i+1].get_x() ,2)+(pow(array_coordin[i].get_y()-array_coordin[i+1].get_y() ,2)));
    }
    return answer;
}
void Triangle::print_Triangle()
{
    cout<<this->color<<" : "<<setprecision(2)<<fixed<<this->get_Environment()<<" "<<setprecision(2)<<this->get_Area(3)<<endl;
}
//**********************************************************
class Rectangle:public shapes //mostatil
{
   string color;
public:
    Rectangle(string);
    Rectangle();
    float get_Environment();
    void print_Rectangle();
};
Rectangle::Rectangle(){}
Rectangle::Rectangle(string str)
{
color=str;
} 
float Rectangle::get_Environment()
{
float size1=sqrt(pow(array_coordin[0].get_x()-array_coordin[1].get_x() ,2)+(pow(array_coordin[0].get_y()-array_coordin[1].get_y() ,2)));
float  size2=sqrt(pow(array_coordin[1].get_x()-array_coordin[2].get_x() ,2)+(pow(array_coordin[1].get_y()-array_coordin[2].get_y() ,2)));
    return (size1+size2)*2;
}
void Rectangle::print_Rectangle()
{
    cout<<this->color<<" : "<<setprecision(2)<<fixed<<this->get_Environment()<<" "<<setprecision(2)<<fixed<<this->get_Area(4)<<" ";
       this->get_Diameters2(2); cout<<endl;
}
//**********************************************************
class Diamond:public shapes    //lozi
{
string color;
public:
    Diamond(string);
    Diamond();
    void print_Diamond();

};
Diamond::Diamond(){}
Diamond::Diamond(string str)
{
    color=str;
}
void Diamond::print_Diamond()
{
  cout<<this->color<<" : "<<setprecision(2)<<fixed<<this->get_Environment(4)<<" "<<setprecision(2)<<fixed<<this->get_Area(4)<<" ";
   this->get_Diameters2(2);
   cout<<endl;
}
//**********************************************************
class Square:public shapes
{
 string color;
public:
    Square(string);
    Square();
     void print_Square();
};

Square::Square(string str)
{
    color=str;
}
Square::Square(){}
void Square::print_Square()
{
    cout<<this->color<<" : "<<setprecision(2)<<fixed<<this->get_Environment(4)<<" "<<setprecision(2)<<fixed<<this->get_Area(4)<<" ";
   this->get_Diameters2(2); cout<<endl;
}
//**********************************************************
class six_sided:public shapes     //6 zeliee
{
   string color;
public:
    six_sided(string);
    six_sided();
     void print_six_sided();
};

six_sided::six_sided(string str)
{
    color=str;
}
six_sided::six_sided(){}
void six_sided::print_six_sided()
{
cout<<color<<" : "<<setprecision(2)<<fixed<<this->get_Environment(6)<<" "<<setprecision(2)<<fixed<<this->get_Area(6)<<" ";
this->get_Diameters(3);
cout<<endl;
}
//**********************************************************
class eight_sided:public shapes       //8 zeliee
{
  string color;
public:
    eight_sided(string);
    eight_sided();
     void print_eight_sided();
};
eight_sided::eight_sided(string str){color=str;}
eight_sided::eight_sided(){}
void eight_sided::print_eight_sided()
{
cout<<color<<" : "<<setprecision(2)<<fixed<<this->get_Environment(8)<<" "<<setprecision(2)<<fixed<<this->get_Area(8)<<" ";
this->get_Diameters(5);
cout<<endl;
}
//**********************************************************
//################ MAIN #################
int main()
{
int n;
int type_shape[100],num_tr=0,num_re=0,num_di=0,num_sq=0,num_six=0,num_eight=0;
int num_tr2=0,num_re2=0,num_di2=0,num_sq2=0,num_six2=0,num_eight2=0;
cin>>n;
string colors[n],empty;
Triangle tr[10];Rectangle re[10]; Diamond di[10]; Square sq[10]; six_sided six[10];eight_sided eight[10];

    for (int j = 0; j < n; j++)
        cin>>type_shape[j];

    for (int i = 0; i < n; i++)
    {
      if (type_shape[i]==1)
       {
         float x[3],y[3];
        Coordinates coord[3];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 3; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        Triangle t(colors[i]);
        tr[num_tr]= t;
        tr[num_tr].set_coordin(coord,3);
        num_tr++;
        }
        else if (type_shape[i]==2)
        {
        float x[4],y[4];
        Coordinates coord[4];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 4; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        Rectangle r(colors[i]);
        re[num_re]=r;
        re[num_re].set_coordin(coord,4);
        num_re++;
        }
        else if (type_shape[i]==3)
        {
        float x[4],y[4];
        Coordinates coord[4];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 4; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        Diamond dia(colors[i]);
        di[num_di]=dia;
        di[num_di].set_coordin(coord,4);
        num_di++;
        }
         else if (type_shape[i]==4)
        {
        float x[4],y[4];
        Coordinates coord[4];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 4; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        Square squ(colors[i]);
        sq[num_sq]=squ;
        sq[num_sq].set_coordin(coord,4);
        num_sq++;
        }
        else if (type_shape[i]==5)
        {
        float x[6],y[6];
        Coordinates coord[6];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 6; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        six_sided si(colors[i]);
        six[num_six]=si;
        six[num_six].set_coordin(coord,6);
        num_six++;
        }
        else if (type_shape[i]==6)
        {
        float x[8],y[8];
        Coordinates coord[8];
        cin>>colors[i];getchar();getchar();
        for (int i = 0; i < 8; i++)
        {
            getchar();cin>>x[i];
            coord[i].set_x(x[i]);
            getchar();cin>>y[i];
            coord[i].set_y(y[i]);
        }
        eight_sided ei(colors[i]);
        eight[num_eight]=ei;
        eight[num_eight].set_coordin(coord,8);
        num_eight++;
        }        
        }
    for (int i = 0; i < n; i++)
    {
        if(type_shape[i]==1)
        {
            tr[num_tr2].print_Triangle();
            num_tr2++;
        }
        else if(type_shape[i]==2)
        {
            re[num_re2].print_Rectangle();
            num_re2++;
        }
        else if(type_shape[i]==3)
        {
            di[num_di2].print_Diamond();
            num_di2++;
        }
        else if(type_shape[i]==4)
        {
            sq[num_sq2].print_Square();
            num_sq2++;
        }
        else if(type_shape[i]==5)
        {
            six[num_six2].print_six_sided();
            num_six2++;
        }
        else {
            eight[num_eight2].print_eight_sided();
            num_eight2++;
        }
    }
    return 0;
}

void sort_arr(float *array,int n)
{
    for (int i = 0; i < n-1; i++)
    {
        for (int j = i+1; j < n; j++)
        {
            if (*(array+i)<*(array+j))
            {
                float temp=*(array+i);
                *(array+i)=*(array+j);
                *(array+j)=temp;
            }   
        }   
    }
}