#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    char M[1000000];
    char *p;
    int j = 0;
    
    printf("Give number\n");
    scanf("%s",M);
    
    p = reverse_number(M);
    
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
