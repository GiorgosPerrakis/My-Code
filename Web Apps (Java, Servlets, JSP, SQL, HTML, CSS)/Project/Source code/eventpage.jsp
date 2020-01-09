<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	UserDAO userdao = new UserDAO();

	String event_id = request.getParameter("event_id");

	if(event_id == null) {
		throw new Exception("Bad Request!");
	}
	
	int ev_id = Integer.parseInt(event_id);

	Event ev = userdao.getEventById(ev_id);

	if(ev == null) {
		throw new Exception("Not valid event!");
	}	
%>

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
							<h3 class="card-title" id="title_font"><%=ev.getEventName() %></h3>
							<span>
								<span class="badge badge-info"><%=ev.getType1() %></span>
							</span>
							<% if (ev.getType2() != null) { %>
								<span>
									<span class="badge badge-info"><%=ev.getType2() %></span>
								</span>
							<% } %>	
					</div>
					<img class="img-fluid img" src="<%=ev.getImage() %>" alt="Card image"/>
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
                            <p class="price_quant"> <%=ev.getPrice() %>€ </p>
                        </span>
                        <span>
                            <div class="label_text">Διαθέσιμα εισιτήρια: </div>
                            <p class="price_quant"> <%=ev.getTickets() %> </p>
                        </span>
							
						<%										
							if(user == null && organizer == null)  {
						%>  	          
							<div class="alert alert-dismissible alert-danger" *ngIf="!user">
							  <strong>Κάντε <a href="loginform.jsp"> ΣΥΝΔΕΣΗ </a> για αγορά εισιτηρίων!</strong>
							</div>								
						<%
							} else if (user != null){
						%>	
							<form>
								<div class="form-group">
									<div class="label_text">Ποσότητα :</div>
									<br>
									<div class="input-group justify-content-center mb-3">
										<div class="input-group-prepend">
											<button type="button" class="btn btn-danger btn-number">
												<i class="fa fa-minus"></i>
											</button>
										</div>
										<input class="form-control-static text-center"  id="numberOfTickets" value="1">
										<div class="input-group-append">
											<button type="button" class="btn btn-success btn-number">
												<i class="fa fa-plus"></i>
											</button>
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-success btn-lg btn-block text-uppercase">
									<i class="fa fa-shopping-cart"></i> Αγορα
								</button>
							</form>									
						<%
							}
						%>											
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
                            <p class="card-text info_text"> <%=ev.getDate() %> </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card border-light mb-3">
                        <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-location-arrow"></i> Τοποθεσια</div>
                        <div class="card-body">
                            <p class="card-text info_text"> <%=ev.getAddress() %> </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                        <div class="card border-light mb-3">
                            <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-child"></i> Ηλικια</div>
                            <div class="card-body">
                                <p class="card-text info_text"> <%=ev.getAge() %> </p>
                            </div>
                        </div>
                    </div>
                <div class="col-lg-3">
                        <div class="card border-light mb-3">
                            <div class="card-header text-white bg-info text-uppercase"><i class="fa fa-venus-mars"></i> Φυλο</div>
                            <div class="card-body">
                                <p class="card-text info_text"> <%=ev.getSex() %> </p>
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
                            <%=ev.getDescription() %>
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
