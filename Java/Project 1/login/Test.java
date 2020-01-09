package login;

import java.util.Scanner;
public class Test {

	public static void main(String[] args) {
		Scanner scanner = new Scanner (System.in);

		new User("Maria");
		new User("Sofia");
		new Premium("Anna");
		new Premium ("Giannis");
		new Premium("Marianna");
		new Premium("Eleni-Maria");		

		System.out.print("-- Search by id : ");
		int id = scanner.nextInt();
		Premium user  =  null;

		while ((user = Premium.searchById(id))==null) {
			System.out.print("User id does not exists, try again : ");
			id = scanner.nextInt();
		}

		System.out.println("Hello "+user.getId());

		System.out.print("-- Search by name : ");
		String name =  scanner.next();
		User.searchByName(name);
	}
}
