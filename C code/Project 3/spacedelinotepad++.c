#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct space_node{
	int distance1,distance2;
	char box;
};

struct 	queue{
	int i,j;
	struct queue *next;
};

struct print_node{
	char c;
	struct print_node *next;
};

struct space_node space[1000][1000];
struct queue *head,*tail,*current,*current1;
struct print_node *h,*h1;

int main(int argc, char *argv[]){
	char ch,ch1,ch2 = ' ';
	FILE *fp;
	int i = 0,j = 0,start_i = 0,start_j = 0,M = 0,N = 0,end_i = 0,end_j = 0,d;
	bool newbox,without_delivery;
	if(argc == 2) fp = fopen(argv[1],"r");
	else{
		printf("wrong number of parameters\n");
		exit(21);
	}	
	if(fp == NULL){
		printf("cannot open text file\n");
		fclose(fp);
		exit(21);
	}
	while((ch = fgetc(fp)) != EOF){																							/*store data on an array of structs*/
		if(ch == 'S'){
			start_i = i;
			start_j = j;
		}
		if(ch == 'E'){
			end_i = i;
			end_j = j;
		}
		if(ch == '\n'){
			M = j - 1;
			j = 0;
			i++;
			ch2 = ch;
		}
		else{
			space[i][j].box = ch;
			space[i][j].distance1 = -1;
			space[i][j].distance2 = -1;
			j++;
			ch2 = ch;
		}
	}
	fclose(fp);
	if(ch2 == '\n'){
		N = i - 1;
	} 
	else N = i;	
	space[start_i][start_j].distance1 = 0;
	head = malloc(sizeof(struct queue));
	head -> i = start_i;
	head -> j = start_j;
	head -> next = NULL;
	tail = current = head;
	while(head!=NULL){
		while(head != (tail -> next)){	
			if(((head -> i) - 1) >= 0 && ((head -> i) - 1) <= N){															/*check upper box if that exists*/
				newbox = false;
				if(space[(head -> i) - 1][head -> j].box != 'X'){
					if(space[(head -> i) - 1][head -> j].distance1 == -1){
						space[(head -> i) - 1][head -> j].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][head -> j].distance2 != -1 && space[(head -> i) - 1][head -> j].distance2 == -1){
						space[(head -> i) - 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}					
					if(space[(head -> i) - 1][head -> j].box == 'W' && space[head -> i][head -> j].distance2 == -1){
						space[(head -> i) - 1][head -> j].distance2 = space[head -> i][head -> j].distance1 + 3;
						newbox = true;
					}
					if(space[(head -> i) - 1][head -> j].box == 'W' && space[head -> i][head -> j].distance2 != -1){
						if(space[(head -> i) - 1][head -> j].distance1 > space[head -> i][head -> j].distance2 + 2){
							space[(head -> i) - 1][head -> j].distance1 = space[head -> i][head -> j].distance2 + 2;
							newbox = true;
						}
						if(space[(head -> i) - 1][head -> j].distance2 > space[head -> i][head -> j].distance2 + 1){
							space[(head -> i) - 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
							newbox = true;
						}	
					}
					if(space[(head -> i) - 1][head -> j].distance1 > space[head -> i][head -> j].distance1 + 2){
						space[(head -> i) - 1][head -> j].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[(head -> i) - 1][head -> j].distance2 > space[head -> i][head -> j].distance2 + 1 && space[head -> i][head -> j].distance2 != -1){
						space[(head -> i) - 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}					
				}
				if(newbox == true){
					current -> next = malloc(sizeof(struct queue));
					current -> next -> i = (head -> i) - 1;
					current -> next -> j = head -> j;
					current = current -> next;
					current -> next = NULL;
				}
			}
			if((head -> i + 1) >= 0 && ((head -> i) + 1) <= N){																/*check lower box if that exists*/
				newbox = false;
				if(space[(head -> i) + 1][head -> j].box != 'X'){
					if(space[(head -> i) + 1][head -> j].distance1 == -1){
						space[(head -> i) + 1][head -> j].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][head -> j].distance2 != -1 && space[(head -> i) + 1][head -> j].distance2 == -1){
						space[(head -> i) + 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}
					if(space[(head -> i) + 1][head -> j].box == 'W' && space[head -> i][head -> j].distance2 == -1){
						space[(head -> i) + 1][head -> j].distance2 = space[head -> i][head -> j].distance1 + 3;
						newbox = true;
					}
					if(space[(head -> i) + 1][head -> j].box == 'W' && space[head -> i][head -> j].distance2 != -1){
						if(space[(head -> i) + 1][head -> j].distance1 > space[head -> i][head -> j].distance2 + 2){
							space[(head -> i) + 1][head -> j].distance1 = space[head -> i][head -> j].distance2 + 2;
							newbox = true;
						}
						if(space[(head -> i) + 1][head -> j].distance2 > space[head -> i][head -> j].distance2 + 1){
							space[(head -> i) + 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
							newbox = true;
						}
					}
					if(space[(head -> i) + 1][head -> j].distance1 > space[head -> i][head -> j].distance1 + 2){
						space[(head -> i) + 1][head -> j].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[(head -> i) + 1][head -> j].distance2 > space[head -> i][head -> j].distance2 + 1 && space[head -> i][head -> j].distance2 != -1){
						space[(head -> i) + 1][head -> j].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}
				}
				if(newbox == true){
					current -> next = malloc(sizeof(struct queue));
					current -> next -> i = (head -> i) + 1;
					current -> next -> j = head -> j;
					current = current -> next;
					current -> next = NULL;
				}
			}
			if((head -> j - 1) >= 0 && ((head -> j) - 1) <= M){																/*check left box if that exists*/
				newbox = false;
				if(space[head -> i][(head -> j) - 1].box != 'X'){
					if(space[head -> i][(head -> j) - 1].distance1 == -1){
						space[head -> i][(head -> j) - 1].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][head -> j].distance2 != -1 && space[head -> i][(head -> j) - 1].distance2 == -1){
						space[head -> i][(head -> j) - 1].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}
					if(space[head -> i][(head -> j) - 1].box == 'W' && space[head -> i][head -> j].distance2 == -1){
						space[head -> i][(head -> j) - 1].distance2 = space[head -> i][head -> j].distance1 + 3;
						newbox = true;
					}
					if(space[head -> i][(head -> j) - 1].box == 'W' && space[head -> i][head -> j].distance2 != -1){
						if(space[head -> i][(head -> j) - 1].distance1 > space[head -> i][head -> j].distance2 + 2){
							space[head -> i][(head -> j) - 1].distance1 = space[head -> i][head -> j].distance2 + 2;
							newbox = true;
						}
						if(space[head -> i][(head -> j) - 1].distance2 > space[head -> i][head -> j].distance2 + 1){
							space[head -> i][(head -> j) - 1].distance2 = space[head -> i][head -> j].distance2 + 1;
							newbox = true;
						}
					}
					if(space[head -> i][(head -> j) - 1].distance1 > space[head -> i][head -> j].distance1 + 2){
						space[head -> i][(head -> j) - 1].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][(head -> j) - 1].distance2 > space[head -> i][head -> j].distance2 + 1 && space[head -> i][head -> j].distance2 != -1){
						space[head -> i][(head -> j) - 1].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}			
				}
				if(newbox == true){
					current -> next = malloc(sizeof(struct queue));
					current -> next -> i = head -> i;
					current -> next -> j = (head -> j) - 1;
					current = current -> next;
					current -> next = NULL;
				}				
			}
			if((head -> j + 1) >= 0 && ((head -> j) + 1) <= M){																/*check right box if that exists*/
				newbox = false;
				if(space[head -> i][(head -> j) + 1].box != 'X'){
					if(space[head -> i][(head -> j) + 1].distance1 == -1){
						space[head -> i][(head -> j) + 1].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][head -> j].distance2 != -1 && space[head -> i][(head -> j) + 1].distance2 == -1){
						space[head -> i][(head -> j) + 1].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}
					if(space[head -> i][(head -> j) + 1].box == 'W' && space[head -> i][head -> j].distance2 == -1){
						space[head -> i][(head -> j) + 1].distance2 = space[head -> i][head -> j].distance1 + 3;
						newbox = true;
					}
					if(space[head -> i][(head -> j) + 1].box == 'W' && space[head -> i][head -> j].distance2 != -1){
						if(space[head -> i][(head -> j) + 1].distance1 > space[head -> i][head -> j].distance2 + 2){
							space[head -> i][(head -> j) + 1].distance1 = space[head -> i][head -> j].distance2 + 2;
							newbox = true;
						}	
						if(space[head -> i][(head -> j) + 1].distance2 > space[head -> i][head -> j].distance2 + 1){
							space[head -> i][(head -> j) + 1].distance2 = space[head -> i][head -> j].distance2 + 1;
							newbox = true;
						}
					}
					if(space[head -> i][(head -> j) + 1].distance1 > space[head -> i][head -> j].distance1 + 2){
						space[head -> i][(head -> j) + 1].distance1 = space[head -> i][head -> j].distance1 + 2;
						newbox = true;
					}
					if(space[head -> i][(head -> j) + 1].distance2 > space[head -> i][head -> j].distance2 + 1 && space[head -> i][head -> j].distance2 != -1){
						space[head -> i][(head -> j) + 1].distance2 = space[head -> i][head -> j].distance2 + 1;
						newbox = true;
					}		
				}
				if(newbox == true){
					current -> next = malloc(sizeof(struct queue));
					current -> next -> i = head -> i;
					current -> next -> j = (head -> j) + 1;
					current = current -> next;
					current -> next = NULL;
				}								
			}
			current1 = head;
			head = head -> next;
			if(current1 != tail){
				current1 -> next = NULL;			
				free(current1);			
			}
		}			
		current1 -> next = NULL;			
		free(current1);					
		tail = current;
	}
	printf("%d ",space[end_i][end_j].distance1);	
	if(space[end_i][end_j].distance1 == -1) exit(21);
	d = space[end_i][end_j].distance1;
	i = end_i;
	j = end_j;
	without_delivery = false;
	h = NULL;
	ch1 = ' ';
label1:	
	while(d > 0){
		if((i - 1) >= 0){
			if(space[i - 1][j].box != 'X'){
				if(space[i - 1][j].distance1 == (space[i][j].distance1 - 2) && without_delivery == false){
					d = d - 2;
					i = i - 1;
					ch = 'D';
					goto label;
				}
				else if(space[i][j].box == 'W' && space[i - 1][j].distance2 == space[i][j].distance1 - 2 && without_delivery == false){
					d = d - 2;
					i = i - 1;
					ch = 'W';
					ch1 = 'D';
					without_delivery = true;
					goto label;
				}
				else if(space[i - 1][j].distance2 == space[i][j].distance2 - 1 && without_delivery == true){
					d = d - 1;
					i = i - 1;
					ch = 'D';
					goto label;
				} 
				else if(space[i][j].box == 'W' && space[i][j].distance2 == space[i - 1][j].distance1 + 3 && without_delivery == true){
					d = d - 3;
					i = i - 1;
					ch = 'W';
					ch1 = 'D';					
					without_delivery = false;
					goto label;
				}
			}	
		}
		if((i + 1) <= N){
			if(space[i + 1][j].box != 'X'){
				if(space[i + 1][j].distance1 == (space[i][j].distance1 - 2) && without_delivery == false){
					d = d - 2;
					i = i + 1;
					ch = 'U';
					goto label;
				}
				else if(space[i][j].box == 'W' && space[i + 1][j].distance2 == space[i][j].distance1 - 2 && without_delivery == false){
					d = d - 2;
					i = i + 1;
					ch = 'W';
					ch1 = 'U';
					without_delivery = true;
					goto label;
				}
				else if(space[i + 1][j].distance2 == space[i][j].distance2 - 1 && without_delivery == true){
					d = d - 1;
					i = i + 1;
					ch = 'U';
					goto label;
				} 
				else if(space[i][j].box == 'W' && space[i][j].distance2 == space[i + 1][j].distance1 + 3 && without_delivery == true){
					d = d - 3;
					i = i + 1;
					ch = 'W';
					ch1 = 'U';					
					without_delivery = false;
					goto label;
				}
			}			
		}
		if((j - 1) >= 0){
			if(space[i][j - 1].box != 'X'){
				if(space[i][j - 1].distance1 == (space[i][j].distance1 - 2) && without_delivery == false){
					d = d - 2;
					j = j - 1;
					ch = 'R';
					goto label;
				}
				else if(space[i][j].box == 'W' && space[i][j - 1].distance2 == space[i][j].distance1 - 2 && without_delivery == false){
					d = d - 2;
					j = j - 1;
					ch = 'W';
					ch1 = 'R';
					without_delivery = true;
					goto label;
				}
				else if(space[i][j - 1].distance2 == space[i][j].distance2 - 1 && without_delivery == true){
					d = d - 1;
					j = j - 1;
					ch = 'R';
					goto label;
				} 
				else if(space[i][j].box == 'W' && space[i][j].distance2 == space[i][j - 1].distance1 + 3 && without_delivery == true){
					d = d - 3;
					j = j - 1;
					ch = 'W';
					ch1 = 'R';					
					without_delivery = false;
					goto label;
				}
			}			
		}
		if((j + 1) <= M){
			if(space[i][j + 1].box != 'X'){
				if(space[i][j + 1].distance1 == (space[i][j].distance1 - 2) && without_delivery == false){
					d = d - 2;
					j = j + 1;
					ch = 'L';
					goto label;
				}
				else if(space[i][j].box == 'W' && space[i][j + 1].distance2 == space[i][j].distance1 - 2 && without_delivery == false){
					d = d - 2;
					j = j + 1;
					ch = 'W';
					ch1 = 'L';
					without_delivery = true;
					goto label;
				}
				else if(space[i][j + 1].distance2 == space[i][j].distance2 - 1 && without_delivery == true){
					d = d - 1;
					j = j + 1;
					ch = 'L';
					goto label;
				} 
				else if(space[i][j].box == 'W' && space[i][j].distance2 == space[i][j + 1].distance1 + 3 && without_delivery == true){
					d = d - 3;
					j = j + 1;
					ch = 'W';
					ch1 = 'L';					
					without_delivery = false;
					goto label;
				}
			}						
		}
		goto label1;
label:
		h1 = malloc(sizeof(struct print_node));
		h1 -> next = h;
		h = h1;
		h1 -> c = ch;
		if(ch1 != ' '){
			h1 = malloc(sizeof(struct print_node));
			h1 -> next = h;
			h = h1;
			h1 -> c = ch1;			
		}
		ch1 = ' ';		
	}
	while(h != NULL){
		printf("%c",h -> c);
		h = h -> next;
	}
	return 0;
}
