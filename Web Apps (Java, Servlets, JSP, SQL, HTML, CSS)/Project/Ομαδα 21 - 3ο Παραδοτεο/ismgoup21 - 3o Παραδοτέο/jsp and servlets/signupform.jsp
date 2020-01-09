<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="back">
<head>
  <title>Register</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="signupform.css">
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
		<li>Το όνομα πρέπει να είναι τουλάχιστον 3 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp2")) != null ) {
			
			int value2 = (Integer) request.getAttribute("temp2");
		
			if( value2 != 0 ) { 
	%>		
		<li>Το επίθετο πρέπει να είναι τουλάχιστον 3 χαρακτήρες</li>
	<% } %>

	<% } %>
	
	<% 
		if( ((Integer)request.getAttribute("temp3")) != null ) {
			
			int value3 = (Integer) request.getAttribute("temp3");
		
			if( value3 != 0 ) { 
	%>		
		<li>Το όνομα χρήστη υπάρχει ήδη</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp4")) != null ) {
			
			int value4 = (Integer) request.getAttribute("temp4");
		
			if( value4 != 0 ) { 
	%>		
		<li>Το όνομα χρήστη πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp5")) != null ) {
			
			int value5 = (Integer) request.getAttribute("temp5");
		
			if( value5 != 0 ) { 
	%>		
		<li>Ο κωδικός πρόσβασης πρέπει να είναι τουλάχιστον 5 χαρακτήρες</li>
	<% } %>

	<% } %>

	<% 
		if( ((Integer)request.getAttribute("temp6")) != null ) {
			
			int value6 = (Integer) request.getAttribute("temp6");
		
			if( value6 != 0 ) { 
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
          <p>Παρακαλώ εισάγετε στοιχεία για την Εγγραφή Γονέα:</p>
        </div>
        <form action="<%=request.getContextPath() %>/register" method="POST">
          <div class="form-group">
            <label for="ufname"><b>Όνομα</b></label>
            <input type="text"
                    class="form-control"
                    id="ufname"
					name = "name"
                    placeholder="Εισαγωγή Ονόματος"
                    required>
          </div>
          <div class="form-group">
            <label for="ulname"><b>Επίθετο</b></label>
            <input type="text"
                    class="form-control"
                    id="ulname"
					name = "surname"
                    placeholder="Εισαγωγή Επιθέτου"
                    required>
          </div>
          <div class="form-group">
            <label for="uemail"><b>Διεύθυνση Ηλ. Ταχυδρομείου</b></label>
            <input  type="text"
                    class="form-control"
                    id="uemail"
					name = "email"
                    placeholder="Εισαγωγή Διεύθυνσης Ηλ. Ταχυδρομείου example@example.com"
                    type="email"
                    required
                    pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?">
          </div>
          <div class="form-group">
            <label for="username"><b>Όνομα Χρήστη</b></label>
            <input type="text"
                    class="form-control"
                    id="username"
					name = "username"
                    placeholder="Εισαγωγή Ονόματος Χρήστη"
                    required>
          </div>
          <div class="form-group">
            <label for="password"><b>Κωδικός Πρόσβασης</b></label>
            <input type="password"
                    class="form-control"
                    id="password"
					name = "password"
                    placeholder="Εισαγωγή Κωδικού Πρόσβασης"
                    required>
          </div>
          <div class="form-group">
            <label for="passwordrepeat"><b>Επανάληψη Κωδικού Πρόσβασης</b></label>
            <input type="password"
                    class="form-control"
                    id="passwordrepeat"
					name = "confirm"
                    placeholder="Επαναλάβετε τον Κωδικό Πρόσβασης"
                    required>
          </div>
          <br>
          <div class="center_some">
            <p>Δημιουργώντας Λογαριασμό συμφωνείτε με τους :
                <font color="black"><b><u> Όρους και την Πολιτική μας</u></b></font>
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
