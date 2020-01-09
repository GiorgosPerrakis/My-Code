#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>

void open_file();
void display_output();
void mergeSort(long l, long r);
void merge(long l, long m, long r);
long function();

long N[2000000][2], total;

int main(int argc, char *argv[])
{  
    FILE *fp; 
	char name[30];
	long max, i = 0;
	
	if (argc > 1) fp=fopen(argv[1],"r"); 
    else exit(2); 
	
	//printf("Give file name:");
	
	//gets(name);    
   // fp=fopen(name,"r"); 
	 
	while(!feof(fp))                                         
	{
		if(i == 0) 	fscanf(fp,"%ld", &total);
		fscanf(fp,"%ld", &N[i][0]);
		N[i][1] = i + 1;
		i++;
	}
                      				                                        				                         
    fclose(fp);  
	mergeSort(0, i-1);
    display_output(); 	
	max = function();
	printf("max height is: %ld\n", max);  
	return 0;                                 
}


void merge(long l, long m, long r)
{
    long i, j, k;
    long n1 = m - l + 1;
    long n2 =  r - m;
 
    long L[n1][2], R[n2][2];
 
    for (i = 0; i < n1; i++)
    {
    	L[i][0] = N[l + i][0];
        L[i][1] = N[l + i][1];
	}
    for (j = 0; j < n2; j++)
    {
        R[j][0] = N[m + 1+ j][0];
        R[j][1] = N[m + 1+ j][1];		    	
	}

    i = 0; 
    j = 0; 
    k = l; 
    while (i < n1 && j < n2)
    {
        if (L[i][0] < R[j][0])
        {
            N[k][0] = L[i][0];
            N[k][1] = L[i][1];           
            i++;
        }
        else if (L[i][0] > R[j][0])
        {
            N[k][0] = R[j][0];
            N[k][1] = R[j][1];
            j++;
        }
        else
        {
        	if(L[i][1] < R[j][1])
	        {
            	N[k][0] = L[i][0];
            	N[k][1] = L[i][1];           
            	i++;
        	}
        	else 
        	{
            	N[k][0] = R[j][0];
            	N[k][1] = R[j][1];
            	j++;
        	}	        	
		}
        k++;
    }
 
    while (i < n1)
    {
        N[k][0] = L[i][0];
        N[k][1] = L[i][1];
        i++;
        k++;
    }
 
    while (j < n2)
    {
        N[k][0] = R[j][0];
        N[k][1] = R[j][1];
        j++;
        k++;
    }
}


void mergeSort(long l, long r)
{
    if (l < r)
    {
        long m = l+(r-l)/2;
        mergeSort(l, m);
        mergeSort(m+1, r);
        merge(l, m, r);
    }
}

long function()
{
	long k, max_height = 0, min = 3000000, temp[200000];
	
	for(k = 0; k < total; k++)
	{
		if(N[k][1] < min ) 
			min = N[k][1];
							
		temp[k] = N[k+1][1] - min;	
		//printf("temp %d - %d = %d\n", N[k+1][1], min, temp[k]);			
	}
	
	for(k = 0; k < total; k++)
	{
		if(temp[k] > max_height)
			max_height = temp[k];			
	}
	return max_height;
}


void display_output()                                     
{
    long w;
    printf("total stops: %ld\n", total);
    for(w = 0; w < total; w++)  
    {
		printf("%ld %ld\n",N[w][0], N[w][1]);
    }
    printf("\n");
}

