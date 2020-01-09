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

int a,b,x,i,j,cn,zero1,zero2;
char k[1000000];
char *p;
int counter;
bool flag,check,equal;

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
    if(x==0) printf("No input number found\n");
    else if(x==1)
    {
        cn=1;  
        for(i=1; i<M[0]-'0'; i++)
        {
            if(i+i==M[0]-'0')
            {
               k[0]=i;
               break;
            }
        }
    }
    else 
    { 
        equal=false;
        i=0;
        j=x-1;  
        a=0;
        zero1=0;
        zero2=j;
        if(zero2-zero1==1) check=false;
        else check=true;
        M[zero1]=M[zero1]-'0';
        if(zero1!=zero2)  { M[zero2]=M[zero2]-'0'; equal=true; }
        if ((M[i]==M[j]) || ((M[i] - 1)==M[j]) || ((M[i]*10+M[i+1]-'0'-1)==M[j]))    b=x-1;
     
        else if((((M[i]*10)+(M[i+1]-'0'))==(M[j]+10)) || (((M[i]*10)+(M[i+1]-'0')-1)==(M[j]+10)))  b=x-2;
    
        cn=b+1;    
        counter=1; 
        p = function(M);
    }
}

void display_output()
{
    int w=0; 
    printf("\n");
    if (k[0] != 0)
    {
        while(w < cn)  
        {
            printf("%d",k[w]);
            w++;
        }
        printf("\n");
    }
    else
        printf("No\n");
}


char *function(char s[])
{
     zero1++;
     zero2--;
     if(x%2!=0)
     {
       if(zero1<zero2)
       {
          s[zero1] = s[zero1]-'0';    
          s[zero2] = s[zero2]-'0';
       }    
       else if (zero1==zero2)
          s[zero1] = s[zero1]-'0';
     }
     else
     {
        if(check==true && equal==true)
        {
          if (zero2-zero1==1) check=false;             
          s[zero1] = s[zero1]-'0';    
          s[zero2] = s[zero2]-'0';
       }  
     }      
    int temp1,temp2; 
     
    if ((s[i]==s[j]) || ((s[i] - 1)==s[j]) || ((s[i]*10+s[i+1]-1)==s[j])) 
        flag=false;   
        
    else if(((s[i]*10+s[i+1])==(s[j]+10)) || ((s[i]*10+s[i+1]-1)==(s[j]+10))) 
        flag=true;              
   if (flag==false)   //1st, 2nd or 3rd case       
   {       
      int d=0,e=s[j]; 
      while(1)
      {
          d++;
          e--;    
          if ((d+e==s[j])&&(e<10)) break;
      }
      temp1 = s[i];                
      temp2 = s[j];        
      s[i] = temp1 - temp2;  
      if (s[i]==0) i++; 
      s[j] = 0;
      j--;                                                     //while in the else....k[a]....
      if((x/2==counter)&&(s[j]!=0)) 
      {
           flag = true;
           if(s[i-1]==0) i--;
           s[i] = temp1;
           j++;
           s[j] = temp2;
           if(counter==1) 
           {
              b--;
              cn--;
           }
      }   
      else
      {        
         k[a] = d; 
         a++;
         k[b] = e;
         b--;
      }
   }
   if(flag==true) //4th or 5th case       
   {           
      int d=0,e=s[j]+10; 
      while(1)
      {
          d++;
          e--;    
          if ((d+e==(s[j]+10))&&(e<10)) break;
      } 
      temp1=((s[i]*10+s[i+1])-(s[j]+10))/10;
      temp2= ((s[i]*10+s[i+1])-(s[j]+10))%10;
      s[i] = temp1;
      i++;
      s[i] = temp2; 
      s[j] = 0;
      j--;
      s[j]--;   
      if((x/2==counter)&&(s[j]!=0)) 
           flag=false;  
      else
      { 
          k[a] = d; 
          a++;
          k[b] = e;
          b--;
      }      
   }
   counter++;
   if(counter > x/2)
       return 0;   
   else     
       return function(s);
}
