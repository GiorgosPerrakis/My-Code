<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="title">
<head>
  <title>Create Event</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="createevent.css">
</head>

<body>
  <div class="container">
  
	<% 
		if( ((Integer)request.getAttribute("temp")) != null ) {
	%>
			<br>
			<div class="row">
				<div class="col-lg-8">
					<div class="alert alert-dismissible alert-danger">
						<ol>
	<% 
		if( ((Integer)request.getAttribute("temp1")) != null ) {
			
			int value1 = (Integer) request.getAttribute("temp1");
		
			if( value1 != 0 ) { 
	%>		
		<li>Ο τίτλος της εκδήλωσης πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp2")) != null ) {
			
			int value2 = (Integer) request.getAttribute("temp2");
		
			if( value2 != 0 ) { 
	%>		
		<li>Η σύντομη περιγραφή δεν πρέπει να είναι παραπάνω από 400 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp3")) != null ) {
			
			int value3 = (Integer) request.getAttribute("temp3");
		
			if( value3 != 0 ) { 
	%>		
		<li>Η αναλυτική περιγραφή δεν πρέπει να είναι παραπάνω από 600 χαρακτήρες</li>
	<% } %>

	<% } %>

				</ol>
			</div>
		</div>
    </div>
	<% 
		}
	%>	 
  
    &nbsp;
    <h1>Δημιουργία Δραστηριότητας</h1>
    <form action="<%=request.getContextPath() %>/create_event" method="POST" enctype="multipart/form-data">
      <fieldset>
       <legend style="color:#fff">Στοιχεία Δραστηριότητας</legend>
       <small class="form-text text-muted">(* Υποχρεωτικά Πεδία)</small>
        <div class="row">
          <div class="col-lg-8">
            <label>Όνομα Δραστηριότητας*</label>
            <input type="text" class="form-control" placeholder="Εισαγωγή Ονόματος" name = "event_name" required>
            <small class="form-text text-muted">Το όνομα προβολής της δραστηριότητας στη λίστα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
         <div class="col-lg-4">
              <label for="categories1">Επιλογή Κατηγορίας 1*</label>
              <select class="form-control" id="categories1" name = "type1" required>
                <option value="">Επιλέξτε Κατηγορία</option>
                <option value="Αθλητισμός">Αθλητισμός</option>
                <option value="Θέατρο">Θέατρο</option>
                <option value="Εκπαίδευση">Εκπαίδευση</option>
                <option value="Παιδότοποι">Παιδότοποι</option>
                <option value="Μουσική">Μουσική</option>
                <option value="Καλλιτεχνικά">Καλλιτεχνικά</option>
                <option value="Κινηματογράφος">Κινηματογράφος</option>				
              </select>
              <small class="form-text text-muted">Η επιλογή τουλάχιστον μίας κατηγορίας είναι υποχρεωτική.</small>
              &nbsp;
          </div>
          <div class="col-lg-4">
              <label for="categories2">Επιλογή Κατηγορίας 2</label>
              <select class="form-control" id="categories2" name = "type2">
                <option value="">Επιλέξτε Κατηγορία</option>
                <option value="Αθλητισμός">Αθλητισμός</option>
                <option value="Θέατρο">Θέατρο</option>
                <option value="Εκπαίδευση">Εκπαίδευση</option>
                <option value="Παιδότοποι">Παιδότοποι</option>
                <option value="Μουσική">Μουσική</option>
                <option value="Καλλιτεχνικά">Καλλιτεχνικά</option>
                <option value="Κινηματογράφος">Κινηματογράφος</option>
              </select>
         </div>
        </div>
        <div class="row">
          <div class="col-lg-8">
            <label>Τοποθεσία/Διεύθυνση Διεξαγωγής Δραστηριότητας*</label>
            <input type="text" class="form-control" placeholder="Εισαγωγή Τοποθεσίας" name = "address" required>
            <small class="form-text text-muted">Τοποθεσία/Διεύθυνση όπου θα λάβει μέρος η παρών δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Ημερομηνία Διεξαγωγής Δραστηριότητας*</label>		  
            <input type="text" class="form-control" placeholder="Εισαγωγή Ημερομηνίας" name = "date" required>
            <small class="form-text text-muted">Ημερομηνία που θα λάβει μέρος η παρών δραστηριότητα.</small>			
          </div>	  
        </div>
        &nbsp;		
        <div class="row">
          <div class="col-lg-8">
            <label for="age_category">Επιλογή Κατηγορίας Ηλικίας*</label>
            <select class="form-control" id="age_category" name = "age" required>
              <option value="">Επιλέξτε Κατηγορία</option>
              <option value="1-3 ετών">1-3 ετών</option>
              <option value="3-5 ετών">3-5 ετών</option>
              <option value="5-12 ετών">5-12 ετών</option>
              <option value="12-18 ετών">12-18 ετών</option>
            </select>
            <small class="form-text text-muted">Ηλικιακή ομάδα που θα μπορεί να συμμετάσχει στη δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label for="sex_category">Επιλογή Φύλου Παιδιών*</label>
            <select class="form-control" id="sex_category" name = "sex" required>
              <option value="">Επιλέξτε Φύλο</option>
              <option value="Αγόρια">Αγόρια</option>
              <option value="Κορίτσια">Κορίτσια</option>
              <option value="Αγόρια & Κορίτσια">Και τα δύο φύλα</option>
            </select>
            <small class="form-text text-muted">Για ποιο φύλο παιδιών προορίζεται η δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Ορισμός Τιμής Εισιτηρίου*</label>
            <input type="number" class="form-control" placeholder="Τιμή Εισιτηρίου" name = "price" required>
            <small class="form-text text-muted">Χρήματα που πρέπει να ξοδέψει ένας γονέας για αγορά εισιτηρίου.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Ορισμός Αριθμού Διαθέσιμων Εισιτηρίων*</label>
            <input type="number" class="form-control" placeholder="Αριθμός Εισιτηρίων" name = "tickets" required>
            <small class="form-text text-muted">Αριθμός εισιτηρίων που διατίθονται για τη δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Σύντομη Περιγραφή Δραστηριότητας*</label>
            <textarea class="form-control" rows="2" name = "short_description" required></textarea>
			<small class="form-text text-muted">Σύντομη περιγραφή της δραστηριότητας για την λίστα με τις δραστηριότητες.</small>
          </div>
        </div>
        &nbsp;		
        <div class="row">
          <div class="col-lg-8">
            <label>Αναλυτική Περιγραφή Δραστηριότητας*</label>
            <textarea class="form-control" rows="4" name = "description" required></textarea>
			<small class="form-text text-muted">Αναλυτική περιγραφή της δραστηριότητας.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label for="exampleInputFile">Εικόνα/Φωτογραφία Δραστηριότητας*</label>
            <input type="file" class="form-control-file" id="exampleInputFile">
            <small class="form-text text-muted">Φωτογραφία της δραστηριότητας</small>
          </div>
        </div> 
      </fieldset>
    &nbsp;
    <div class="row">
      <div class="col-sm-10 col-sm-offset-2">
			<button type="submit" name="submit_button" class="btn btn-primary">
    			<span class="glyphicon glyphicon-ok"></span> Δημιουργία Δραστηριότητας
			</button>
	        <br>	
            <br>			
			<button type="reset" name="reset_button" class="btn btn-danger">
    			<span class="glyphicon glyphicon-remove" id="reset" class="btn btn-danger"></span> Ακύρωση
			</button>
	  </div>
  </div>
 </form>
  &nbsp;
</body>
</div>

<%@ include file="footer.jsp"%>
</html>
