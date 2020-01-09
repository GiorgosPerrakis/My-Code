package inheritance;

public class Rectangle extends Shape {
	// Private member variables
	private double length;
	private double width;

	// Constructor
	public Rectangle(String color, double length, double width) {
		super(color);
		this.length = length;
		this.width = width;
	}

	@Override
	public String toString() {
		return "Rectangle of length = " + length + ", "
				+ "width = " + width + " "
				+ "and of area = "+getArea();
	}

	@Override
	public double getArea() {
		return length*width;
	}
}
