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
    &nbsp;
    <h1>Δημιουργία Δραστηριότητας</h1>
    <form>
      <fieldset>
       <legend style="color:#fff">Στοιχεία Δραστηριότητας</legend>
       <small class="form-text text-muted">(* Υποχρεωτικά Πεδία)</small>
        <div class="row">
          <div class="col-lg-8">
            <label>Όνομα Δραστηριότητας*</label>
            <input type="text" class="form-control" placeholder="Εισαγωγή Ονόματος">
            <small class="form-text text-muted">Το όνομα προβολής της δραστηριότητας στη λίστα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
         <div class="col-lg-4">
              <label for="exampleSelect1">Επιλογή Κατηγορίας 1*</label>
              <select class="form-control" id="exampleSelect1">
                <option>Επιλέξτε Κατηγορία</option>
                <option>Αθλητισμός</option>
                <option>Θέατρο</option>
                <option>Διασκέδαση</option>
                <option>Εκπαίδευση</option>
                <option>Χειροτεχνικά</option>
                <option>Παιδότοπος</option>
                <option>Μουσική</option>
                <option>Καλλιτεχνικά</option>
              </select>
              <small class="form-text text-muted">Η επιλογή τουλάχιστον μίας κατηγορίας είναι υποχρεωτική.</small>
              &nbsp;
          </div>
          <div class="col-lg-4">
              <label for="exampleSelect1">Επιλογή Κατηγορίας 2</label>
              <select class="form-control" id="exampleSelect1">
                <option>Επιλέξτε Κατηγορία</option>
                <option>Αθλητισμός</option>
                <option>Θέατρο</option>
                <option>Διασκέδαση</option>
                <option>Εκπαίδευση</option>
                <option>Χειροτεχνικά</option>
                <option>Παιδότοπος</option>
                <option>Μουσική</option>
                <option>Καλλιτεχνικά</option>
              </select>
         </div>
        </div>
        <div class="row">
          <div class="col-lg-8">
            <label>Τοποθεσία/Διεύθυνση Διεξαγωγής Δραστηριότητας*</label>
            <input type="text" class="form-control" placeholder="Εισαγωγή Τοποθεσίας">
            <small class="form-text text-muted">Τοποθεσία/Διεύθυνση όπου θα λάβει μέρος η παρών δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label for="exampleInputEmail1">Επιλογή Κατηγορίας Ηλικίας*</label>
            <select class="form-control" id="exampleSelect1">
              <option>Επιλέξτε Κατηγορία</option>
              <option>1-3 ετών</option>
              <option>3-5 ετών</option>
              <option>5-12 ετών</option>
              <option>12-18 ετών</option>
            </select>
            <small class="form-text text-muted">Ομάδες ηλικιών που θα μπορούν να συμμετάσχουν στη δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label for="exampleInputEmail1">Επιλογή Φύλο Παιδιών*</label>
            <select class="form-control" id="exampleSelect1">
              <option>Επιλέξτε Φύλο</option>
              <option>Αγόρια</option>
              <option>Κορίτσια</option>
              <option>Και τα δύο φύλα</option>
            </select>
            <small class="form-text text-muted">Για ποιο φύλο παιδιών προορίζεται η δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Ορισμός Τιμής Εισιτηρίου*</label>
            <input type="number" class="form-control" placeholder="Τιμή Εισιτηρίου">
            <small class="form-text text-muted">Χρήματα που πρέπει να ξοδέψει ένας γονέας για αγορά εισιτηρίου.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Ορισμός Αριθμού Διαθέσιμων Εισιτηρίων*</label>
            <input type="number" class="form-control" placeholder="Αριθμός Εισιτηρίου">
            <small class="form-text text-muted">Αριθμός εισιτηρίων που διατίθονται για τη δραστηριότητα.</small>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label>Περιγραφή Δραστηριότητας</label>
            <textarea class="form-control" rows="4"></textarea>
          </div>
        </div>
        &nbsp;
        <div class="row">
          <div class="col-lg-8">
            <label for="exampleInputFile">Εικόνα/Φωτογραφία Δραστηριότητας*</label>
            <input type="file" class="form-control-file" id="exampleInputFile" aria-describedby="fileHelp" ng2FileSelect [uploader]="uploader">
            <small class="form-text text-muted">Μέγιστο μέγεθος αρχείου: -- ΜΒ</small>
          </div>
        </div>
      </fieldset>
    </form>
    &nbsp;
    <div class="row">
      <div class="col-sm-10 col-sm-offset-2">
      <button type="button" class="btn btn-success">Δημιουργία</button>
      &nbsp;
      <button type="button" class="btn btn-danger">Ακύρωση</button>
    </div>
  </div>
  &nbsp;
</body>
</div>

<%@ include file="footer.jsp"%>
</html>
