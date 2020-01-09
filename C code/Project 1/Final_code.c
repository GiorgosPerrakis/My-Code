#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>

void open_file();
void display_output();
char *function(char n[]);

int a,b,x,i,j,cn;
char N[1000000];
char *p;
int counter,flag,flag2,r;
bool check;

clock_t begin, end;
double time_spent;

int main()
{  
    r=0;
    open_file();     
    display_output();
    return 0;
}

void open_file()
{
    FILE *fp;
    char M[1000000],name[30];   
    printf("Give file name:");
    gets(name);    
    fp=fopen(name,"r"); 
	begin = clock();                                          //open given file
    fscanf(fp,"%s",M);                                            //read inpup number
    fclose(fp);
    x = strlen(M);                                               //calculate digits of input number
    check=false;
    if(x==0) printf("No input number found\n");                   //empty file
    else if(x==1)                  
    {
        cn=1;  
        if((M[0]-'0')%2==0)
        {
           N[0] = (M[0]-'0')/2;
           check=true;
        }
    }
    else if(x==2)                                                 //check numbers with only two digits
    {
        cn=2;  
        for(i=10; i < ((M[0]-'0')*10+M[1]-'0'); i++)
        {
            if((i+(i%10)*10+i/10)==((M[0]-'0')*10+M[1]-'0'))
            {                                                           
               N[0]=i/10;
               N[1]=i%10;
               check=true;
               break;
            }
        }
    }
    else                                                        //check numbers with more than two digits
    { 
        i=0; 
        j=x-1; 
        a=0;
        int h=0;
        while(h < x)
        {
            M[h]=M[h]-'0';
            h++;
        }      
		if(M[i]==M[j] && M[i+1]==M[j-1]) { flag2=1; b = x-1; }
        
        else if((((M[i]*10)+M[i+1])==(M[j]+10)) || (((M[i]*10)+M[i+1]-1)==(M[j]+10)) || ((M[i]*10+M[i+1]-1)==M[j])) {  b=x-2; flag2=0; } 
    
        else if ((M[i]==M[j]) || ((M[i] - 1)==M[j]))   { b=x-1; flag2=1; }                        //determines the size of number N that we are looking for
        
        else { printf("0\n"); exit(2); }
		
        cn=b+1;    
        p = function(M);                                         //call function that through recursion creates the number N
    }
}

char *function(char s[])
{ 
    int temp,temp1; 
    
    if((((s[i]*10+s[i+1])==(s[j]+10)) || ((s[i]*10+s[i+1]-1)==(s[j]+10)) || ((s[i]*10+s[i+1]-1)==s[j])) && flag2==0)                        //check in which case are we
        flag=0;
    else if (((s[i]==s[j]) || ((s[i] - 1)==s[j])) && flag2==1) 
	    flag=1;     
    else
        flag=2; 
        
   if(flag==0)                                                                        //1st, 2nd or 3rd case       
   {
      int d,e,f;    
      if((s[i]*10+s[i+1]-1)==s[j])
      {
          d=0; e=s[j]; f=e;       	               
	      temp1 = s[i]*10+s[i+1];
	      s[i] = 0;
	      i++;
	      s[i] = temp1-f;                                                       //subtract the right digit from both right and left digits
	      s[j] = 0;
          j--;                                                                            
	  }
      else
      {
          d=0; e=s[j]+10; f=e;       	
      	  temp= ((s[i]*10+s[i+1])-(s[j]+10));
          s[i] = 0;
          i++;
          s[i] = temp;                                                         //subtract the right digit from the two left digits and from the right digit
          s[j] = 0;
          j--;
          if(s[j]!=0) s[j]--; 
          else 
	      {
	  	     int q = j;
	  	     while(s[q]==0 && q>i)
	  	    {
	  		   s[q] = 9;
	  		   q--;
		    }
		    if((q==i)&&s[q]==0) { printf("0\n"); exit(2); } 
		    else s[q]--;
	      }
	  }
	  if(i<j)
	  {
         if (s[i]==0) { i++; flag2=1; }
         else flag2=0; 
	  }
	  if(f==0) { d=0; e=0;  }
	  else
	  {
	  	 while(1)                                                               //find two numbers with sum equal to the right digit +10
         {
           d++;
           e--;    
           if ((d+e==f)&&(e<10)) break;
         } 
	  }       
      N[a] = d;                                                           //store the two numbers to N
      a++;
      N[b] = e;
      b--;
      if(i==j)
      {
        if(s[j]%2==0)
        {
            if(s[j]!=0) N[a]=s[j]/2;   
			check=true;     
        }
        else  { check=false;  flag=2; }
      }
	  else if(i==(j-1))
	  {
	  	if(flag2==1)
	  	{
	  		if(s[i]==s[j]) 
	  		{
                N[a] = s[j];
                check=true;
			}
			else { check=false;  flag=2; }
		}
		else
		{	
		  	if((s[i]*10+s[j])%2==0)
            {
                N[a]=(s[i]*10+s[j])/2;
                check=true;
            }
            else { check=false;  flag=2; }
		}
	  }
	  else if(i > j) { check=false;  flag=2; }
   }    	                    
   else if(flag==1)                                                                               //4th or 5th case       
   {   
      int d=0,e=s[j],f=e; 
      s[i] = s[i] - s[j];  
      if (s[i]==0) { i++; flag2=1; }
      else flag2=0;
      s[j] = 0;
      j--; 
	  if(f==0) { d=0; e=0;  }
	  else
	  {
	  	 while(1)                                                               //find two numbers with sum equal to the right digit +10
         {
           d++;
           e--;    
           if ((d+e==f)&&(e<10)) break;
         } 
	  }         
      N[a] = d;                                                                    //store the two numbers to N
      a++;
      N[b] = e; 
      b--;
      if(i==j)
      {
          if(s[j]%2==0)
          {
              if(s[j]!=0) N[a]=s[j]/2; 
              check=true;
          }
          else  { check=false;  flag=2; }
      }
	  else if(i==(j-1))
	  {
	  	if(flag2==1)
	  	{
	  		if(s[i]==s[j]) 
	  		{
                N[a] = s[j];
                check=true;
			}
			else { check=false;  flag=2; }
		}
		else
		{	
		  	if((s[i]*10+s[j])%2==0)
            {
                N[a]=(s[i]*10+s[j])/2;
                check=true;
            }
            else { check=false;  flag=2; }
		}
	  }
	  else if(i > j) { check=false;  flag=2;  } 
   }
   if(flag==2)
        return 0;
   else     
   {
   	    if((i==j)||(i==j-1)) return 0;                            //finish if we have checked all digits 
        else {  printf("r = %d\n",r); r++; return function(s);  }                               //else continue
   }
}

void display_output()                                            //function that displays output
{
    int w=0;
    if (check==true)
    {
        while(w < cn)  
        {
            printf("%d",N[w]);
            w++;
        }
        printf("\n");
    }
    else
        if(x!=0) printf("0\n");
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC; 
    printf("Elapsed: %f seconds\n", time_spent);    
}
