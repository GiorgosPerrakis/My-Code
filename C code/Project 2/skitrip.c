#include <stdio.h>
#include <stdlib.h>

void open_read();													//declaration of functions
void create_left_list();
void create_right_list();
void display_output();
long calculate_distances();

struct heights														//struct for heights
{
	long height, station;
	struct heights *next, *previous;
};

struct heights *heights_head, *heights_first;

struct left															//struct for left list
{
	long height, station;
	struct left *next;
	struct left *previous;	
};

struct left *left_head, *left_first;

struct right														//struct for right list
{
	long height, station;
	struct right *next;
};

struct right *right_head, *right_first;


long i = 0, total, check = 0, s = 1, maxdis = 1;


int main()
{  	 
	open_read();														
    if(check != total-1)                                             //case of random list of numbers (general case)
    {
     	create_left_list();		
		create_right_list(); 		
		printf("%ld", calculate_distances());   					//print the max distance which is calculated by "calculate_distance" function 
	}
    else															//case of descending list of numbers
    {
    	if(maxdis > 1)												//if there are the same elements multiple times then we have a solution 
    		printf("%ld", maxdis-1);									//which is saved in "maxdis" variable
    	else
    	{															//in case of descending list there is no solution, so we print "0"
    		i = 0;
    		printf("%ld", i); 
		}  		  	
	}
	return 0;                                 
}


void open_read(int argc, char *argv[])									//functions that opens the file, read the elements and save them to a list
{
	FILE *fp; 
	struct heights *new_node;
	
	if (argc > 1) fp=fopen(argv[1],"r"); 								//open the file which is given in arguments
    else exit(2); 
	
	fscanf(fp,"%ld", &total); 
	 
	for(i = 0; i < total; i++)                                         
	{
			new_node = (struct heights *)malloc(sizeof(struct heights));			//create a list to save the elements of the file
			if(i == 0)  														
			{																		//create the first node and save the element
				heights_first = new_node;  
				new_node->next = NULL;
				new_node->previous = NULL;
				fscanf(fp,"%ld", &new_node->height);				
			}
			else																	//create the rest nodes and save the rest elements of the file
			{
				new_node->next = heights_head;
				new_node->previous = NULL;
				heights_head->previous = new_node;
				fscanf(fp,"%ld", &new_node->height);
				
				if(new_node->next->height >= new_node->height)				      //check for descending list 
				{																  //when we finish reading from the file, if "check" variable has the same value 
					check++;													  //with "total" variable then that means that every element is smaller than 
																				  //the next one and we have a descending list
					if(new_node->next->height == new_node->height)				  //here we check if in a descending list there are elements with the same values
						s++;													  //in that case we have a solution to our problem and we search for the maximum
					else														  //sequence of same elements
						s = 1;					
					if(maxdis < s)  maxdis = s;		
				}
			}
			new_node->station = i + 1;	
			heights_head = new_node;		
	}                     				                                        				                         
    fclose(fp); 
}


void create_left_list()																//function that creates a list 
{																					//starts from the beginning (left side) of the initial list, saves the first
	struct heights *p;																//element and then saves every other element that is smaller than the 
	struct left *new_left_node;														//previous one which was saved
	
	p = heights_first;
	
	new_left_node = (struct left *)malloc(sizeof(struct left));						//create the first node of the new list
	left_first = new_left_node;  
	new_left_node->next = NULL;					
	new_left_node->previous = NULL;			
	left_head = new_left_node;	
	new_left_node->height = p->height;
	new_left_node->station = p->station;
	p = p->previous;						
	
	while(p!=NULL)																	//scan the whole initial list with the heights
	{
		if(p->height < new_left_node->height)  
		{
			new_left_node = (struct left *)malloc(sizeof(struct left));				//create a new node for every element which must be saved
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


void create_right_list()															//function that creates a list 
{																					//starts from the end (right side) of the initial list, saves the last
	struct heights *p;																//element and then saves every other element that is greater than the
	struct right *new_right_node;													//previous one which was saved
	
	p = heights_head;
	
	new_right_node = (struct right *)malloc(sizeof(struct right));					//create the first node of the new list
	right_first = new_right_node;  
	new_right_node->next = NULL;			
	right_head = new_right_node;	
	new_right_node->height = p->height;
	new_right_node->station = p->station;
	p = p->next;						
	
	while(p!=NULL)																	//scan the whole initial list with the heights
	{
		if(p->height > new_right_node->height)  
		{
			new_right_node = (struct right *)malloc(sizeof(struct right));			//create a new node for every element which must be saved
			new_right_node->next = right_head;			
			right_head = new_right_node;	
			new_right_node->height = p->height;
			new_right_node->station = p->station;
		}
		p = p->next;						
	}
}


long calculate_distances()															//function that calculates the maximum distance 
{
	struct left *left;
	struct right *right;
	long max = -1, temp;
	
	left = left_first;
	right = right_head;
	
	while(left!=NULL)																//we check every element of the "left list" with all the elements of
	{																				//the "right list" 
		if(left->height <= right->height)											
		{																			//for every possible couple (left element smaller that the right one)
			temp = right->station - left->station;									//we calculate the distance 
			if(temp > max)															//and then we find the maximum distance 
				max = temp;
			if(right->next != NULL)
				right = right->next;	
			else
				break;	
		}
		else																		//if we find a couple that is not possible then we continue with next element
			left = left->previous;													//of the "left list", but with the same element of the "right list" that we
	}																				//have stopped
	return max;
}
