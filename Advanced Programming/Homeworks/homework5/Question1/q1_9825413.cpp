#include <iostream>
using namespace std;
class Date
{
    int day;
    int month;
    int year;
public:
    Date(int ,int , int);
    Date();
    Date operator+(const Date );
    Date operator-(const Date );
    string To_string(string);
    bool operator==(const Date );
    bool operator<(const Date );
    bool operator>=(const Date );
    int get_day(){return day;}
    int get_month(){return month;}
    int get_year(){return year;}
   
};

Date::Date(int d,int m,int y)
{
    year=y,month=m,day=d;
    /*
    month=(m>0 && m<13)? m : 0;
    day=(d>0 && d<31)? d: 0;*/
    if(day>30) //********** if day>30 
    {
        month+=day/30;
        day=day%30;
        if(day==0) day=1;//********* if day==0 >>> day=1
    }
    else if(day<0) day=0;//********** if day<0 >>> day=0
    else day=d;
    if(month>12)//*********** if moth>12 
    {
        year+=month/12;
        month=month%12;
        if(month==0) month=1;
    }
    else if(month<0) month=0;
    else month=m;

}
Date::Date()
{

}
Date Date::operator+(const Date obj)
{
    return Date(this->day+obj.day,this->month+obj.month,this->year+obj.year);
}

Date Date::operator-(const Date obj)
{
    return Date(this->day-obj.day,this->month-obj.month,this->year-obj.year);
}
string Date::To_string(string str)
{
    string ans;
    for (int i = 0; i < str.length(); i++)
    {
        if(str[i]=='d')
            ans.append(to_string(this->day));
        else if(str[i]=='m')
            ans.append(to_string(this->month));
        else if(str[i]=='Y')
            ans.append(to_string(this->year));
        else if(str[i]=='y')
        {
            int y2=this->year%100;
            ans.append(to_string(y2));
        }
        else
        {
            ans+=((str[i]));
        }
        
    }
    return ans;
    
}
bool Date::operator==(const Date obj)
{
    return (obj.year==this->year && obj.month==this->month && obj.day==this->day) ? true : false;
}
bool Date::operator<(const Date obj)
{
    if(obj.year>year) return true ;
    else if(obj.year<year) return false;
    else
    {
        if(obj.month> month) return true;
        else if(obj.month < month) return false;
        else
        {
            if(obj.day> day) return true;
            else if(obj.day < day) return false;
        }
    }
    return false;
}
bool Date::operator>=(const Date obj)
{
    if (year>obj.year)   return true;
    else if(year<obj.year) return false;
    else
    {
        if(month>obj.month) return true;
        else if(month < obj.month) return false;
        else
        {
           if(day>obj.day) return true;
           else if(day < obj.day) return false;
           else 
           return true;
        }
        
    }
}
class Time
{
private:
    int hour;
    int minute;
    int second;
public:
    Time(int , int , int);
    Time();
    string To_string(string);
    bool operator==(const Time );
    bool operator<(const Time );
    bool operator>=(const Time );
     Time operator+(const Time );
    Time operator-(const Time );
    int get_hour(){return hour;}
    int get_minute(){return minute;}
    int get_second(){return second;}

};
Time::Time()
{

}
Time::Time(int h, int m , int s)
{
    hour=h,minute=m,second=s;
    /*
	hour = (h >= 0 && h < 24) ? h : 0;
	minute = (m >= 0 && m < 60) ? m : 0;
	second = (s >= 0 && s < 60) ? s : 0;
    */
	hour = (h >= 0 && h < 24) ? h : 0;
    if(second>60) 
    {
        minute+=second/60;
        second=second%60;
    }
    else if(second<0) second=0;
    else second=s;
    if(minute>60)
    {
        hour+=minute/60;
        minute=minute%60;
    }
    else if(minute<0) minute=0;
    else minute=m;
}
string Time::To_string(string str)
{
string ans;
for (int i = 0; i < str.length(); i++)
{
    if(str[i]=='H')
        ans.append(to_string(hour));
   else if(str[i]=='h')
    {
        if(hour==0 || hour==12) 
        {
            int h2=12;
            ans.append(to_string(h2));
        }
        else
        {
            int h2=hour%12;
            ans.append(to_string(h2));
        }
        
    }
    else if(str[i]=='i') 
        ans.append(to_string(minute));
    else if(str[i]=='s')
        ans.append(to_string(second));
    else if(str[i]=='a')
    {
        if(hour>=0 && hour <12)
            ans.append("a.m.");
        else
            ans.append("p.m.");
        
    }
    else
       ans+=((str[i]));
    
    

}
return ans;
}
Time Time::operator+(const Time obj)//********* + *********
{
    return Time(this->hour+obj.hour,this->minute+obj.minute,this->second+obj.second);
}
Time Time::operator-(const Time obj)//********** - **********
{
    return Time(this->hour-obj.hour,this->minute-obj.minute,this->second-obj.second);
}

