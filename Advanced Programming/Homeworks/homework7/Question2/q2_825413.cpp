#include <iostream>
#include <map>
using namespace std;
class Cache{

   protected: 
   //data structure
   int cp;  //capacity
   virtual void set(int, int) = 0; //set function
   virtual int get(int) = 0; //get function

};
class Queue
{
private:
    int arr[80];
    int front=0,rear=0;
public:
    int cntr=0;
    void setNUM(int num){arr[cntr]=num;}
    int getNUM(int counter){return arr[counter-1];}
    void addTOarr(int data){arr[cntr]=data;cntr++;}
    void Rear(){rear++;}
    void shiftTOfirst(int data)
    {
        int *tmp=new int[cntr];
        for(int i=0 ; i<cntr ; i++)
            tmp[i]=this->arr[i];
        for(int i=0 ; i < cntr-1 ;i++)
           arr[i]=tmp[i+1];
        arr[cntr-1]=data;
        delete tmp; 
    }
};
class KEY
{
private:
    int key,value;
public:
    void setKEY(int _key){key=_key;}
    void setVAL(int _val){value=_val;}
    int get_key(){return key;}
    int get_val(){ return value; }
};
class LRU:public Cache
{
map<int , KEY> Map;
Queue qmap;
public:
    LRU(int );
    void set(int a,int b);
    int get(int data);
};

LRU::LRU(int CAPACITY)
{
    cp=CAPACITY;
    Map = map<int ,KEY>();
    
}
void LRU::set(int a, int b)
{
    map<int , KEY>::iterator i;
    if (Map.find(a)!=Map.end())
    {
        Map[a].setVAL(b);
        qmap.shiftTOfirst(a);

    }
    if (cp <= qmap.cntr)
    {
        int DATA;
        Map[a].setVAL(b);
        DATA=qmap.getNUM(1);
        Map.erase(DATA);
        qmap.shiftTOfirst(a);
    }
    else
    {
        Map[a].setVAL(b);
        qmap.addTOarr(a);
        qmap.Rear();
    }
}
int LRU::get(int data)
{
    if (Map.find(data)==Map.end()) return -1;
    int val=Map[data].get_val();
    qmap.shiftTOfirst(data);
    return val;
}

int main()
{
    int numberOFcommands,capacity;
    int a,b,data;
    string input;
    cin>>numberOFcommands>>capacity;
    int answers[50],num_answers=0;
    LRU object_lru(capacity);
    for (int i = 0; i < numberOFcommands; i++)
    {
        cin>>input;
             if(input=="set")
            {
                cin>>a>>b;
                object_lru.set(a,b);
            }
            if(input=="get")
            {
                cin>>data;
               answers[num_answers]= object_lru.get(data);
               num_answers++;
            }
    }
    for (int i = 0; i < num_answers; i++)
        cout<<answers[i]<<endl;
    
    return 0;
}