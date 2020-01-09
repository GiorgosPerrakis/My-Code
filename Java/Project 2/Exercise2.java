
import java.io.File;
import java.util.Scanner;
import java.util.Arrays;

class Exercise2
{
   public static void main(String args[])
   {
	   int N,B,H,W,L,V,temp,i=0,k,sum=0,h=0;

	   try
	   {
		   File f = new File("numbers.txt");
		   Scanner input = new Scanner(f);
     	   N = input.nextInt();

     	   int[][] dek = new int[N][4];

           for( int row = 0; row < N; row++ )
           {
			   for( int column = 0; column < 4; column++ )
	     	   {
				   dek[row][column] = input.nextInt();
			   }
		   }

		   wholeV = input.nextInt();

	    /*   for( int row = 0; row < N-1; row++ )
           {

              if(dek[row+1][0] < dek[row][0])
              {
				  for( int i = 0; i < 4; i++)
				  {
					  temp = dek[row+1][i];
					  dek[row+1][i] = dek[row][i];
					  dek[row][i] = temp;
				  }
			  }
	       }

	       for( int row = 0; row < N; row++ )
           {
	         for( int column = 0; column < 4; column++ )
	         {
	            System.out.printf("%d  ",dek[row][column]);
	         }
	         System.out.printf("\n");
	       }
	   */
	   while(true)
	   {
		   v = (dek[i+1][0]-dek[i][0])*dek[i][2]*dek[i][3];
		   if(v <= whole)
		   {
			   whole -= v;
		   }
		   else
		   {
			   for(k = 0; k < N; k++)
			   {
				   if(dek[k][0]==dek[k+1][0]) sum = dek[k][2] * dek[k][3];
				   else break;
			   }
			   if(sum != 0) h = whole / sum;




		   }
		   i++;
	   }






	   }
	   catch(Exception exc)
	   {
		   System.out.println("File Not Found");
	   }
    }
 }