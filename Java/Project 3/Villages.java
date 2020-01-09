import java.util.ArrayList;
import java.util.Scanner;
import java.io.*;

public class Villages
{
	public static void main(String[] args)
	{
		File f = null;

		if (args.length == 1)
			f = new File(args[0]);
		else
		{
			System.err.println("Wrong number of parameters.");
			System.exit(21);
		}

		try
		{
			Scanner s = new Scanner(f);

			int N, M, K, first, second, i;

		   	N = s.nextInt();
		 	M = s.nextInt();
		  	K = s.nextInt();

		   	int[] table = new int[N+1];

		   	for(i = 1; i <= N; i++) table[i] = -1;

			update_table(table, s, M);

			System.out.printf("%d\n", result(table, N, K));
		}
		catch(Exception exc)
		{
		   System.out.println("File Not Found");
	    }
    }


	public static void update_table(int[] village, Scanner scan, int m)
	{
		int first, second;

		for(int i = 0; i < m; i++)
		{
			first = scan.nextInt();
			second = scan.nextInt();

			if(village[first] == -1 && village[second] == -1)
			{
				village[first] = -2;
				village[second] = first;
			}
			else if(village[first] == -1 && village[second] < 0)
			{
				village[first] = second;
				village[second] = village[second] - 1;
			}
			else if(village[first] < 0 && village[second] == -1)
			{
				village[second] = first;
				village[first] = village[first] - 1;
			}
			else if(village[first] == -1 && village[second] >= 0)
			{
				village[first] = second;
				update_parent(village, second, second, 0);
			}
			else if(village[first] >= 0 && village[second] == -1)
			{
				village[second] = first;
				update_parent(village, first, first, 0);
			}
			else if(village[first] < 0 && village[second] < 0 && village[first] > village[second])
			{
				village[second] = village[first] + village[second];
				village[first] = second;
			}
			else if(village[first] < 0 && village[second] < 0 && village[first] <= village[second])
			{
				village[first] = village[first] + village[second];
				village[second] = first;
			}
			else if(village[first] < 0 && village[second] >= 0)
			{
				update_parent(village, first, second, 1);
			}
			else
			{
				update_parent(village, first, second, 1);
			}
		}
	}

	public static void update_parent(int[] village, int first, int second, int x)
	{
		int a;

		if(first == second && village[first] < 0 && x == 0)
			village[second] = village[second] - 1;
		else if(first == second && village[first] < 0 && x == 1)
			a = 0;
		else if(village[first] >= 0 && village[second] >= 0)
			update_parent(village, village[first], village[second], x);
		else if(village[first] >= 0)
			update_parent(village, village[first], second, x);
		else if(village[second] >= 0)
		{
			update_parent(village, first, village[second], x);
		}
		else if(village[first] >= village[second])
		{
			village[second] = village[first] + village[second] + 1;
			village[first] = second;
		}
		else
		{
			village[first] = village[first] + village[second] + 1;
			village[second] = first;
		}
	}

	public static int result(int[] village, int N, int K)
	{
		int counter = 0;
		for(int j = 1; j <= N; j++)
		{
			if(village[j] < 0) counter++;
		}

		if(counter > K)
			counter = counter - K;
		else
			counter = 1;

		return counter;
	}
}









