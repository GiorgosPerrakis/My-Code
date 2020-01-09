package inheritance;
public class TestShape {
	public static void main(String[] args) {
		Shape s1 = new Rectangle("red", 4.3, 5);   
		System.out.println(s1);
		//Rectangle s2 = Shape ("red"); wrong statement 		

		Shape s2 = new Triangle("blue", 4.6, 5);
		System.out.println(s2);

		Shape s3 = new Shape("yellow");
		System.out.println(s3);

	}
}