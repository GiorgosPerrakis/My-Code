#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int i=0,j=0;
int array[100];

void display(int x);
int fun(int y);

int main()
{
    int a,t[100];
    printf("give number\n");
    scanf("%d",&a); 
    fun(a);
    display(array,a);
    system("pause");
    return 0;
}
    

    
int fun(int y)
{
       if (i==(y-1))
          return;
       else
       {
           array[i] = pow(10,i);
           i++;
           return fun(y-1);
       }
}     
    
    
  void display(int x[],int k)
  {  
    if (j==k-1)
       return;
    else
    {
        printf("%d\n",x[j]);
        j++;
        return fun(x-1);
    }
  }         
    
