package exercise;

import java.util.ArrayList;

public abstract class Customer {
	static ArrayList  <Customer> customers = new ArrayList <Customer>();
	public String name;
	public String surname;
	public String phone;
	public String address;

	public Customer(String name, String surname, String phone, String address) {
		this.name = name;
		this.surname = surname;
		this.phone = phone;
		this.address = address;
		customers.add(this);
	}

	public String getName() {
		return name;
	}

}
