#include <stdio.h>
#include <stdlib.h>

int max(int num1, int num2);

int main()
{
	int L, N, i, j;
	long x, temp;

	scanf("%d %d", &N, &L);

	int prices[N];
	long a[N];

	for(i = 0; i < N; i++)
	{
		scanf("%d", &prices[i]);	
		a[i] = 0;	
	}

	for(i = 0; i < L; i++)
	{
		x = a[0] - prices[0];
		for(j = 1; j < N; j++)
		{
			temp = a[j];
			a[j] = max(a[j-1], prices[j] + x);
			x = max(x, temp - prices[j]);
			
			printf("%d %d %d\n", j, a[j], x);
		}
	}

	printf("%ld\n", a[N-1]);
}

int max(int num1, int num2)
{
    return (num1 > num2 ) ? num1 : num2;
}
