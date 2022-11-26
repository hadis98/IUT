#include <iostream>
using namespace std;
long long int nums(int);

int main()
{
    int n;
    cin >> n;
    cout << nums(n)<<endl;

    return 0;
}

long long int nums(int n)
{
   long long int arr[n + 1];

    arr[0] = 1;

    for (int i = 1; i <= n; i++)
    {
        arr[i] = 0;
        for (int j = 1; j <= 6; j++)
        {

            if (i - j >= 0)
            {
                arr[i] = arr[i] + arr[i - j]% (1000000007);
            }
        }
    }

    return arr[n]% (1000000007);
}
