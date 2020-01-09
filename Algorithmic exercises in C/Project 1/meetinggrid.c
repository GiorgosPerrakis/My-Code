#include <stdio.h>
#include <stdlib.h>

int comp_x(const void *a, const void *b); 
int comp_y(const void *a, const void *b); 
 
struct elements
{
    long int x; 
    long int y;
    long long int x1;
    long long int y1;
} st[2000000];

int main()								
{
	long long int i, N, temp;
		
	scanf("%lld", &N); 
	 
	for(i = 0; i < N; i++)                                         
	{
		scanf("%lld", &st[i].x);
		scanf("%lld", &st[i].y);
	}
	
	qsort(st, N, sizeof(struct elements), comp_y);
     
     
    st[0].y1 = 0; 
    for(i = 1; i < N; i++)                                       //y left to right
    {
        st[i].y1 = st[i-1].y1 + (st[i].y - st[i-1].y) * i;           
    }   
    
	temp = 0;   
   
    for(i = N-2; i >= 0; i--)                                  //y right to left
    {
		st[i].y1 = st[i].y1 + temp + (st[i+1].y - st[i].y) * (N-i-1);	
		temp = temp + (st[i+1].y - st[i].y) * (N-i-1);
		printf("y1 %lld\n", st[i].y1);
    }
    
    qsort(st, N, sizeof(struct elements), comp_x);

    st[0].x1 = 0; 
    for(i = 1; i < N; i++)                                       //x left to right
    {
        st[i].x1 = st[i-1].x1 + (st[i].x - st[i-1].x) * i; 
		printf("x1 %lld\n", st[i].x1);            
    }   
    
	temp = 0;   
   
    for(i = N-2; i >= 0; i--)                                  //x right to left
    {
		st[i].x1 = st[i].x1 + temp + (st[i+1].x - st[i].x) * (N-i-1);
		temp = temp + (st[i+1].x - st[i].x) * (N-i-1);
		printf("x2 %lld\n", st[i].x1);
    }
    
 	long long int min = st[0].x1 + st[0].y1;

    for(i = 1; i < N; i++)
    {
        st[i].y1 = st[i].x1 + st[i].y1;
        if(st[i].y1 < min) 
        	min = st[i].y1;
    }
 
    printf("%lld\n", min);         
	    
    return 0;
}


int comp_x(const void *a, const void *b) 
{
	struct elements *c = (struct elements *)a;
	struct elements *d = (struct elements *)b;
	return (c->x - d->x);
}

int comp_y(const void *a, const void *b) 
{
	struct elements *c = (struct elements *)a;
	struct elements *d = (struct elements *)b;
	return (c->y - d->y);
}
