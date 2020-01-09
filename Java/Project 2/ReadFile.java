
import java.io.File;
import java.util.Scanner;

class ReadFile
{
   public static void main(String args[])
   {
	   int i;
	   try
	   {
		   File f = new File("numbers.txt");
		   Scanner s = new Scanner(f);
		   while( s.hasNextInt() )
		   {
			   i = s.nextInt();
			   System.out.printf("%d\n",i);
		   }
	   }
	   catch(Exception exc)
	   {
		   System.out.println("File Not Found");
	   }
    }
 }
















