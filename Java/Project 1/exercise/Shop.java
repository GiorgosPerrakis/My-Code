package exercise;

import java.util.ArrayList;

public class Shop {
	private	int id;
	private String brand_name;
	private String address;
	private String phone;
	private static int count = 0;
	static ArrayList <Product> products = new ArrayList <Product>();
	static ArrayList <Shop> shops = new ArrayList <Shop>();

	public Shop(String brand_name, String address, String phone) {
		this.brand_name = brand_name;
		this.address = address;
		this.phone = phone;
		this.id = ++count;
		shops.add(this);
	}

  public static void printAllShops() {
		for(Shop s: shops) {
			System.out.print(s.id + "  " + s.brand_name + "  " + s.address + "  " + s.phone + "\n");
		}
	}

	public static void filterAndPrintShops(String input) {
		for(Shop s: shops) {
			if(s.brand_name.toLowerCase().contains(input))
				System.out.print(s.id + "  " + s.brand_name + "  " + s.address + "  " + s.phone + "\n");
		}
	}

}
