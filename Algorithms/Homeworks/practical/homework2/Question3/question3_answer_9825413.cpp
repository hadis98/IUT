#include <iostream>
using namespace std;

long long int array_numbers(long long int [],long long int,long long int);
int main()
{
    long long int n, m;
    // long long int result = 0;
    cin >> n >> m;

    long long int arr[n + 1];
    for (long long int i = 1; i <= n; i++){
        cin >> arr[i];
    }
    cout<<array_numbers(arr,n,m)<<endl;
}

long long int array_numbers(long long int array[],long long int n,long long int m)
{
    long int result = 0;
   long long int arr_dp[n + 2][m + 2];
    for (long long int i = 0; i <=n + 1; i++){
        for (long long int j = 0; j <= m + 1; j++){
            arr_dp[i][j] = 0;
        }
    }


    if (array[1] == 0)
    {
        for (int i = 1; i <= m; i++)
        {
            arr_dp[1][i] = 1;
        }
    }
    else
    {
        arr_dp[1][array[1]] = 1;
    }
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= m; j++)
        {
            if (array[i] == 0 || j == array[i])
                arr_dp[i][j] = (arr_dp[i][j] + arr_dp[i - 1][j - 1] + arr_dp[i - 1][j] + arr_dp[i - 1][j + 1]) % 1000000007;
        }
    }

    for (int i = 1; i <= m; i++)
    {
        result = (result + arr_dp[n][i])%1000000007;
        // result %= 1000000007;
    }
    return result;
}