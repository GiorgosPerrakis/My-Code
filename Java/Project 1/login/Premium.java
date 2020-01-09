package login;

public class Premium extends User{
	private static int count = 0;
	private int id;

	public Premium(String name) {
		super(name);
		this.id = ++count;
	}

	public static Premium searchById(int id) {
		for(User user: User.getUsers()) {
			if (user instanceof Premium) {
				Premium premium = (Premium) user;
				if(premium.id == id) {
					premium = (Premium) user;
					return premium;
				}
			}
		}
		return null;
	}
	int getId(){
		return id;
	}

}
