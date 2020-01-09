#include <stdio.h>
#include <stdlib.h>

void open_read();
void create_left_list();
void create_right_list();
void display_output();
int calculate_distances();

struct heights
{
	long height, station;
	struct heights *next, *previous;
};

struct heights *heights_head, *heights_first;

struct left
{
	long height, station;
	struct left *next;
	struct left *previous;	
};

struct left *left_head, *left_first;

struct right
{
	long height, station;
	struct right *next;
};

struct right *right_head, *right_first;


long counter = 0, total, check = 0, s = 1, maxdis = 1;


int main()
{  	 
	open_read();	
    if(check != total-1) 
    {
     	create_left_list();
		create_right_list(); 		
		printf("max distance: %d\n", calculate_distances());   		
	}
    else
    {
    	if(maxdis > 1)
    		printf("max is: %d\n", maxdis);
    	else
			printf("no options available: 0");   		  	
	}
 	// display_output();
	return 0;                                 
}


void open_read()
{
	FILE *fp; 
	char name[30];
	struct heights *new_node;
	
	printf("Give file name:");
	
	gets(name);    
    fp=fopen(name,"r"); 
	
	counter = 0;
	 
	while(!feof(fp))                                         
	{
		if(counter == 0) 	
			fscanf(fp,"%ld", &total);
		else
		{
			new_node = (struct heights *)malloc(sizeof(struct heights));
			if(counter == 1)  
			{
				heights_first = new_node;  
				new_node->next = NULL;
				new_node->previous = NULL;
				fscanf(fp,"%ld", &new_node->height);				
			}
			else
			{
				new_node->next = heights_head;
				new_node->previous = NULL;
				heights_head->previous = new_node;
				fscanf(fp,"%ld", &new_node->height);
				if(new_node->next->height >= new_node->height)
				{
					check++;
					if(new_node->next->height == new_node->height)
						s++;
					else
						s = 1;					
					if(maxdis < s)  maxdis = s;	
					
				}
			}

			new_node->station = counter;	
			heights_head = new_node;
			
		}
		
		counter++;
	}
                      				                                        				                         
    fclose(fp); 
}


void create_left_list()
{
	struct heights *p;
	struct left *new_left_node;
	
	p = heights_first;
	
	new_left_node = (struct left *)malloc(sizeof(struct left));
	left_first = new_left_node;  
	new_left_node->next = NULL;	
	new_left_node->previous = NULL;			
	left_head = new_left_node;	
	new_left_node->height = p->height;
	new_left_node->station = p->station;
	p = p->previous;						
	
	while(p!=NULL)
	{
		if(p->height < new_left_node->height)  
		{
			new_left_node = (struct left *)malloc(sizeof(struct left));
			new_left_node->next = left_head;
			new_left_node->previous = NULL;
			left_head->previous = new_left_node;						
			left_head = new_left_node;	
			new_left_node->height = p->height;
			new_left_node->station = p->station;
		}
		p = p->previous;						
	}
}


void create_right_list()
{
	struct heights *p;
	struct right *new_right_node;
	
	p = heights_head;
	
	new_right_node = (struct right *)malloc(sizeof(struct right));
	right_first = new_right_node;  
	new_right_node->next = NULL;			
	right_head = new_right_node;	
	new_right_node->height = p->height;
	new_right_node->station = p->station;
	p = p->next;						
	
	while(p!=NULL)
	{
		if(p->height > new_right_node->height)  
		{
			new_right_node = (struct right *)malloc(sizeof(struct right));
			new_right_node->next = right_head;			
			right_head = new_right_node;	
			new_right_node->height = p->height;
			new_right_node->station = p->station;
		}
		p = p->next;						
	}
}


int calculate_distances()
{
	struct left *left;
	struct right *right;
	int max = -1, temp;
	
	left = left_first;
	right = right_head;
	
	while(left!=NULL)
	{
		if(left->height <= right->height)
		{
			
			temp = right->station - left->station;
			if(temp > max)
				max = temp;
			if(right->next != NULL)
				right = right->next;	
			else
				break;	
		}
		else
			left = left->previous;
	}
	return max;
}




void display_output()                                     
{
   struct heights *p;
   struct left *f;
   struct right *w;
    
	printf("total stations: %ld\n", total);
    
    p = heights_first;  

    while(p!= NULL)  
    {
		printf("%ld %ld\n", p->height, p->station);
		p = p->previous;
    }
    
    printf("\n");
    printf("left array:\n");
    
    f = left_first;
    
    while(f!= NULL)  
    {
		printf("%ld %ld\n", f->height, f->station);
		f = f->previous;
    }  
	
    printf("\n");
    printf("right array:\n");
    
    w = right_head;
    
    while(w!= NULL)  
    {
		printf("%ld %ld\n", w->height, w->station);
		w = w->next;
    } 	  
    
    printf("\n");
}
