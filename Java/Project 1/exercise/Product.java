package exercise;

public class Product {
	private	int id;
	private String name;
	private String price;
	private static int count = 0;

	public Product(String name, String price) {
		this.name = name;
		this.price = price;
		this.id = ++count;
	}

	public String toString() {
		return "Product: " + name + ", price : " + price + "\n";
	}

}
