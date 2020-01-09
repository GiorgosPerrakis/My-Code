<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="back_img">
<head>
  <title>Event Page</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="eventpage.css">
</head>

<body>
    <div class="container">
        <br>
        <div class="row mb-3">
            <a href="results.jsp" type="button" class="btn btn-primary btn-lg btn-block">Πίσω στα αποτελέσματα!</a>
        </div>
        <div class="row">
            <!-- Event main info -->
            <div class="col-12 col-lg-8">
                <div class="card border-light mb-3 card_height">
                        <div class="card-body">
                                <h3 class="card-title" id="title_font">ΤΑΙΝΙΑ ΤΟ ΓΑΤΟΞΟΡΚΙ</h3>
                                <span>
                                    <span class="badge badge-info">Κινηματογράφος</span>
                                </span>
                        </div>
                        <img class="img-fluid img" src="images/cat.jpg" alt="Card image"/>
                    </div>
                </div>

            <!-- Buy ticket -->
            <div class="col-12 col-lg-4 buy_ticket_block">
                <div class="card bg-light mb-3 card_height">
                    <div class="card-body">
                        <h3 class="card-title">Στοιχεία Εισιτηρίων</h3>
                        <hr class="my-4">
                        <span>
                            <div class="label_text">Τιμή : </div>
                            <p class="price_quant"> 8€ </p>
                        </span>
                        <span>
                            <div class="label_text">Διαθέσιμα εισιτήρια: </div>
                            <p class="price_quant"> 35 </p>
                        </span>
                        <div class="alert alert-dismissible alert-danger" *ngIf="!user">
                          <strong>Κάντε <a href="loginform.jsp"> ΣΥΝΔΕΣΗ </a> για αγορά εισιτηρίων!</strong>
                        </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div id="content" #content>
        <div class="row">
                <!-- Event Date -->
                <div class="col-lg-3">
                    <div class="card border-light mb-3">
                        <div class="card-header bg-info text-white text-uppercase"><i class="fa fa-calendar-check-o"></i> Ημερομηνια</div>
                        <div class="card-body">
                            <p class="card-text info_text"> 12/11/2018 </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card border-light mb-3">
                        <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-location-arrow"></i> Τοποθεσια</div>
                        <div class="card-body">
                            <p class="card-text info_text"> 28ης Οκτωβρίου 140, Αθήνα </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                        <div class="card border-light mb-3">
                            <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-child"></i> Ηλικια</div>
                            <div class="card-body">
                                <p class="card-text info_text"> 5-12 χρονών </p>
                            </div>
                        </div>
                    </div>
                <div class="col-lg-3">
                        <div class="card border-light mb-3">
                            <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-venus-mars"></i> Φυλο</div>
                            <div class="card-body">
                                <p class="card-text info_text"> Αγόρι, Κορίτσι </p>
                            </div>
                        </div>
                    </div>
        </div>

        <div class="row">
            <!-- Event Description -->
            <div class="col-12">
                <div class="card border-light mb-3">
                    <div class="card-header bg-info text-white text-uppercase"><i class="fa fa-align-justify"></i> Περιγραφη</div>
                    <div class="card-body">
                        <p class="card-text">
                            Πρόκειται για μια περιπέτεια κινουμένων σχεδίων που έρχεται από τη Βραζιλία, δια χειρός Rafael Ribas. Ο Λίνο είναι ένας διασκεδαστής σε παιδικά πάρτι που δεν αντέχει άλλο τη ρουτίνα του και το γάτο-κοστούμι του. Αποφασίζει έτσι να ζητήσει βοήθεια από έναν όχι και τόσο ταλαντούχο μάγο που τον μεταμορφώνει σε αυτό που μισεί περισσότερο: το κοστούμι του.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br>
  </body>
  </div>

<%@ include file="footer.jsp"%>
</html>
