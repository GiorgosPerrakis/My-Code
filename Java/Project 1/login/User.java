package login;

import java.util.ArrayList;

public class User {
	private static ArrayList<User> people = new ArrayList<User> ();
	private String name;

	public User(String name) {
		this.name = name;
		people.add(this);
	}

	public static ArrayList<User> getUsers() {
		return people;
	}

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "User [name=" + name + "]";
	}
	public static void searchByName(String name) {
		for(User user: User.getUsers()) {
			if (user.getName().toLowerCase().contains(name.toLowerCase())) {
				if(user instanceof Premium) {
					System.out.print("Premium : ");
				}
				else System.out.print("User : ");
				System.out.println(user.getName() );
			}
		}
	}

}