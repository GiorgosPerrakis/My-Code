#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{   
    char num[1000000],reverse[1000000];
    printf("Enter a number to reverse\n");
    scanf("%s",num);

    int i = 0,j = 0;
    int x = strlen(num); 
    int y = x;
    
    while (i < y)
    {
      x--;         
      num[x] = num[x] - '0';    
      reverse[i] =  num[x];
      i++;
    }
    
    while (j < y)
    {
        printf("%d", reverse[j]);
        j++;
    }
    
    system ("pause");
    return 0;
}

