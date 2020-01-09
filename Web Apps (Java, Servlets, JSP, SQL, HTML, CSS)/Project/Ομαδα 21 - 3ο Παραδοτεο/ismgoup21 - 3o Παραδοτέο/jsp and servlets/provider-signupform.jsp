<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="back">
<head>
  <title>Register Provider</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="provider-signupform.css">
</head>

<body>
    <div class="center">
	<% 
		if( ((Integer)request.getAttribute("temp")) != null ) {
	%>
			<br>
			<div class="alert alert-dismissible alert-danger">
				<ol>
	<% 
		if( ((Integer)request.getAttribute("temp1")) != null ) {
			
			int value1 = (Integer) request.getAttribute("temp1");
		
			if( value1 != 0 ) { 
	%>		
		<li>Το όνομα της εταιρείας πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp2")) != null ) {
			
			int value2 = (Integer) request.getAttribute("temp2");
		
			if( value2 != 0 ) { 
	%>		
		<li>Το ΑΦΜ πρέπει να είναι 9 ψηφία</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp3")) != null ) {
			
			int value3 = (Integer) request.getAttribute("temp3");
		
			if( value3 != 0 ) { 
	%>		
		<li>Το τηλέφωνο πρέπει να είναι 10 ψηφία</li>
	<% } %>

	<% } %>	
				
	<% 
		if( ((Integer)request.getAttribute("temp4")) != null ) {
			
			int value4 = (Integer) request.getAttribute("temp4");
		
			if( value4 != 0 ) { 
	%>		
		<li>Το όνομα πρέπει να είναι τουλάχιστον 3 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp5")) != null ) {
			
			int value5 = (Integer) request.getAttribute("temp5");
		
			if( value5 != 0 ) { 
	%>		
		<li>Το επίθετο πρέπει να είναι τουλάχιστον 3 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp6")) != null ) {
			
			int value6 = (Integer) request.getAttribute("temp6");
		
			if( value6 != 0 ) { 
	%>		
		<li>Το όνομα χρήστη υπάρχει ήδη</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp7")) != null ) {
			
			int value7 = (Integer) request.getAttribute("temp7");
		
			if( value7 != 0 ) { 
	%>		
		<li>Το όνομα χρήστη πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp8")) != null ) {
			
			int value8 = (Integer) request.getAttribute("temp8");
		
			if( value8 != 0 ) { 
	%>		
		<li>Ο κωδικός πρόσβασης πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp9")) != null ) {
			
			int value9 = (Integer) request.getAttribute("temp9");
		
			if( value9 != 0 ) { 
	%>		
		<li>Ο κωδικός πρόσβασης πρέπει να είναι ίδιος με την επιβεβαίωση</li>
	<% } %>

	<% } %>
	</ol>
    </div>
	<% 
		}
	%>		
    <br>
      <div class="card text-white bg-success mb-3">
        <div class="center_some">
            <div class="card-header">
              <h3>Εγγραφή</h3>
            </div>
        </div>
        <div class="card-body">

          <div class="center_some_more">
            <a href="signupform.jsp" class="btn btn-info" id="button">Εγγραφή Γονέα</a>
            &nbsp;
            <a href="provider-signupform.jsp" class="btn btn-info" id="button">Εγγραφή Παρόχου</a>
            <br>
            <br>
            <p>Παρακαλώ εισάγετε στοιχεία για την Εγγραφή Παρόχου:</p>
          </div>
          <form action="<%=request.getContextPath() %>/register_provider" method="POST">
            <div class="form-group">
                <label for="company_name"><b>Όνομα Εταιρείας</b></label>
                <input type="text"
                        class="form-control"
                        id="company_name"
						name="company"
                        placeholder="Εισαγωγή Ονόματος Εταιρείας"
                        required>
            </div>
            <div class="form-group">
                <label for="afm"><b>Α.Φ.Μ</b></label>
                <input type="text"
                        class="form-control"
                        id="afm"
						name="afm"
                        placeholder="Εισαγωγή Α.Φ.Μ"
                        required>
            </div>
            <div class="form-group">
              <label for="pemail"><b>Διεύθυνση Ηλ. Ταχυδρομείου</b></label>
              <input  type="text"
                      class="form-control"
                      id="pemail"
					  name="email"
                      placeholder="Εισαγωγή Διεύθυνσης Ηλ. Ταχυδρομείου example@example.com"
                      type="email"
                      required
                      pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?">
            </div>			
            <div class="form-group">
                <label for="phone"><b>Τηλέφωνο Επικοινωνίας</b></label>
                <input type="text"
                        class="form-control"
                        id="phone"
						name="phone"
                        placeholder="Εισαγωγή Τηλεφώνου Επικοινωνίας  "
                        required>
            </div>
            <div class="form-group">
              <label for="pfname"><b>Όνομα</b></label>
              <input type="text"
                      class="form-control"
                      id="pfname"
					  name="name"
                      placeholder="Εισαγωγή Ονόματος"
                      required>
            </div>
            <div class="form-group">
              <label for="plname"><b>Επίθετο</b></label>
              <input type="text"
                      class="form-control"
                      id="plname"
					  name="surname"
                      placeholder="Εισαγωγή Επιθέτου"
                      required>
            </div>
            <div class="form-group">
              <label for="pusername"><b>Όνομα Χρήστη</b></label>
              <input type="text"
                      class="form-control"
					  id="username"
					  name="username"					  
                      placeholder="Εισαγωγή Ονόματος Χρήστη"
                      required>
            </div>			
            <div class="form-group">
              <label for="ppassword"><b>Κωδικός Πρόσβασης</b></label>
              <input type="text"
                      class="form-control"
                      id="ppassword"
					  name="password"
                      placeholder="Εισαγωγή Κωδικού Πρόσβασης"
                      required>
            </div>
            <div class="form-group">
              <label for="ppassword_repeat"><b>Επανάληψη Κωδικού Πρόσβασης</b></label>
              <input type="text"
                      class="form-control"
                      id="ppassword_repeat"
					  name="confirm"
                      placeholder="Επαναλάβετε τον Κωδικό Πρόσβασης"
                      required>
            </div>
            <br>
          <div class="center_some">
            <p>Δημιουργώντας Λογαριασμό συμφωνείτε με τους :
                <b><font color="black"><u> Όρους και την Πολιτική μας</u></font></b>
            </p>
			<button type="submit" name="submit_button" class="btn btn-primary">
    			<span class="glyphicon glyphicon-ok"></span> Δημιουργία Λογαριασμού
			</button>
	        <br>	
            <br>			
			<button type="reset" name="reset_button" class="btn btn-danger">
    			<span class="glyphicon glyphicon-remove" id="reset" class="btn btn-danger"></span> Ακύρωση
			</button>
          </div>
          </form>

        </div>
      </div>
    </div>
    <br>
  </body>
  </div>

<%@ include file="footer.jsp"%>
</html>
