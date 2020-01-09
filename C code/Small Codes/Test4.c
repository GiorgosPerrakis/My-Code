#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int y;

char *reverse_number(char s[])
{
    static char R[1000000]; 
    int x = strlen(s);
    int i = 0;
    y = x; 
    
    while (i < y)
    {
      x--;         
      s[x] = s[x] - '0';    
      R[i] =  s[x];
      i++;
    }
    return R;
}


int main()
{
    char M[1000000],N[1000000];
    char *p;
    int i = 0, j = 0, a = 0;
    
    printf("Give number\n");
    scanf("%s",M);
    
    while(1)
    {
         N[i] = a / pow(10,i);   
         p = reverse_number(N);
         a++;
         i++;
    }
    
    
    while (j < y)
    {
        printf("%d",*p);
        p++;
        j++;
    }   
    printf("\n");
    
    system ("pause");
    return 0;
}
