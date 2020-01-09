package user_package;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO provides all the necessary methods related to user's.
 * Use JDBC API in order to connect the the database and store/retrieve users etc.
 *
 * @author --nick_perrakis--
 *
 */
public class UserDAO {
	
	private String errorMessages = "";	

	/**
	 * This method returns a List with all Users
	 *
	 * @return List<User>
	 */
	public List<User> getUsers() throws Exception {

		Connection con = null;
		
		String sql= "SELECT * FROM users_2018_ex3_8110111";
		
		DB db = new DB();
				
		List<User> users = new ArrayList<User>();

		try {
			// open connection and get Connection object
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);

			// execute the SQL statement (QUERY - SELECT) and get the results in a ResultSet)
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
	 			users.add( new User(rs.getString("name"), rs.getString("surname"),rs.getString("email"), 
									rs.getString("username"), rs.getString("password")) );
			}

 			rs.close(); // closing ResultSet
			stmt.close(); // closing PreparedStatement 

			return users;
			
		} catch (Exception e) {
			errorMessages = "Error while receiving users from database: <br>" + e.getMessage();
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {
				
			}
		}
	} //End of getUsers

	
	/**
	 * Search user by username
	 *
	 * @param username, String
	 * @return User, the User object
	 * @throws Exception, if user not found
	 */
	public User findUser(String username) throws Exception {

		Connection con = null;
		
		String sql= "SELECT * FROM user WHERE USER_USERNAME = ?";
		
		DB db = new DB();

		try {
			// open connection and get Connection object
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, username);

			// execute the SQL statement (QUERY - SELECT) and get the results in a ResultSet)
			ResultSet rs = stmt.executeQuery();

			if( !rs.next() ) {
				errorMessages = "Could not find User with username: " + username;				
				return null;
			}
			
			User user = new User(rs.getString("USER_NAME"), rs.getString("USER_SURNAME"),rs.getString("USER_EMAIL"), 
								rs.getString("USER_USERNAME"), rs.getString("USER_Password"));
				
			rs.close(); // closing ResultSet
			stmt.close(); // closing PreparedStatement 
			
			return user;

		} catch (Exception e) {
				throw new SQLException(errorMessages);			
        } finally {

			try {
			     db.close();
			} catch (Exception e) {
				
			}
		}
	} //End of findUser

	
	/**
	 * Checks if the credentials are valid.
	 *
	 * @param username, String
	 * @param password, String
	 * @throws Exception, if the credentials are not valid
	 */
	public void authenticate(String username, String password) throws Exception {

		Connection con = null;
		
		String sql= "SELECT * FROM user WHERE USER_USERNAME = ? AND USER_Password = ?";
		
		DB db = new DB();

		try {
			// open connection and get Connection object
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, username);
			stmt.setString(2, password);

			// execute the SQL statement (QUERY - SELECT) and get the results in a ResultSet)
			ResultSet rs = stmt.executeQuery();

			if( !rs.next() ) {	

				rs.close(); // closing ResultSet
				stmt.close(); // closing PreparedStatement 
			
				errorMessages = "Λάθος όνομα χρήστη ή κωδικός πρόσβασης";				
				throw new SQLException(errorMessages);
			}

		} catch (Exception e) {
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {

			}
		}
	} //End of authenticate

	
	/**
	 * Register/create a User to the database.
	 *
	 * @param user, User
	 * @throws Exception, if encounter any error.
	 */
	public void registerUser(User user) throws Exception {

		Connection con = null;
		
		String sql= "INSERT INTO users_2018_ex3_8110111 (username, name, surname, email, password) " 
                            + " VALUES (?, ?, ?, ?, ?);";
		
		DB db = new DB();

		try {
			// open connection and get Connection object
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, user.getUsername());			
			stmt.setString(2, user.getName());
			stmt.setString(3, user.getSurname());
			stmt.setString(4, user.getEmail());
			stmt.setString(5, user.getPassword());			

			//execute the SQL statement (INSERT)	
			stmt.executeUpdate();

			stmt.close(); // closing PreparedStatement 

		} catch (Exception e) {
			errorMessages = "Error while inserting users to database: <br>" + e.getMessage();
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {

			}
		}
	} //End of registerUser

} //End of class
