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
	 * Search user by username
	 *
	 * @param username, String
	 * @return User, the User object
	 * @throws Exception, if user not found
	 */
	public User findUser(String username) throws Exception {

		Connection con = null;
		
		String sql= "SELECT * FROM user WHERE username = ?";		
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, username);

			ResultSet rs = stmt.executeQuery();

			if( !rs.next() ) {
					errorMessages = "Could not find User with username: " + username;				
					return null;									
			}
			
			User user = new User(rs.getString("name"), rs.getString("surname"), rs.getString("email"), 
				rs.getString("username"), rs.getString("password"));					

			rs.close();			
			stmt.close();			
			
			return user;

		} catch (Exception e) {
				throw new SQLException(errorMessages);			
        } finally {

			try {
			     db.close();
			} catch (Exception e) {
				
			}
		}
	} 
	
	
	/**
	 * Search organizer by username
	 *
	 * @param username, String
	 * @return Organizer, the Organizer object
	 * @throws Exception, if user not found
	 */
	public Organizer findOrganizer(String username) throws Exception {

		Connection con = null;
		
		String sql= "SELECT * FROM organizer WHERE username = ?";		
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, username);

			ResultSet rs = stmt.executeQuery();

			if( !rs.next() ) {
					errorMessages = "Could not find User with username: " + username;				
					return null;													
			}

			Organizer organizer = new Organizer(rs.getString("company_name"), rs.getString("afm"), rs.getString("email"), 
				rs.getString("phone"), rs.getString("name"), rs.getString("surname"), rs.getString("username"), rs.getString("password"));				
				
			rs.close();			
			stmt.close();			
			
			return organizer;

		} catch (Exception e) {
				throw new SQLException(errorMessages);			
        } finally {

			try {
			     db.close();
			} catch (Exception e) {
				
			}
		}
	} 	

	
	/**
	 * Checks if the credentials are valid.
	 *
	 * @param username, String
	 * @param password, String
	 * @throws Exception, if the credentials are not valid
	 */
	public void authenticate(String username, String password) throws Exception {

		Connection con = null;
		
		String sql1= "SELECT * FROM user WHERE username = ? AND password = ?";
		String sql2= "SELECT * FROM organizer WHERE username = ? AND password = ?";		
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt1 = con.prepareStatement(sql1);
			PreparedStatement stmt2 = con.prepareStatement(sql2);			
			
			stmt1.setString(1, username);
			stmt1.setString(2, password);
			stmt2.setString(1, username);
			stmt2.setString(2, password);			
			

			ResultSet rs1 = stmt1.executeQuery();
			ResultSet rs2 = stmt2.executeQuery();

			if( !rs1.next() & !rs2.next() ) {	

				rs1.close();
				stmt1.close(); 
				rs2.close();
				stmt2.close();				
			
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
	} 

	
	/**
	 * Register/create a User to the database.
	 *
	 * @param user, User
	 * @throws Exception, if encounter any error.
	 */
	public void registerUser(User user) throws Exception {

		Connection con = null;
		
		String sql= "INSERT INTO user (name, surname, email, username, password) " 
                            + " VALUES (?, ?, ?, ?, ?);";
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
						
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getSurname());
			stmt.setString(3, user.getEmail());
			stmt.setString(4, user.getUsername());
			stmt.setString(5, user.getPassword());			
	
			stmt.executeUpdate();

			stmt.close(); 

		} catch (Exception e) {
			errorMessages = "Error while inserting users to database: <br>" + e.getMessage();
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {

			}
		}
	}
	
	
	/**
	 * Register/create a Organizer to the database.
	 *
	 * @param organizer, Organizer
	 * @throws Exception, if encounter any error.
	 */
	public void registerOrganizer(Organizer organizer) throws Exception {

		Connection con = null;
		
		String sql= "INSERT INTO organizer (company_name, afm, email, phone, name, surname, username, password) " 
                            + " VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
						
			stmt.setString(1, organizer.getCompanyName());
			stmt.setString(2, organizer.getAfm());
			stmt.setString(3, organizer.getEmail());
			stmt.setString(4, organizer.getPhone());
			stmt.setString(5, organizer.getName());
			stmt.setString(6, organizer.getSurname());
			stmt.setString(7, organizer.getUsername());
			stmt.setString(8, organizer.getPassword());			
	
			stmt.executeUpdate();

			stmt.close(); 

		} catch (Exception e) {
			errorMessages = "Error while inserting users to database: <br>" + e.getMessage();
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {

			}
		}
	}	
	
	/**
	 * Create an Event to the database.
	 *
	 * @param event, Event
	 * @throws Exception, if encounter any error.
	 */
	public void createEvent(Event event) throws Exception {

		Connection con = null;
		
		String sql= "INSERT INTO activity (title, type1, type2, location, age, sex, price, tickets, short_description, description, date, image) " 
                            + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		
		DB db = new DB();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
						
			stmt.setString(1, event.getEventName());
			stmt.setString(2, event.getType1());
			stmt.setString(3, event.getType2());
			stmt.setString(4, event.getAddress());
			stmt.setString(5, event.getAge());
			stmt.setString(6, event.getSex());
			stmt.setString(7, event.getPrice());			
			stmt.setString(8, event.getTickets());			
			stmt.setString(9, event.getShortDescription());			
			stmt.setString(10, event.getDescription());	
			stmt.setString(11, event.getDate());
			stmt.setString(12, event.getImage());
	
			stmt.executeUpdate();

			stmt.close(); 

		} catch (Exception e) {
			errorMessages = "Error while inserting events to database: <br>" + e.getMessage();
			throw new SQLException(errorMessages);
        } finally {

			try {
			     db.close();
			} catch (Exception e) {

			}
		}
	}


	/**
	 * A method to get all registered events. 
	 * 
	 * @return List<Event>, The List with all events
	 * @throws Exception: if any error occured.
	 */
	public List<Event> getEvents() throws Exception {
		
		Connection con = null;

		String sql = "SELECT * FROM activity";

		DB db = new DB();
		List<Event> all_events =  new ArrayList<Event>();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				
				Event ev = new Event( rs.getString("activity.title"),
									  rs.getString("activity.type1"),
									  rs.getString("activity.type2"),
									  rs.getString("activity.location"),
									  rs.getString("activity.age"),
									  rs.getString("activity.sex"),
									  rs.getString("activity.price"),
									  rs.getString("activity.tickets"),
									  rs.getString("activity.short_description"),
									  rs.getString("activity.description"),
									  rs.getString("activity.date"),
									  rs.getString("activity.image"),
									  rs.getInt("activity.activity_id") );
				
				all_events.add( ev );	 			
			}

 			rs.close(); 
			stmt.close(); 
						
			return all_events;

		} catch (Exception e) {

			throw new Exception("Error while getting events from database! Message: " + e.getMessage());

		} finally {

			try {
			     db.close(); 
			} catch (Exception e) {

			}

		}

	}


	/**
	 * Get event by Title from database. 
	 * 
	 * @param title, String
	 * @return Event, The Event object or null
	 * @throws Exception: if any error occured.
	 */
	public Event getEventById(int id) throws Exception {
		
		Connection con = null;

		String sql = "SELECT * FROM activity WHERE activity_id = ? ";

		DB db = new DB();
		Event event = null;

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setInt(1, id);

			ResultSet rs = stmt.executeQuery();
						
			if (rs.next()) {
				 
				event = new Event( rs.getString("activity.title"),
									  rs.getString("activity.type1"),
									  rs.getString("activity.type2"),
									  rs.getString("activity.location"),
									  rs.getString("activity.age"),
									  rs.getString("activity.sex"),
									  rs.getString("activity.price"),
									  rs.getString("activity.tickets"),
									  rs.getString("activity.short_description"),
									  rs.getString("activity.description"),
									  rs.getString("activity.date"),
									  rs.getString("activity.image"),
									  rs.getInt("activity.activity_id") );									 			
			}

 			rs.close(); 
			stmt.close(); 
						
			return event;

		} catch (Exception e) {

			throw new Exception("Error while searching for event in database: " + e.getMessage());

		} finally {

			try {
			     db.close(); 
			} catch (Exception e) {

			}

		}

	} 


	/**
	 * Get events by filters from database. 
	 * 
	 * @param type, age, sex
	 * @return Events, The Events objects or null
	 * @throws Exception: if any error occured.
	 */
	public List<Event> getEventByFilters(String type, String age, String sex) throws Exception {
		
		Connection con = null;

		DB db = new DB();
		List<Event> filter_events =  new ArrayList<Event>();

		try {
			con = db.getConnection();
			
			PreparedStatement stmt = null;
			
			if(!(type.equals("0"))) {
				
				if (!(age.equals("0"))) {
					
					if (sex != null) {
				
						String sql = "SELECT * FROM activity WHERE (type1 = ? OR type2 = ?) AND age = ? AND sex = ?";
					
						stmt = con.prepareStatement(sql);
						
						stmt.setString(1, type);
						stmt.setString(2, type);		
						stmt.setString(3, age);		
						stmt.setString(4, sex);	
					}
					else {
						String sql = "SELECT * FROM activity WHERE (type1 = ? OR type2 = ?) AND age = ?";
					
						stmt = con.prepareStatement(sql);
						
						stmt.setString(1, type);
						stmt.setString(2, type);		
						stmt.setString(3, age);		
					}						
				}
				else {
					if (sex != null) {
				
						String sql = "SELECT * FROM activity WHERE (type1 = ? OR type2 = ?) AND sex = ?";
					
						stmt = con.prepareStatement(sql);
						
						stmt.setString(1, type);
						stmt.setString(2, type);			
						stmt.setString(3, sex);	
					}
					else {
						String sql = "SELECT * FROM activity WHERE type1 = ? OR type2 = ?";
					
						stmt = con.prepareStatement(sql);
						
						stmt.setString(1, type);
						stmt.setString(2, type);			
					}						
				}					
				
			}
			else {
				if (!(age.equals("0"))) {
					
					if (sex != null) {
				
						String sql = "SELECT * FROM activity WHERE age = ? AND sex = ?";
					
						stmt = con.prepareStatement(sql);
								
						stmt.setString(1, age);		
						stmt.setString(2, sex);	
					}
					else {
						String sql = "SELECT * FROM activity WHERE age = ?";
					
						stmt = con.prepareStatement(sql);
								
						stmt.setString(1, age);		
					}						
				}
				else {
					if (sex != null) {
				
						String sql = "SELECT * FROM activity WHERE sex = ?";
					
						stmt = con.prepareStatement(sql);
									
						stmt.setString(1, sex);	
					}
					else {
						String sql = "SELECT * FROM activity WHERE type1 = ?";  //case with no values to return
					
						stmt = con.prepareStatement(sql);
						
						stmt.setString(1, type);			
					}						
				}	
			}					
				
			ResultSet rs = stmt.executeQuery();
						
			while (rs.next()) {
				 
				Event ev = new Event( rs.getString("activity.title"),
									  rs.getString("activity.type1"),
									  rs.getString("activity.type2"),
									  rs.getString("activity.location"),
									  rs.getString("activity.age"),
									  rs.getString("activity.sex"),
									  rs.getString("activity.price"),
									  rs.getString("activity.tickets"),
									  rs.getString("activity.short_description"),
									  rs.getString("activity.description"),
									  rs.getString("activity.date"),
									  rs.getString("activity.image"),
									  rs.getInt("activity.activity_id") );	
									  
				filter_events.add( ev );
			}

 			rs.close(); 
			stmt.close(); 
						
			return filter_events;

		} catch (Exception e) {

			throw new Exception("Error while getting events in database: " + e.getMessage());

		} finally {

			try {
			     db.close(); 
			} catch (Exception e) {

			}

		}

	}

	/**
	 * Get events by search bar from database. 
	 * 
	 * @param search, String
	 * @return Event, The Event object or null
	 * @throws Exception: if any error occured.
	 */
	public List<Event> getEventsBySearchBar(String search) throws Exception {
		
		Connection con = null;

		String sql = "SELECT * FROM activity WHERE title = ? || type1 = ? || type2 = ?";

		DB db = new DB();
		List<Event> filter_events =  new ArrayList<Event>();

		try {
			con = db.getConnection();

			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, search);
			stmt.setString(2, search);
			stmt.setString(3, search);

			ResultSet rs = stmt.executeQuery();
						
			while (rs.next()) {
				 
				Event ev = new Event( rs.getString("activity.title"),
									  rs.getString("activity.type1"),
									  rs.getString("activity.type2"),
									  rs.getString("activity.location"),
									  rs.getString("activity.age"),
									  rs.getString("activity.sex"),
									  rs.getString("activity.price"),
									  rs.getString("activity.tickets"),
									  rs.getString("activity.short_description"),
									  rs.getString("activity.description"),
									  rs.getString("activity.date"),
									  rs.getString("activity.image"),
									  rs.getInt("activity.activity_id") );	
									  
				filter_events.add( ev );
			}

 			rs.close(); 
			stmt.close(); 
						
			return filter_events;

		} catch (Exception e) {

			throw new Exception("Error while searching for event in database: " + e.getMessage());

		} finally {

			try {
			     db.close(); 
			} catch (Exception e) {

			}

		}

	} 	
} 
