<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="title">
<head>
  <title>Results</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="results.css">
</head>

 <body>
    <div class="container">
      <br>
      <div class="row">
            <div class="card" id="search_id">
                <div class="row mb-1"></div>
                <h4 class="search-title">Αναζήτηση</h4>
                <div class="row mb-2"></div>
                <div class="input-group">
                    <input #searchBox type="text" class="form-control" autocomplete="on" placeholder="Είδος, περιοχή, ηλικία">
                    <button class="btn btn-link" type="button" id="go">Βρες!</button>
                </div>
                <br>
            </div>
        </div>
        <br>

        <div class="col-12 col-lg-9 list_results">
          <li class="row card">
            <img class="card-img-top" src="images/race.jpg" alt="Card image" id="image">
            <h4 class="card-title" id="title">ΑΘΛΗΤΙΚΟ ΦΕΣΤΙΒΑΛ</h4>
            <p class="card-text" id="text">Καλοκαιρινός αγώνας με ποδήλατα ισορροπίας για μικρά παιδιά, με σκοπό κάθε παιδί να παίξει, να τρέξει και να νικήσει, μαθαίνοντας ότι στην ζωή η αγάπη πάντα θα νικάει. Σε αυτό τον αγώνα κάθε παιδί είναι νικητής και γι’ αυτό το λόγο όλα τα παιδιά βραβεύονται με μετάλλια, επαίνους, καπέλα, σφυρίχτρες, μπαλόνια και πολλά άλλα πλούσια δώρα.</p>
            <a href="#" class="btn btn-primary btn-sm" id="button">Προβολή</a>
          </li>
          <li class="row card">
            <img class="card-img-top" src="images/cat.jpg" alt="Card image" id="image">
            <h4 class="card-title" id="title">ΤΑΙΝΙΑ ΤΟ ΓΑΤΟΞΟΡΚΙ</h4>
            <p class="card-text" id="text">Ένας διασκεδαστής σε παιδικά πάρτι, που φοράει στολή γάτου, αποφασίζει να αλλάξει τη ζωή του με τη βοήθεια ενός μάγου. Εκείνος όμως τον μεταμορφώνει σε αληθινό γάτο και στη συνέχεια προσπαθεί να λύσει το ξόρκι του.</p>
            <a href="#" class="btn btn-primary btn-sm" id="button">Προβολή</a>
          </li>
          <li class="row card">
            <img class="card-img-top" src="images/lion.jpg" alt="Card image" id="image">
            <h4 class="card-title" id="title">ΛΙΟΝΤΑΡΙ ΚΑΙ ΠΟΝΤΙΚΙ</h4>
            <p class="card-text" id="text">Ο δυνατός και ο αδύναμος, ο μεγάλος και ο μικρός. Δύο ήρωες τόσο διαφορετικοί συναντιούνται σε έναν μύθο του Αισώπου και μας δείχνουν πόσο χρειάζεται ο ένας τον άλλο! Πώς κατάφερε ένας μικρούλης ποντικός να σώσει το δυνατό λιοντάρι;</p>
            <a href="#" class="btn btn-primary btn-sm" id="button">Προβολή</a>
          </li>
          <li class="row card">
            <img class="card-img-top" src="images/img6.jpg" alt="Card image" id="image">
            <h4 class="card-title" id="title">ΝΕΟΣ ΠΑΙΔΟΤΟΠΟΣ</h4>
            <p class="card-text" id="text">Με ξεχωριστές δραστηριότητες που θα κρατήσουν τα παιδιά απασχολημένα για ώρα, ο παιδότοπος υπόσχεται ότι θα εξάψει τη δημιουργικότητα και τη φαντασία τους, χωρίς να βαρεθούν ούτε λεπτό.</p>
            <a href="#" class="btn btn-primary btn-sm" id="button">Προβολή</a>
          </li>
          <br>
          <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </div>

        <div class="row">
          <div class="card col-12 col-lg-3" id="filters_id">
            <div class="row mb-2"></div>
            <div class="row">
                <h4 class="filters-title">Φίλτρα</h4>
                <br>
            </div>
            <div class="row">
                <h5 class="filter">Είδος</h5>
                <br>
            </div>
            <div class="row">
                <br>
                <div class="form-group" id="menu">
                  <select class="custom-select">
            		      <option selected="">Κατηγορίες</option>
            		      <option value="1">Αθλητισμός</option>
            		      <option value="2">Τέχνη</option>
            		      <option value="3">Θέατρο</option>
            		      <option value="3">Κινηματογράφος</option>
            		      <option value="3">Παιδότοποι</option>
            	    </select>
                </div>
                <br>
                <br>
            </div>
            <div class="row">
              <h5 class="filter">Ηλικία</h5>
              <br>
            </div>
            <div class="row">
              <br>
              <div class="form-group" id="menu">
                <select class="custom-select">
                  <option selected="">Κατηγορίες</option>
              		<option value="1">1-3 χρονών</option>
              		<option value="2">3-5 χρονών</option>
              		<option value="3">5-12 χρονών</option>
              		<option value="4">12-18 χρονών</option>
                </select>
              </div>
              <br>
              <br>
            </div>
            <div class="row">
              <h5 class="filter">Ημερομηνία</h5>
              <br>
            </div>
            <div class="row">
              <br>
              <div class="form-group" id="menu">
                <select class="custom-select">
                  <option selected="">Κατηγορίες</option>
              		<option value="1">Σήμερα</option>
              		<option value="2">Αύριο</option>
              		<option value="3">Αυτή την εβδομάδα</option>
              		<option value="4">Αυτό το μήνα</option>
                </select>
              </div>
              <br>
              <br>
            </div>
            <div class="row">
              <h5 class="filter">Τιμή</h5>
              <br>
            </div>
            <div class="row">
              <br>
              <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups" id="price">
                <div class="btn-group mr-2" role="group" aria-label="First group">
                  <button type="button" class="btn btn-info">< 5</button>
            			<button type="button" class="btn btn-info">< 10</button>
            			<button type="button" class="btn btn-info">< 20</button>
            			<button type="button" class="btn btn-info">< 50</button>
            			<button type="button" class="btn btn-info">< 100</button>
                </div>
              </div>
              <br>
              <br>
            </div>
            <div class="row">
              <h5 class="filter">Φύλο</h5>
              <br>
            </div>
            <div class="row">
                <br>
                <div class="input-group" id="sex">
                  <button type="button" class="btn btn-info">Αγόρι</button>
                    &nbsp; &nbsp;
                  <button type="button" class="btn btn-info">Κορίτσι</button>
                </div>
            </div>
            <div class="row mb-2"></div>
            <div class="row">
                <br>
                <div class="input-group" id="submit">
                  <button type="button" class="btn btn-secondary">Εφαρμογή</button>
                </div>
            </div>
            <div class="row mb-2"></div>
          </div>
    </div>
</div>
</body>
</div>

<%@ include file="footer.jsp"%>
</html>
