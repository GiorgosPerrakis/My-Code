package exercise2_2018_2019_8110111;

import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO provides all the necessary methods related to user's. 
 * In further lessons we will change all the code of the body of the methods and use
 * JDBC API in order to connect the the database and store/retrieve users etc.
 * 
 * @author sofos@aueb.gr
 *
 */
public class UserDAO {
		
	/**
	 * This method returns a List with all Users
	 * 
	 * @return List<User>
	 */
	public List<User> getUsers() {

		List<User> users = new ArrayList<User>();
		
		// adding some users for the sake of the example
		users.add(new User("John", "Doe", "jdoe@somewhere.com", "jdoe", "1111"));
		users.add(new User("Mary", "Smith", "msmith@somewhere.com", "msmith",  "1111"));
		
		return users;

	} //End of getUsers

	/**
	 * Search user by username
	 * 
	 * @param username, String
	 * @return User, the User object
	 * @throws Exception, if user not found
	 */
	public User findUser(String username) throws Exception {

		List<User> users = getUsers();

		for (User user : users) {

			if ( user.getUsername().equals(username) ) {
				return user;
			}

		}
		
		throw new Exception("User with username: " + username + " does not exist");
		
	} //End of findUser

	/**
	 * Checks if the credentials are valid.
	 * 
	 * @param username, String
	 * @param password, String
	 * @throws Exception, if the credentials are not valid
	 */
	public void authenticate(String username, String password) throws Exception {

		List<User> users = getUsers();

		for (User user : users) {

			if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
				return; // credentials are valid, so do nothing (return)
			}

		}
		//Wrong credentials
		throw new Exception("Wrong username or password");
		
	} //End of authenticate

} //End of class
