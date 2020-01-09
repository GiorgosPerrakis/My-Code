import java.util.Scanner;

public class MaxFinder
{
	public void determineMax()
	{
		Scanner input = new Scanner(System.in);

		System.out.print("Give two numbers\n");

		int num1 = input.nextInt();
		int num2 = input.nextInt();

		int result;

		result = maximum(num1,num2);

		System.out.println("maximum is "+ result);
	}

	public int maximum (int x,int y)
	{
		int max = x;

		if(y > x) max = y;

		return max;
	}

}
