package user_package;

public class Event {

	private String event_name;
	private String type1;
	private String type2;
	private String address;	
	private String age;
	private String sex;
	private String price;
	private String tickets;
	private String short_description;
	private String description;
	private String date;
	private String image;
	private int activity_id;	
		
	/**
	 * Constructor
	 *
	 * @param event_name
	 * @param type1
	 * @param type2
	 * @param address	 
	 * @param age
	 * @param sex
	 * @param price
	 * @param tickets
	 * @param short_description
	 * @param description
	 * @param date	 
	 * @param image	 
	 * @param activity_id	 
	 */
	public Event(String event_name, String type1, String type2, String address, String age, 
			String sex, String price, String tickets, String short_description, String description, String date, String image, int activity_id) {

		this.event_name = event_name;
		this.type1 = type1;
		this.type2 = type2;
		this.address = address;
		this.age = age;
		this.sex = sex;
		this.price = price;
		this.tickets = tickets;
		this.short_description = short_description;
		this.description = description;
		this.date = date;		
		this.image = image;		
		this.activity_id = activity_id;		
	}
	
	/* Getters & Setters */
	
	/**
	 * @return the event_name
	 */
	public String getEventName() {
		return event_name;
	}
	
	/**
	 * @param event_name the event_name to set
	 */
	public void setEventName(String event_name) {
		this.event_name = event_name;
	}

	/**
	 * @return the type1
	 */
	public String getType1() {
		return type1;
	}
	
	/**
	 * @param type1 the type1 to set
	 */
	public void setType1(String type1) {
		this.type1 = type1;
	}
	
	/**
	 * @return the type2
	 */
	public String getType2() {
		return type2;
	}
	
	/**
	 * @param type2 the type2 to set
	 */
	public void setType2(String type2) {
		this.type2 = type2;
	}
	
	/**
	 * @return the surname
	 */
	public String getAddress() {
		return address;
	}
	
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * @return the email
	 */
	public String getDate() {
		return date;
	}
	
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
	}
	/**
	 * @return the age
	 */
	public String getAge() {
		return age;
	}
	
	/**
	 * @param age the age to set
	 */
	public void setAge(String age) {
		this.age = age;
	}
	
	/**
	 * @return the sex
	 */
	public String getSex() {
		return sex;
	}
	
	/**
	 * @param sex the sex to set
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * @return the price
	 */
	public String getPrice() {
		return price;
	}
	
	/**
	 * @param price the price to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the tickets
	 */
	public String getTickets() {
		return tickets;
	}
	
	/**
	 * @param tickets the tickets to set
	 */
	public void setTickets(String tickets) {
		this.tickets = tickets;
	}	
	
	/**
	 * @return the short_description
	 */
	public String getShortDescription() {
		return short_description;
	}
	
	/**
	 * @param short_description the short_description to set
	 */
	public void setShortDescription(String short_description) {
		this.short_description = short_description;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}	
	
		/**
	 * @return the activity_id
	 */
	public int getId() {
		return activity_id;
	}
	
	/**
	 * @param activity_id the activity_id to set
	 */
	public void setId(String id) {
		this.activity_id = activity_id;
	}


		/**
	 * @return the activity_id
	 */
	public String getImage() {
		return image;
	}
	
	/**
	 * @param activity_id the activity_id to set
	 */
	public void setImage(String image) {
		this.image = image;
	}	
} //End of class
