package exercise;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		loadObjects();
		while(true) {
			try {
				printMenu();
			}
			catch(InputMismatchException ex) {
				System.out.println();
			}
		}

	}

	private static void printMenu() throws InputMismatchException{
		Scanner scanner  = new Scanner(System.in);
		System.out.print(" ~~~~~~ Welcome to E-Order ~~~~~~ \n"
				+ "(1) Sign Up | "
				+ "(2) Sign In | "
				+ "(3) Continue as visitor\n Make your choice : ");

		String choice = scanner.nextLine();

		if(choice.equals("")) return;

		int k = Integer.parseInt(choice);

		switch(k) {
		case 1:
			getMenu();
			break;
		case 2:
			String name = RegisteredCustomer.getMenu();
			if(name != null) {
				System.out.print("\n" + "Hello " + name + "\n");
				while(true) {
					System.out.print("\n" + "Insert Brand Name: ");
					String input = scanner.nextLine();
					System.out.print("\n");

					if(input.equals(""))
						Shop.printAllShops();
					else
						Shop.filterAndPrintShops(input);
				}
			}
			else
				System.out.print("\n" + "Wrong email or password\n" + "\n");
			break;
		case 3:
			while(true) {
				System.out.print("\n" + "Insert Brand Name: ");
				String input = scanner.nextLine();
				System.out.print("\n");

				if(input.equals(""))
					Shop.printAllShops();
				else
					Shop.filterAndPrintShops(input);
			}
		}

	}

	public static void getMenu() {
		Scanner scanner  = new Scanner(System.in);

		System.out.print("Enter name: ");
		String name = scanner.next();

		System.out.print("Enter surname: ");
		String surname = scanner.next();

		System.out.print("Enter phone: ");
		String phone = scanner.next();

		System.out.print("Enter address: ");
		String address = scanner.next();

		System.out.print("Enter email: ");
		String email = scanner.next();

		System.out.print("Enter password: ");
		String password = scanner.next();

	 new RegisteredCustomer(name, surname, phone, address, email, password);
	}

	private static void loadObjects() {
		new RegisteredCustomer("Kostas", "Papadopoulos", "6971235891", "Tinou 23, Chalandri", "kostas@gmail.com", "kostaspap");
		new RegisteredCustomer("Antonis", "Spiropoulos", "6912450922", "Makedonias 11, Elliniko", "antonis@gmail.com", "antonis88");
		new RegisteredCustomer("Maria", "Zahariou", "6997120012", "Venizelou 87 Nea Ionia", "maria@gmail.com", "maria123");
		new Shop("Coffee Lab", " Keramikou 9, Katehaki", "2101673815");
		new Shop("CoffeeMania", "Tinou 22, Nea Ionia  ", "2107623910");
		new Shop("Bestcoffee", " Ventouri 17, Holargos", "2100613019");
		new Shop("Pizza Fun", "  Pindou 34, Panormou  ", "2107623915");
		new Shop("Burger King", "Sirou 56, Neos Kosmos", "2106723087");
		new Shop("Souvlaki", "   Fidiou 12, Hlioupoli ", "2109912043");
	}

}
