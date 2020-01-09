import java.util.ArrayList;
import java.util.Scanner;

public class villages
{
	public static void main(String[] args)
	{
		Scanner input = new Scanner(System.in);

		long W,sum,sumLeft,sumRight;
		boolean flag = false;//,flag1 = true;
		int N,i,j,k,counter = 1;
		int counterRight = 0,counterLeft = 0;

       // if(input.hasNextInt()) {
       //do{


		    int reloop = 0;
		     do {
		      try {
		           N = input.nextInt();


		  // while(!input.hasNextInt()) input.nextLine();

       //}while(!input.hasNextInt());
        //else flag1 = false;
		//if(input.hasNextInt())
		W = input.nextLong();
		//else flag1 = false;

        //if(flag1 == true) {
		long[] weights = new long[N];

        ArrayList< Long > left = new ArrayList< Long >();
        ArrayList< Long > right = new ArrayList< Long >();

        long[] displayLeft = new long[20];
		long[] displayRight = new long[20];

		for( i = 0; i < weights.length; i++ )
		{
			weights[i] = (long)Math.pow(3,i);
		}

		left.add(W);

		while(true)
		{
			sumLeft = 0;
			sumRight = 0;
			sum = 0;

			for( j = 0; j < left.size(); j++ ) sumLeft += left.get(j);
            for( j = 0; j < right.size(); j++ ) sumRight += right.get(j);
            for( k = 0; k < N-counter; k++ ) sum += weights[k];

            if( sumRight < sumLeft )
            {
				right.add(weights[k]);
				sumRight += weights[k];
				if( Math.abs( sumRight - sumLeft ) > sum )
				{
				   right.remove(weights[k]);
				   sumRight -= weights[k];
			    }
			    else if( sumRight - sumLeft == sum )
			    {
				  flag = true;
				  for( int s = k; s > 0; s-- )
				  {
					 displayLeft[counterLeft] = s;
				     counterLeft++;
				  }
				  displayRight[counterRight] = k+1;
				  counterRight++;
				  break;
			    }
                else if( Math.abs(sumRight - sumLeft) <= sum)
			    {
				    displayRight[counterRight] = k+1;
				    counterRight++;
			    }
			}
            else if( sumRight > sumLeft )
            {
				left.add(weights[k]);
				sumLeft += weights[k];
				if( Math.abs(sumRight - sumLeft) > sum )
				{
				   left.remove(weights[k]);
				   sumLeft -= weights[k];
			    }
			    else if( sumRight - sumLeft == sum )
			    {
				  flag = true;
				  for( int s = k; s > 0; s-- )
				  {
					 displayLeft[counterLeft] = s;
				     counterLeft++;
				  }
				  displayLeft[counterLeft] = k+1;
				  counterLeft++;
				  break;
			    }
                else if( Math.abs(sumRight - sumLeft) <= sum )
			    {
				    displayLeft[counterLeft] = k+1;
				    counterLeft++;
			    }
			}
			else
			{
				flag=true;
				break;
			}
			counter++;
			if( (sumRight - sumLeft != sum) && (sum == 0) )
			{
				flag = false;
				break;
			}
		}

		if( flag == true )
		{
			System.out.printf("[");
			for( int t = counterLeft-1; t >= 0 ; t-- )
			{
			    if( t != 0 ) System.out.printf("%d,",displayLeft[t]);
			    else System.out.printf("%d",displayLeft[t]);
		    }
		    System.out.printf("] ");

		    System.out.printf("[");
			for( int t = counterRight-1; t >= 0 ; t-- )
			{
			    if( t != 0 ) System.out.printf("%d,",displayRight[t]);
			    else System.out.printf("%d",displayRight[t]);
		    }
		    System.out.printf("]\n");
		}
		else
		{
			System.out.printf("[] []\n");
		}
	//}
			           reloop ++;
			     } catch (Exception e) {
			          System.out.println ("Please enter a number!");
			     }}
 while(reloop == 0);
	//else System.out.printf("[]\n");
	input.close();
    }
}