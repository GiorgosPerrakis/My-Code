#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>

void open_file();
void display_output();
char *function(char n[]);

clock_t begin, end;
double time_spent;

int a,b,x,i,j,cn;
char k[1000000];
char *p;
int counter,flag;
bool check;

int main()
{
    begin = clock();  
    open_file();    
    display_output();
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC; 
    printf("Elapsed: %f seconds\n", time_spent);
    system ("pause");
    return 0;
}


void open_file()
{
    FILE *fp;
    char M[1000000],name[30];   
    printf("Give file name:");
    gets(name);    
    fp=fopen(name,"r");
    fscanf(fp,"%s",M);
    fclose(fp);
    x = strlen(M); 
    printf("%d\n",x);
    check=false;
    if(x==0) printf("No input number found\n");
    else if(x==1)
    {
        cn=1;  
        for(i=1; i<M[0]-'0'; i++)
        {
            if(i+i==M[0]-'0')
            {
               k[0]=i;
               check=true;
               break;
            }
        }
    }
    else if(x==2)
    {
        cn=2;  
        for(i=10; i < ((M[0]-'0')*10+M[1]-'0'); i++)
        {
            if((i+(i%10)*10+i/10)==((M[0]-'0')*10+M[1]-'0'))
            {
               k[0]=i/10;
               k[1]=i%10;
               check=true;
               break;
            }
        }
    }
    else 
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
        if((((M[i]*10)+(M[i+1]))==(M[j]+10)) || (((M[i]*10)+(M[i+1])-1)==(M[j]+10)) || ((M[i]*10+M[i+1]-1)==M[j]))  b=x-2;
    
        else if ((M[i]==M[j]) || ((M[i] - 1)==M[j]))   b=x-1; 
        cn=b+1;    
        p = function(M);
    }
}

void display_output()
{
    int w=0; 
    printf("\n");
    if (check==true)
    {
        while(w < cn)  
        {
            printf("%d",k[w]);
            w++;
        }
        printf("\n");
    }
    else
        printf("0\n");
}


char *function(char s[])
{ 
    int temp1,temp2; 
     
    if(((s[i]*10+s[i+1])==(s[j]+10)) || ((s[i]*10+s[i+1]-1)==(s[j]+10))) 
        flag=1;
    else if ((s[i]==s[j]) || ((s[i] - 1)==s[j]) || ((s[i]*10+s[i+1]-1)==s[j])) 
        flag=0;       
    else
        flag=2;                     
   if(flag==0)   //1st, 2nd or 3rd case       
   {       
      int d=0,e=s[j]; 
      temp1 = s[i];                
      temp2 = s[j];        
      s[i] = temp1 - temp2;  
      if (s[i]==0) i++; 
      s[j] = 0;
      j--;                                                    
      while(1)
      {
          d++;
          e--;    
          if ((d+e==temp2)&&(e<10)) break;
      }         
      k[a] = d; 
      a++;
      k[b] = e;
      b--;
      if(i==j)
      {
          if(s[j]%2==0)
          {
             if(s[j]!=0)           
                k[a]=s[j]/2;
             check=true;
          }
          else 
             check=false;
      }   
   }
   else if(flag==1) //4th or 5th case       
   {           
      int d=0,e=s[j]+10,f=e; 
      temp1=((s[i]*10+s[i+1])-(s[j]+10))/10;
      temp2= ((s[i]*10+s[i+1])-(s[j]+10))%10;
      s[i] = temp1;
      i++;
      s[i] = temp2; 
      if (s[i]==0) i++;
      s[j] = 0;
      j--;
      s[j]--;   
      while(1)
      {
          d++;
          e--;    
          if ((d+e==f)&&(e<10)) break;
      }         
      k[a] = d; 
      a++;
      k[b] = e;
      b--;
      if(i==j)
      {
          if(s[j]%2==0)
          {
             if(s[j]!=0)          
                k[a]=s[j]/2;
             check=true;
          }
          else 
             check=false;
      }   
   }
   if(flag==2)
   {   
      if(i==j)
         return 0;
   }   
   else     
       return function(s);
}
