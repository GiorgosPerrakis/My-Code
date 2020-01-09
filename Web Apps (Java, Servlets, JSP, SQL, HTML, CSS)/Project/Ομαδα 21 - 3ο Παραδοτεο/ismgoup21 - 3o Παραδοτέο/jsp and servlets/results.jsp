<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="user_package.*" %>

<%
	UserDAO userdao = new UserDAO();
	
	List<Event> events = userdao.getEvents();
	
	List<Event> search_events = (List<Event>) session.getAttribute("search-object");
	
	List<Event> filter_events = (List<Event>) session.getAttribute("filter-object");
	
	if(search_events != null) {
		events.clear();
		events.addAll(search_events);
		session.removeAttribute("search-object"); 
	}	
    if(filter_events != null && search_events == null) {
		events.clear();
		events.addAll(filter_events);
		session.removeAttribute("filter-object"); 
	}	
%>

<!doctype html>
<html>
<div class="background_image">
<head>
	<style>
	.background_image {
		background: linear-gradient( rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0.5) ), url('images/landing.jpg') center;
		background-repeat: no-repeat;
		background-attachment: fixed;
			-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		height: 390vh;
	}
	</style>
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
				<form action="<%=request.getContextPath() %>/search" method="POST">
				    <div class="row mb-2"></div>
					<div class="input-group">
						<input #searchBox type="text" name="search_bar" class="form-control" autocomplete="on" placeholder="Είδος, τίτλος">
						<button class="btn btn-link" type="submit" id="go">Βρες!</button>	
					</div>
				</form>
                <br>
            </div>
        </div>
        <br>

        <div class="col-12 col-lg-9 list_results">
		<%  for(Event ev : events) { %>
			  <li class="row card">
				<img class="card-img-top" src="<%=ev.getImage() %>" alt="Card image" id="image">
				<h4 class="card-title" id="title"><%=ev.getEventName() %></h4>
				<p class="card-text" id="text"><%=ev.getShortDescription() %></p>
				<a href="<%= request.getContextPath() %>/eventpage.jsp?event_id=<%=Integer.toString(ev.getId()) %>" type="submit" class="btn btn-primary btn-sm" id="button">Προβολή</a>	
			  </li>           
		<%  }  %> 
        </div>

		<form action="<%=request.getContextPath() %>/filters" method="POST">
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
					  <select class="custom-select" name = "type">
							<option value="0" selected="">Κατηγορίες</option>
							<option value="Αθλητισμός">Αθλητισμός</option>
							<option value="Θέατρο">Θέατρο</option>
							<option value="Εκπαίδευση">Εκπαίδευση</option>
							<option value="Παιδότοποι">Παιδότοποι</option>
							<option value="Μουσική">Μουσική</option>
							<option value="Καλλιτεχνικά">Καλλιτεχνικά</option>
							<option value="Κινηματογράφος">Κινηματογράφος</option>	
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
					<select class="custom-select" name="age">
					  <option value="0" selected="">Κατηγορίες</option>
					  <option value="1-3 ετών">1-3 ετών</option>
					  <option value="3-5 ετών">3-5 ετών</option>
					  <option value="5-12 ετών">5-12 ετών</option>
					  <option value="12-18 ετών">12-18 ετών</option>
					</select>
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
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-info">
								<input type="checkbox"  name="sex" value="Αγόρι">Αγόρι</input>
							</label>
								&nbsp; &nbsp;
							<label class="btn btn-info">
								<input type="checkbox" name="sex" value="Κορίτσι">Κορίτσι</input>
							</label>	
						</div>
					</div>
				</div>
				<div class="row mb-2"></div>
				<br>
				<div class="row">
					<div class="input-group">
					  <button type="submit" class="btn btn-secondary" style="position: absolute; left: 40px;">Εφαρμογή</button>
						&nbsp; &nbsp;			
					  <button type="submit" name="reset_button" class="btn btn-secondary" style="position: absolute; left: 160px;">Καθαρισμός</button>
					</div>
					<br>
					<br>
				</div>
				<div class="row mb-2"></div>
			  </div>
			</div>
		</form>
	</div>
</body>
</div>

<%@ include file="footer.jsp"%>
</html>