bool Time::operator==(const Time obj)//*********** == ***********
{
    return (obj.hour==this->hour && obj.minute==this->minute && obj.second==this->second) ? true : false;
}
bool Time::operator<(const Time obj)//************ < *************
{
    if(obj.hour>hour) return true ;
    else if(obj.hour<hour) return false;
    else
    {
        if(obj.minute> minute) return true;
        else if(obj.minute < minute) return false;
        else
        {
            if(obj.second> second) return true;
            else if(obj.second <second) 
                return false;
        } 

    }
    return false;
}
bool Time::operator>=(const Time obj)//************** >= *********
{
    if (hour>obj.hour)   return true;
    else if(hour<obj.hour) return false;
    else
    {
        if(minute>obj.minute) return true;
        else if(minute < obj.minute) return false;
        else
        {
           if(second>obj.second) return true;
           else if(second < obj.second) return false;
           else 
           return true;
        }
        
    }
}
class TimeStamp
{
Time time1;
Date date1;
public:
    TimeStamp(Date , Time);
    string To_string(string );
    bool operator==(const TimeStamp);
    bool operator<(const TimeStamp);
    bool operator>=(const TimeStamp);
    TimeStamp operator+(const TimeStamp);
    TimeStamp operator-(const TimeStamp);

};

TimeStamp::TimeStamp(Date d, Time t)
{   
    time1=t;
    date1=d;
}
TimeStamp TimeStamp::operator+(const TimeStamp  obj)//******** + ***********
{
    return TimeStamp(this->date1+obj.date1,this->time1+obj.time1);
}
TimeStamp TimeStamp::operator-(const TimeStamp  obj)//********** - **********
{
    return TimeStamp(this->date1-obj.date1,this->time1-obj.time1);
}
bool TimeStamp::operator==( TimeStamp  obj)//********** == ***********
{
    return (obj.date1==date1 && obj.time1==time1) ? true : false;
}
bool TimeStamp::operator<( TimeStamp  obj)//********* < ***********
{
    return (date1<obj.date1 && time1<obj.time1) ? true : false;
}
bool TimeStamp::operator>=( TimeStamp  obj)//********* >= **********
{
    return (date1>=obj.date1 && time1>=obj.time1) ? true : false;
}
string TimeStamp::To_string(string str)
{
string ans;
for (int i = 0; i < str.length(); i++)
{
    if(str[i]=='H')
        ans.append(to_string(time1.get_hour()));
   else if(str[i]=='h')
    {
        if(time1.get_hour()==0 || time1.get_hour()==12) 
        {
            int h2=12;
            ans.append(to_string(h2));
        }
        else
        {
            int h2=time1.get_hour()%12;
            ans.append(to_string(h2));
        }
        
    }
    else if(str[i]=='i') 
        ans.append(to_string(time1.get_minute()));
    else if(str[i]=='s')
        ans.append(to_string(time1.get_second()));
    else if(str[i]=='a')
    {
        if(time1.get_hour()>=0 && time1.get_hour() <12)
            ans.append("a.m.");
        else
            ans.append("p.m.");
        
    }
        else if(str[i]=='d')
            ans.append(to_string(date1.get_day()));
        else if(str[i]=='m')
            ans.append(to_string(date1.get_month()));
        else if(str[i]=='Y')
            ans.append(to_string(date1.get_year()));
        else if(str[i]=='y')
        {
            int y2=date1.get_year()%100;
            ans.append(to_string(y2));
        }
    else
        ans+=((str[i]));

}
return ans;
}
int main()
{
    Date d(13,1,1399);
    Date d2(15,3,1396);
    Date d6(15,3,1396);
    Time t(17,10,19);
    Time t2(6,24,13);
    Time t3(6,24,13);
   cout<<d.To_string("Y/m/d")<<endl;
  cout<<d.To_string("y/m/d")<<endl;
  Date d3(40,15,1990);
   cout<<d3.To_string("Y/m/d")<<endl;
  cout<<d3.To_string("y/m/d")<<endl;
  cout<<t.To_string("h:i:s a")<<endl;
  cout<<t.To_string("H:i:s a")<<endl;
    Date d4=d+d2;
   cout<<d4.To_string("Y/m/d")<<endl;
  cout<<d4.To_string("y/m/d")<<endl;
  Date d5=d-d2;
       cout<<d5.To_string("Y/m/d")<<endl;
  cout<<d5.To_string("y/m/d")<<endl;
    if (t2==t3)
    {
        cout<<"yes\n";
    }
    if(d6==d2)
        cout<<"yes\n";
    
    if(d<d2)
        cout<<"d<d2\n";
    else cout<<"d>d2\n";
    if(d2>=d6)
        cout<<"ooopsss\n";
    d+Date(2,34,5);
     cout<<(d+Date(2,1,0)).To_string("y/m/d")<<endl;
   cout<<(t-Time(1,10,20)).To_string("h:i a")<<endl;

 TimeStamp ts(d,t);
 TimeStamp ts2(d2,t2);
 cout<<(ts>=ts2)<<endl;
 cout<<ts.To_string("Y/m/d H:i:s")<<endl;
 cout<<(ts>=TimeStamp(Date(13,1,1399),Time(17,11,20)))<<endl;
 if(t2==Time(2,34,5))
 {
     cout<<"equal\n";
 }
 cout<<(t2==Time(2,34,5))<<endl;
 cout<<(d==Date(12,3,4));
    return 0;
}