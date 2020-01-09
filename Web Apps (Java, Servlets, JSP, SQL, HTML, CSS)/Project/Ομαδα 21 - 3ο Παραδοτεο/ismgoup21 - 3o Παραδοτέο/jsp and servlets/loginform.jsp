<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="back">
<head>
  <title>Login</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="loginform.css">
</head>

<body>
    <br>	
	<% if(request.getAttribute("message") != null) { %>		
		<div class="alert alert-danger text-center" role="alert" style="margin: auto; width: 35%;"><%=(String)request.getAttribute("message") %></div>
	<% } %>
    <div class="center">
      <br>	  
      <div class="card text-white bg-info mb-3">
        <div class="center_some">
            <div class="card-header">
              <h3>Σύνδεση</h3>
            </div>
        </div>
        <div class="card-body">
          <img src="images/avatar.png" alt="Avatar" class="avatar">
          <br>
          <form method="post" action="loginController.jsp">
            <div class="form-group">
              <label for="username">Όνομα Χρήστη</label>
              <input type="text" class="form-control" name="username" id="username" placeholder="Εισαγωγή Διεύθυνσης Ηλ. Ταχυδρομείου example@example.com" type="email" required>
            </div>
            <div class="form-group">
              <label for="password">Κωδικός Πρόσβασης</label>
              <input type="password" class="form-control" name="password" id="password" placeholder="Εισαγωγή Κωδικού Πρόσβασης" type="password" required>
            </div>
            <div class="center_some">
              <button type="submit" class="btn btn-primary">Σύνδεση</button>
              <br>
              <br>
              <p>Δεν έχετε ακόμα λογαριασμό;
                <a href="signupform.jsp"> Εγγραφή</a>
              </p>
            </div>
          </form>
        </div>
      </div>
    </div>
  &nbsp;
</body>

<%@ include file="footer.jsp"%>
</div>
</html>
