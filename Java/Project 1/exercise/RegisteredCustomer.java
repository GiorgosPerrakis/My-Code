package exercise;

import java.util.Scanner;

public class RegisteredCustomer extends Customer{
	private	int id;
	private String email;
	private String password;
	private static int count = 0;

	public RegisteredCustomer(String name, String surname, String phone, String address, String email, String password) {
		super(name, surname, phone, address);
		this.email = email;
		this.password = password;
		this.id = ++count;
	}

	public static String logIn(String email, String password) {
		for(Customer cus: customers) {
			if (cus instanceof RegisteredCustomer) {
				RegisteredCustomer reg_cus = (RegisteredCustomer) cus;
				if(reg_cus.email.equals(email) && reg_cus.password.equals(password)) {
					Customer customer = (Customer) reg_cus;
					return customer.name;
				}
			}
		}
		return null;
	}

	public static String getMenu() {
		Scanner scanner  = new Scanner(System.in);

		System.out.print("Enter email: ");
		String email = scanner.next();

		System.out.print("Enter password: ");
		String password = scanner.next();

		String name  = logIn(email, password);

		return name;
	}

}
