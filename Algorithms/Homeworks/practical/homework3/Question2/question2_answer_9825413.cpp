#include <iostream>
using namespace std;

long int gameChoice(long int[], long int);

int main()
{

    long int num;
    cin >> num;

    long int joy[num];
    for (long int i = 0; i < num; i++)
        cin >> joy[i];
    cout << gameChoice(joy, num) << endl;

    return 0;
}

long int gameChoice(long int arr[], long int n)
{
    long int a, b, c;
    long int answer[n][n];
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            answer[i][j] = 0;
    }
    for (long int i = 0; i < n; i++)
    {
        for (long int j = 0, k = i; j < n, k < n; j++, k++)
        {
            if ((j + 2) <= k)
            {
                a = answer[j + 2][k];
            }
            else
            {
                a = 0;
            }
            if ((j + 1) <= (k - 1))
            {
                b = answer[j + 1][k - 1];
            }
            else
            {
                b = 0;
            }
            if (j <= (k - 2))
            {
                c = answer[j][k - 2];
            }
            else
            {
                c = 0;
            }
            answer[j][k] = max(arr[j] + min(a, b), arr[k] + min(b, c));
        }
    }

    return answer[0][n - 1];
}