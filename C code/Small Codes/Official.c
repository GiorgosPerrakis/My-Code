#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

clock_t begin, end;
double time_spent;

void reverse_number(char s[])
{
    begin = clock();
    char R[1000000]; 
    int x = strlen(s);
    int i=0,j=0,y;
    int f = x-1; 
    
    while((s[f]-'0')==0)
    {
        x--;
        f--;
    }
        
    y = x;
        
    while (i < y)
    {
      x--;         
      s[x] = s[x] - '0';         
      R[i] =  s[x];
      i++;
    }
    
    while (j < y)
    {
        printf("%d", R[j]);
        j++;
    }   
    printf("\n");
}


int main()
{
    char M[1000000];
    
    printf("Give number\n");
    scanf("%s",M);
    
    reverse_number(M);
    
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC; 

    printf("Elapsed: %f seconds\n", time_spent);
    
    system ("pause");
    return 0;
}
    
    

    
    
    
    
