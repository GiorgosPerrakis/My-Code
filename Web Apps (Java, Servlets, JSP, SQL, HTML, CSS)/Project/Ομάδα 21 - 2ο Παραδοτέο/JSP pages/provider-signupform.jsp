<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="back">
<head>
  <title>Register</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="provider-signupform.css">
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
            <p>Παρακαλώ εισάγετε στοιχεία για την Εγγραφή Παρόχου:</p>
          </div>
          <form>
            <div class="form-group">
                <label for="company_name"><b>Όνομα Εταιρείας</b></label>
                <input type="text"
                        class="form-control"
                        id="company_name"
                        placeholder="Εισαγωγή Ονόματος Εταιρείας"
                        required>
            </div>
            <div class="form-group">
                <label for="afm"><b>Α.Φ.Μ</b></label>
                <input type="text"
                        class="form-control"
                        id="afm"
                        placeholder="Εισαγωγή Α.Φ.Μ"
                        required>
            </div>
            <div class="form-group">
                <label for="phone"><b>Τηλέφωνο Επικοινωνίας</b></label>
                <input type="text"
                        class="form-control"
                        id="phone"
                        placeholder="Εισαγωγή Τηλεφώνου Επικοινωνίας  "
                        required>
            </div>
            <div class="form-group">
              <label for="pfname"><b>Όνομα</b></label>
              <input type="text"
                      class="form-control"
                      id="pfname"
                      placeholder="Εισαγωγή Ονόματος"
                      required>
            </div>
            <div class="form-group">
              <label for="plname"><b>Επίθετο</b></label>
              <input type="text"
                      class="form-control"
                      id="plname"
                      placeholder="Εισαγωγή Επιθέτου"
                      required>
            </div>
            <div class="form-group">
              <label for="pemail"><b>Διεύθυνση Ηλ. Ταχυδρομείου</b></label>
              <input  type="text"
                      class="form-control"
                      id="pemail"
                      placeholder="Εισαγωγή Διεύθυνσης Ηλ. Ταχυδρομείου example@example.com"
                      type="email"
                      required
                      pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?">
            </div>
            <div class="form-group">
              <label for="ppassword"><b>Κωδικός Πρόσβασης</b></label>
              <input type="text"
                      class="form-control"
                      id="ppassword"
                      placeholder="Εισαγωγή Κωδικού Πρόσβασης"
                      required>
            </div>
            <div class="form-group">
              <label for="ppassword_repeat"><b>Επανάληψη Κωδικού Πρόσβασης</b></label>
              <input type="text"
                      class="form-control"
                      id="ppassword_repeat"
                      placeholder="Επαναλάβετε τον Κωδικό Πρόσβασης"
                      required>
            </div>
            <br>
            <div class="center_some">
              <p>*Δημιουργώντας Λογαριασμό συμφωνείτε με τους :
                  <a href="home.html"> Όρους και την Πολιτική μας</a>
              </p>
              <button type="submit" class="btn btn-primary">Δημιουργία Λογαριασμού</button>
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
