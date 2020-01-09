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
        <form>
          <div class="form-group">
            <label for="ufname"><b>Όνομα</b></label>
            <input type="text"
                    class="form-control"
                    id="ufname"
                    placeholder="Εισαγωγή Ονόματος"
                    required>
          </div>
          <div class="form-group">
            <label for="ulname"><b>Επίθετο</b></label>
            <input type="text"
                    class="form-control"
                    id="ulname"
                    placeholder="Εισαγωγή Επιθέτου"
                    required>
          </div>
          <div class="form-group">
            <label for="uemail"><b>Διεύθυνση Ηλ. Ταχυδρομείου</b></label>
            <input  type="text"
                    class="form-control"
                    id="uemail"
                    placeholder="Εισαγωγή Διεύθυνσης Ηλ. Ταχυδρομείου example@example.com"
                    type="email"
                    required
                    pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?">
          </div>
          <div class="form-group">
            <label for="password"><b>Κωδικός Πρόσβασης</b></label>
            <input type="password"
                    class="form-control"
                    id="password"
                    placeholder="Εισαγωγή Κωδικού Πρόσβασης"
                    required>
          </div>
          <div class="form-group">
            <label for="passwordrepeat"><b>Επανάληψη Κωδικού Πρόσβασης</b></label>
            <input type="password"
                    class="form-control"
                    id="passwordrepeat"
                    placeholder="Επαναλάβετε τον Κωδικό Πρόσβασης"
                    required>
          </div>
          <br>
          <div class="center_some">
            <p>Δημιουργώντας Λογαριασμό συμφωνείτε με τους :
                <a href="index.jsp"> Όρους και την Πολιτική μας</a>
            </p>
            <button class="btn btn-primary">Δημιουργία Λογαριασμού</button>
            <br>
            <br>
            <a class="btn btn-danger" id="button">Ακύρωση</a>
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
