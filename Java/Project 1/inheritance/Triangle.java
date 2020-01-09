package inheritance;
// Define Triangle, subclass of Shape
public class Triangle extends Shape {
   // Private member variables
   private double base;
   private double height;

   // Constructor
   public Triangle(String color, double base, double height) {
      super(color);
      this.base = base;
      this.height = height;
   }

   @Override
   public String toString() {
      return "Triangle of base = " + base + ", height = " + height + " and of area = "+getArea();
   }

   @Override
   public double getArea() {
      return 0.5*base*height;
   }
}