#include <iostream>
using namespace std;
#include <vector>
#include <queue>

int isColorable(vector<vector<int>> &, int,int);

int main(){

int numEdges,numVertex=1,tempArr[200],index=0,a,b;
  cin>>numVertex;
while(numVertex){
  cin>>numEdges;
  vector<vector<int>>graph(numEdges,vector<int>(2,0));
  vector<vector<int>>adj(numVertex,vector<int>(numVertex,0));
  vector<int>color(numVertex,0);

  for (int i = 0; i < numEdges; i++)
  {
      for (int j = 0; j < 2; j++)
      {
          cin>>graph[i][j];
      }
      
  }
  

  for (int i = 0; i < numEdges; i++) {
        a = graph[i][0];
        b = graph[i][1];

        adj[a][b] = 1;
        adj[b][a] = 1;
    }

    if(isColorable(adj, 0,numVertex))
       tempArr[index] =1;
    else  
    tempArr[index]=0;
    index++;

    cin>>numVertex;

}
for (int i = 0; i < index; i++)
{
    if(tempArr[i])
        cout << "BICOLORABLE."<<endl;
    else 
        cout<<"NOT BICOLORABLE."<<endl;
}

}
int isColorable(vector<vector<int>> &graph, int src,int V)
{

    int color[V];
    for (int i = 0; i < V; ++i)
        color[i] = -1;
    color[src] = 1;

    queue <int> q;
    q.push(src);

    while (!q.empty())
    {
        int u = q.front();
        q.pop();

        if (graph[u][u] == 1)
        return 0;

        for (int v = 0; v < V; ++v)
        {

            if (graph[u][v] && color[v] == -1)
            {
                color[v] = 1 - color[u];
                q.push(v);
            }

            else if (graph[u][v] && color[v] == color[u])
                return 0;
        }
    }

    return 1;
}