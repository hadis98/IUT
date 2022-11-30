#include "linked.h"
linked::linked() {}
linked::~linked() {

    Pair* temp = (Pair*)malloc(sizeof(400));
    Pair* ptr = (Pair*)malloc(sizeof(400));
    temp = head;
    while (temp != NULL)
    {
        ptr = temp;
        temp = temp->next;
        delete ptr;
    }
    head = NULL;
}
/*
void linked::add_data(Pair data)
{
    Pair* newNode = new Pair;
    newNode->next = NULL;
    *newNode = data;

    if (head == NULL)
    {
        head = newNode;
    }
    else
    {
        Pair* temp = head;
        while (temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = newNode;
    }
    head->setcounter();
}

*/
linked* linked::insert(Pair data)
{
        //Pair* newNode=new Pair;
      Pair* newNode=  (Pair*)malloc(sizeof(400));
    newNode->next=NULL;
    *newNode=data;

    if (head==NULL)
    {
        head=newNode;
    }
    else
    {
       Pair * temp=(Pair *)malloc(sizeof(400));
        temp=head;
        while (temp->next!=NULL)
        {
            temp=temp->next;
        }
        temp->next=newNode;
    }
        head->setcounter();

    return this;
}

Pair linked::get_avg()
{
    float sum_x = 0;
    int num_x = 0;
    float sum_y = 0;
    int num_y = 0;
    if (head == NULL)
    {
        cout << "list is empty\n";
    }
    else
    {
        Pair* temp = (Pair*)malloc(sizeof(400));
        temp = head;
        while (temp != NULL)
        {
            sum_x += temp->get_x();
            num_x++;
            sum_y += temp->get_y();
            num_y++;
            temp = temp->next;
        }
    }

    float avg_x = sum_x / num_x;
    float avg_y = sum_y / num_y;
    Pair  answer(avg_x, avg_y);
    //cout << "in func_avg\n";
    return answer;
}
float linked::get_error(float b0, float b1)
{
    int num_whole = Pair::get_counter();
    float y_predict;
    Pair* ptr = (Pair*)malloc(sizeof(400));
    ptr = head;
    float sum_ans = 0;
    while (ptr != NULL)
    {
        y_predict = b0 + (ptr->get_x() * b1);
        sum_ans += (y_predict - ptr->get_y()) * (y_predict - ptr->get_y());
        ptr = ptr->next;//added
    }
    return sum_ans / num_whole;

}
void linked::show_list()
{
    Pair* ptr = (Pair*)malloc(sizeof(400));
    ptr = head;
    while (ptr != NULL)
    {
        cout << "x in show list is: " << ptr->get_x() << "\ty in show list is: " << ptr->get_y() << endl;
        ptr = ptr->next;
    }

}

