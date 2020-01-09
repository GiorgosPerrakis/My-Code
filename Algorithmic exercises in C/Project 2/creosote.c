#include <stdio.h>
#include <stdlib.h>

long long max(long long num1, long long num2);
long long function(int a, long long b, long long c, long long k);

int main()
{
	long long i, j, b, c, temp, temp1, N, *y;
	int a, *x;	
		
	scanf("%lld", &N);	
	scanf("%d %lld %lld", &a, &b, &c);	
	
	x = calloc(N, sizeof(int));
	y = calloc(N, sizeof(long long));	
	
	for(i = 0; i < N; i++)
	{
		scanf("%d", &x[i]); 
	}
	
	y[0] = function(a, b, c, x[0]);
	for(i = 1; i < N; i++)
	{
		y[i] = y[i-1] + function(a, b, c, x[i]);
		temp = x[i];

        for(j = i-2; j >= 0; j--)
		{  
            temp = temp + x[j+1];  
            temp1 = y[j] + function(a, b, c, temp);  
            if(temp1  >= y[i])
                y[i] = temp1;  
        }  
		y[i] = max(y[i], function(a, b, c, temp + x[0]));  		
	}
	
	printf("%lld\n", y[N-1]);	
	
	return 0;
}

long long function(int a, long long b, long long c, long long k)
{
	long long result;
	result = a * k * k + b * k + c;
	return result;
}

long long max(long long num1, long long num2)
{
    return (num1 > num2 ) ? num1 : num2;
}
