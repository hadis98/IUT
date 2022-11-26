#include <iostream>
using namespace std;

void mergeFunc(struct point[], int , int , int );
long int mergeFunc2(struct point [], int , int , int );
void MergeSort(struct point[], int , int );
long int MergeSort2(struct point [], int , int );


struct point
{
    double x;
    double y;
};

int number;
int main()
{

    int n;
    cin >> n;
    point points[n];
    number = n;
    for (int i = 0; i < n; i++)
    {
        cin >> points[i].x>> points[i].y;
    }

    MergeSort(points, 0, n - 1);
    long int num_intersection  = MergeSort2(points,0,n-1);
    cout << num_intersection << endl;

    
    return 0;
}

void MergeSort(struct point arr[], int left, int right)
{
    
    if (right > left)
    {
        int middle = (left + right) / 2;
         MergeSort(arr, left, middle);
         MergeSort(arr, middle + 1, right);
         mergeFunc(arr, left, middle, right);
    }
    
}

long int MergeSort2(struct point arr[], int left, int right){
   long int intersection_count = 0;
    if (right > left)
    {
        int middle = (left + right) / 2;
        intersection_count += MergeSort2(arr, left, middle);
        intersection_count += MergeSort2(arr, middle + 1, right);
        intersection_count += mergeFunc2(arr, left, middle, right);
    }
    return intersection_count;
}

void mergeFunc(struct point arr[], int left, int middle, int right)
{

    point tempArr[number];
    int i = left, j = middle + 1, z = left;
    while (i <= middle && j <= right)
    {
        if (arr[i].x <= arr[j].x)
        {
            tempArr[z].x = arr[i].x;
            tempArr[z].y = arr[i].y;
            i++;
        }
        else
        {
            tempArr[z].x = arr[j].x;
            tempArr[z].y = arr[j].y;
            j++;
           
        }
        z++;
    }
    //copy the remaining elements
    while (i <= middle)
    {
        tempArr[z].x = arr[i].x;
        tempArr[z].y = arr[i].y;
        i++;
        z++;
    }
    while (j <= right)
    {
        tempArr[z].x = arr[j].x;
        tempArr[z].y = arr[j].y;
        j++;
        z++;
    }
    for (int i = left; i < z; i++)
    {
        arr[i].x = tempArr[i].x;
        arr[i].y = tempArr[i].y;
    }

}

long int mergeFunc2(struct point arr[], int left, int middle, int right)
{
   long int intersection_count = 0;
    point tempArr[number];
    int i = left, j = middle + 1, z = left;
    while (i <= middle && j <= right)
    {
        if (arr[i].y <= arr[j].y)
        {
            tempArr[z].x = arr[i].x;
            tempArr[z].y = arr[i].y;
            i++;
        }
        else
        {
            tempArr[z].x = arr[j].x;
            tempArr[z].y = arr[j].y;
            if(arr[i].x != arr[j].x)
                intersection_count = intersection_count + (middle) - (i - 1);
            j++;
        }
        z++;
    }
    //copy the remaining elements
    while (i <= middle)
    {
        tempArr[z].x = arr[i].x;
        tempArr[z].y = arr[i].y;
        i++;
        z++;
    }
    while (j <= right)
    {
        tempArr[z].x = arr[j].x;
        tempArr[z].y = arr[j].y;
        j++;
        z++;
    }
    for (int i = left; i < z; i++)
    {
        arr[i].x = tempArr[i].x;
        arr[i].y = tempArr[i].y;
    }

    return intersection_count;
}

