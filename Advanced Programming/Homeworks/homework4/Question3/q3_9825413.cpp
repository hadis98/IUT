#include <iostream>
using namespace std;
#include <cstring>
void creat_int_vec();
void creat_float_vec();
void creat_stirng_vec();
template <class T>
class vector
{
private:
    T *array;
     int size_array;

public:
    vector();
    vector( const vector &old);
    ~vector();
    void push_back(T data);
    void push_front(T data);
    void insert(int index, T data);
    void pop();
    void Delete(int index);
    int search(T data);
    int size();
    void print();
};
template <class T>
vector<T>::vector(/* args */)
{
   // array=new T[200];
    size_array=0;
   array= new T[size_array];
}
template <class T>
vector<T>::vector( const vector &old)
{
array = new T[size_array];
size_array=old.size_array;
for (int i = 0; i < size_array; i++)
{
    array[i]=old.array[i];
}
}
template <class T>
vector<T>::~vector()
{
    delete [] array;
}
template <class T>
int vector<T>::size()
{
   return size_array;
}
template <class T>
void vector<T>::insert(int index, T data)
{
        if (index<size_array && index>=0)
    {
        
            T * tmp = new T[size_array+1];

        for (int i = 0; i < size_array; i++)
        {
            tmp[i] = array[i];
        }
        delete [] array;
        for (int i = size_array; i >=index; i--)
            tmp[i]=tmp[i-1];
        tmp[index]=data;
        size_array++;
        array=tmp;
    }
    else
        cout<<"index is incorrect:(\n";

}
template <class T>
void vector<T>::push_back(T data)
{
    T * tmp = new T[size_array+1];
            for (int i = 0; i < size_array; i++)
        {
            tmp[i] = array[i];
        }
        delete [] array;
    tmp[size_array]=data;
    size_array++;

    array=tmp;
}
template <class T>
void vector<T>::push_front(T data)
{
    T * tmp = new T[size_array+1];
            for (int i = 0; i < size_array; i++)
        {
            tmp[i] = array[i];
        }
        delete [] array;
    for (int i = size_array; i >=1; i--)
        tmp[i]=tmp[i-1];
    tmp[0]=data;
    size_array++;
    array=tmp;
}
template <class T>
void vector<T>::Delete(int index)
{
     if(size_array==0)
        cout<<"vector is empty\n";
    else
    {
        
    if (index<size_array && index>=0)
    {
        for (int i = index; i < size_array-1; i++)
        {
            array[i]=array[i+1];
        }
        size_array--;
    }
    else
        cout<<"index is incorrect:(\n";
    
    }
    
}
template <class T>
int vector<T>::search(T data)
{
    for (int i = 0; i < size_array; i++)
    {
        if (array[i]==data)
            return i;   
    }
    return -1;
}
template <class T>
void vector<T>::pop()
{
    if(size_array==0)
        cout<<"vector is empty\n";
    else
        size_array--;
}
template <class T>
void vector<T>::print()
{
    if(size_array==0)
        cout<<"vector is empty\n";
    else
    {
        for (int i = 0; i < size_array; i++)
            cout<<array[i]<<" ";
        cout<<endl;
    }
    
}
int main()
{

   while (1)
   {
       cout<<"************** enter your choice:) ************\n";
       cout<<"1.create a int vector\n";
       cout<<"2.create a float vector\n";
       cout<<"3.create a string vector\n";
       cout<<"4.exit\n";
       int n;
       cin>>n;
       switch (n)
       {
       case 1:
           creat_int_vec();
           break;
       case 2:
            creat_float_vec();
            break;
        case 3:
            creat_stirng_vec();
            break;
        case 4:
            return 0;
       default:
           break;
       }
   }

 /*to see the use of copy constructor comment (up codes) and use below codes*/
 /*
     vector<int> vec1;
    vec1.push_back(12);
    vec1.push_front(13);
    vec1.push_front(1);
    vec1.push_front(8);
    vec1.print();
    vector <int>vec2=vec1;
    vec2.print();
    vec2.push_back(23);
    vec2.print();
    vec1.print();
    vector<string> ve;
    ve.push_back("hadis");
    ve.push_front("ghafouri");
    ve.print();
    vector<string> ve2=ve;
    ve2.insert(1,"hello");
    ve2.print();
    ve.print();
      vector<float> vect;
    vect.push_back(3.4);
    vect.push_front(7.7);
    vect.insert(1,9.2);  
    vect.print();
    vector<float> vect2=vect;
    vect2.push_back(2.3);
    vect2.print();
    vect.print();
    */
    return 0;
}
void creat_int_vec()
{
    vector <int> vec;
    while (1)
    {
         cout<<"************** enter your choice:) **************\n";
        cout<<"1.call push_back function\n";
        cout<<"2.call push_front function\n";
        cout<<"3.call insert function\n";
        cout<<"4.call pop function\n";
        cout<<"5.call Delete function\n";
        cout<<"6.call search function\n";
        cout<<"7.call size function\n";
        cout<<"8.print vector\n";
        cout<<"9.exit from integers\n";
        int choice;
        cin>>choice;
        switch (choice)
        {
        case 1:
            cout<<"enter data:";
            int data;
            cin>>data;
            vec.push_back(data);
            break;
        case 2:
             cout<<"enter data:";
            cin>>data;
            vec.push_front(data);
            break;
        case 3:
            int index;
            cout<<"enter index: ";
            cin>>index;
            cout<<"enter data: ";
            cin>>data;
            vec.insert(index,data);
            break;
        case 4:
            vec.pop();
            break;
        case 5:
            cout<<"enter index: ";
            cin>>index;  
            vec.Delete(index);
            break;
        case 6:
            cout<<"enter data: ";
            cin>>data;
            if(vec.search(data)>=0)
                cout<<data<<"  found in  "<<vec.search(data)<<"  index"<<endl;
            else 
                cout<<"data not found:(\n";
            break;
        case 7:
            cout<<"the size of vector is "<<vec.size()<<endl;
            break;
        case 8:
            vec.print();
            break;
        case 9:
            return;
        default:
            cout<<"*********enter a correct choice*************\n";
            break;
        }
    }
    

}
void creat_float_vec()
{
        vector <float> vec;
    while (1)
    {
         cout<<"************** enter your choice:) **************\n";
        cout<<"1.call push_back function\n";
        cout<<"2.call push_front function\n";
        cout<<"3.call insert function\n";
        cout<<"4.call pop function\n";
        cout<<"5.call Delete function\n";
        cout<<"6.call search function\n";
        cout<<"7.call size function\n";
        cout<<"8.print vector\n";
        cout<<"9.exit from floats\n";
        int choice;
        cin>>choice;
        switch (choice)
        {
        case 1:
            cout<<"enter data:";
            float data;
            cin>>data;
            vec.push_back(data);
            break;
        case 2:
             cout<<"enter data:";
            cin>>data;
            vec.push_front(data);
            break;
        case 3:
            int index;
            cout<<"enter index: ";
            cin>>index;
            cout<<"enter data: ";
            cin>>data;
            vec.insert(index,data);
            break;
        case 4:
            vec.pop();
            break;
        case 5:
            cout<<"enter index: ";
            cin>>index;  
            vec.Delete(index);
            break;
        case 6:
            cout<<"enter data: ";
            cin>>data;
            if(vec.search(data)>=0)
                cout<<data<<"  found in  "<<vec.search(data)<<"  index"<<endl;
            else 
                cout<<"data not found:(\n";
            break;
        case 7:
            cout<<"the size of vector is "<<vec.size()<<endl;
            break;
        case 8:
            vec.print();
            break;
        case 9:
            return ;
        default:
            cout<<"*********enter a correct choice*************\n";
            break;
        }
    }
    
}
void creat_stirng_vec()
{
        vector <string> vec;
    while (1)
    {
         cout<<"************** enter your choice:) **************\n";
        cout<<"1.call push_back function\n";
        cout<<"2.call push_front function\n";
        cout<<"3.call insert function\n";
        cout<<"4.call pop function\n";
        cout<<"5.call Delete function\n";
        cout<<"6.call search function\n";
        cout<<"7.call size function\n";
        cout<<"8.print vector\n";
        cout<<"9.exit from strings\n";
        int choice;
        cin>>choice;
        switch (choice)
        {
        case 1:
            {
                cout<<"enter data:";
                string data;
                cin>>data;
                vec.push_back(data);
                break;
            }

        case 2:
               {
                   string data;
                    cout<<"enter data:";
                    cin>>data;
                    vec.push_front(data);
                    break;
               } 
        case 3:
                {
                    string data;
                     int index;
                    cout<<"enter index: ";
                    cin>>index;
                    cout<<"enter data: ";
                    cin>>data;
                    vec.insert(index,data);
                    break;
                }

        case 4:
        {
            int index;
            vec.pop();
            break;
        case 5:
            cout<<"enter index: ";
            cin>>index;  
            vec.Delete(index);
            break;
        }
        case 6:
        {
            string data;
            cout<<"enter data: ";
            cin>>data;
            if(vec.search(data)>=0)
                cout<<data<<"  found in  "<<vec.search(data)<<"  index"<<endl;
            else 
                cout<<"data not found:(\n";
            break;
        }
        case 7:
            cout<<"the size of vector is "<<vec.size()<<endl;
            break;
        case 8:
            vec.print();
            break;
        case 9:
            return ;
        default:
            cout<<"*********enter a correct choice*************\n";
            break;
        }
    }
}