#include <iostream>
using namespace std;

int coin_numbers(int[],int,int);

int main()
{

    int n, x;
    cin >> n >> x;
    int numbers[n];
    for (int i = 0; i < n; i++)
    {
        cin >> numbers[i];
    }

    cout << coin_numbers(numbers, n, x)%1000000007<<endl;

    return 0;
}

int coin_numbers(int numbers[], int n, int x)
{
    int dp[x + 1][n];
    int a, b;

    for (int i = 0; i < n; i++)
    {
        dp[0][i] = 1;
    }
    for (int i = 1; i < x + 1; i++)
    {
        for (int j = 0; j < n; j++)
        {

            a = (i - numbers[j] >= 0) ? (dp[i - numbers[j]][j]) % 1000000007 : 0;
            b = (j >= 1) ? (dp[i][j - 1]) % (1000000007) : 0;
            dp[i][j] = a + b;
        }
    }
   return dp[x][n-1];
}
