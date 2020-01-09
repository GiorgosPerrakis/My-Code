package user_package;

public class Organizer {

	private String company_name;
	private String afm;
	private String email;
	private String phone;	
	private String name;
	private String surname;
	private String username;
	private String password;
		
	/**
	 * Constructor
	 *
	 * @param company_name
	 * @param afm
	 * @param email
	 * @param phone	 
	 * @param name
	 * @param surname
	 * @param username
	 * @param password
	 */
	public Organizer(String company_name, String afm, String email, String phone, String name, String surname, String username, String password) {

		this.company_name = company_name;
		this.afm = afm;
		this.email = email;
		this.phone = phone;		
		this.name = name;
		this.surname = surname;
		this.username = username;
		this.password = password;
	}
	
	/* Getters & Setters */
	
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @return the company_name
	 */
	public String getCompanyName() {
		return company_name;
	}
	
	/**
	 * @param company_name the company_name to set
	 */
	public void setCompanyName(String company_name) {
		this.company_name = company_name;
	}
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * @return the surname
	 */
	public String getSurname() {
		return surname;
	}
	
	/**
	 * @param surname the surname to set
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}
	
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	/**
	 * @return the afm
	 */
	public String getAfm() {
		return afm;
	}
	
	/**
	 * @param afm the afm to set
	 */
	public void setAfm(String afm) {
		this.afm = afm;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}		
	
} //End of class
