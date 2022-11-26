#include <iostream>
#include <math.h>
using namespace std;

int main()
{
    int row_num, column_num;
    int zero_number = 0;
    long long int res = 0;
    cin >> row_num >> column_num;
    int matrix[row_num][column_num];
    for (int i = 0; i < row_num; i++)
        for (int j = 0; j < column_num; j++)
            cin >> matrix[i][j];

    for (int i = 0; i < row_num; i++)
    {
        if (matrix[i][0] == 1){
            for (int j = 0; j < column_num; j++)
            {
                if (matrix[i][j] == 0)
                    matrix[i][j] = 1;
                else
                    matrix[i][j] = 0;
            }
        }
    }

    
    for (int j = 0; j < column_num; j++)
    {
        zero_number = 0;
        for (int i = 0; i < row_num; i++)
            if (matrix[i][j] == 1)
                zero_number++;

        if (zero_number <= row_num / 2)
            for (int i = 0; i < row_num; i++)
            {
                if (matrix[i][j] == 0)
                    matrix[i][j] = 1;
                else
                    matrix[i][j] = 0;
            }
    }

    for (int i = 0; i < row_num; i++)
        for (int j = 0; j < column_num; j++)
        {
            if (matrix[i][j] == 1)
                res =res + pow(2, column_num - (j + 1));
        }

    cout << res<<endl;
    return 0;
}