#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct AuthorRecord  //struct for texts list//
{
    char *textTitle;
    int NumberOfWords;
    long Download;
    struct AuthorRecord *next;
};
typedef struct AuthorRecord *AuthorRecordType; 


typedef struct  //struct for authors//
{
    char *firstName;
    char *lastName;
    int idNumber;
    AuthorRecordType text;
} AuthorType;


struct MemberNodeStruct  //the struct for authors list//
{
    AuthorType *anAuthor;
    struct MemberNodeStruct *next;
};
typedef struct MemberNodeStruct *MemberNodeType;


MemberNodeType member_head,new_node1;
MemberNodeType find_place1(char lex1[],char lex2[]);

AuthorRecordType text_head,new_node2;
AuthorRecordType find_place2(char lex3[]);

void add_node_to_list_members(char lex1[],char lex2[],int number1);
void add_node_to_list_texts(char lex3[],int number2);
void display_all();
void read_all();


MemberNodeType find_place1(char lex1[], char lex2[])
{
	MemberNodeType p,tp;
	p=member_head;
	tp=NULL;
	while(p!=NULL)
	{
		if(strcmp(lex1,p->firstName)==1) tp=p;
		else if (strcmp(lex1,p->anAuthor->firstName)==0)
             if (strcmp(lex2,p->anAuthor->lastName)==1) tp=p;
	    p=p->next;
	}
	return tp;
}


void add_node_to_list_members(char lex1[], char lex2[],int number1)
{
	MemberNodeType temp_next,thesi;
	thesi=find_place1(lex1,lex2);
	new_node1 = (MemberNodeType *)malloc(sizeof(struct MemberNodeStruct));
	strcpy(new_node1->anAuthor->firstName,lex1);
	strcpy(new_node1->anAuthor->lastName,lex2);
	strcpy(new_node1->anAuthor->idNumber,number1);
	if(thesi==NULL)
	{
	 	if(member_head!=NULL)
		{
			new_node1->next=member_head;
			member_head=new_node1;
		}
		else
		{
			new_node1->next=NULL;
			member_head=new_node1;
		}
	}
	else
	{
		temp_next=thesi->next;
		thesi->next=new_node1;
		new_node1->next=temp_next;
	}
}


AuthorRecordType find_place2(char lex3[])
{
	AuthorRecordType p,tp;
	p=text_head;
	tp=NULL;
	while(p!=NULL)
	{
		if(strcmp(lex3,p->textTitle)==1) tp=p;
	    p=p->next;
	}
	return tp;
}


void add_node_to_list_texts(char lex3[],int number2)
{
	AuthorRecordType temp_next,thesi;
	thesi=find_place2(lex3);
	new_node2 = (AuthorRecordType *)malloc(sizeof(struct AuthorRecord));
	strcpy(new_node2->textTitle,lex3);
	if(thesi==NULL)
	{
	 	if(text_head!=NULL)
		{
			new_node2->next=text_head;
			text_head=new_node2;
		}
		else
		{
			new_node2->next=NULL;
			text_head=new_node2;
		}
	}
	else
	{
		temp_next=thesi->next;
		thesi->next=new_node2;
		new_node2->next=temp_next;
	}
}


int find_text(char txt,AuthorRecordType k)
{
	 AuthorRecordType k,m;
	 k=text_head;
	 while (k!=NULL)
	 {
		   if 
		   if (strcmp(txt,k->textTitle)==0) m=k;
		   k=k->next;
	 }
	 return m;
}     





AuthorRecordType sum_downloads(int x)
{
	 AuthorRecordType x;
	 x=text_head;
	 int b=0;
	 while (x!=NULL)
	 {
		   b=b+(x->textTitle)
	 }
}


void read_all()
{
	FILE *fp;
	char lex1[100],lex2[100],lex3[100];
	int i,j,N,number1,NumberOfTexts,number2,a;
	fp=fopen("onomata.txt","r");
	fscanf(fp, "%d", &N);
	for (i=0; i<N; i++)
	{
        	while(!feof(fp))
	        {
		       fscanf(fp,"%s",lex1);
        	   fscanf(fp,"%s",lex2);
		       fscanf(fp,"%d",&number1);
		       add_node_to_list_members(lex1,lex2,number1);
               fscanf(fp,"%d",&NumberOfTexts); //number of texts that he wrote//
               for (j=1; j<=NumberOfTexts; j++)
               {
                    fgets(lex3,30,fp);
                    fscanf(fp,"%d",&number2); //downloads//
                    add_node_to_list_texts(lex3,number2);
                    if (j==1) continue;
                    sum=find_text(lex3);
                    a=sum_downloads(
               }
            }
    } 
 
    fclose(fp);     
}


void display_all()
{
	MemberNodeType *p;
	p=member_head;
	while(p!=NULL)
	{
		printf("%s\n",p->anAuthor->firstName);
		printf("%s\n",p->anAuthor->lastName);
		printf("%d\n",p->anAuthor->idNumber);
		p=p->next;
	}
}


int main(void)
{
	member_head=NULL;
	text_head=NULL;
	read_all();
	display_all();
	system("pause");
	return 0;
}







