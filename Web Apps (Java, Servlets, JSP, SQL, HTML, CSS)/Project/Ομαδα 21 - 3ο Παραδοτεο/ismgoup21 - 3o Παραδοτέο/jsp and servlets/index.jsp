<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user_package.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>

<%
	UserDAO userdao = new UserDAO();
	
	List<Event> recent_events = userdao.getEvents();
	
	Collections.reverse(recent_events);
%>

<!doctype html>
<html>
<div class="title">
<head>
  <title>Kidzland</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="index.css">
</head>

 <body> 
	<%					
		if(organizer != null)  {
	%> 
		<a style="position: relative; right: -1100px; top: 25px;" href="createevent.jsp" class="btn btn-info my-2 my-sm-0" type="button">
			Δημιουργία Δραστηριότητας
		</a>
	<%
		}
	%>
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h1 id="quote">Οι καλύτερες εκδηλώσεις στη πόλη!</h1>
            <a href="results.jsp" class="btn btn-warning" type="button" id="search">Αναζήτηση</a>
        </div>
      </div>	
      <div class="row">
          <div class="col-lg-12">
            <h3>Πρόσφατες Εκδηλώσεις</h3>
            <div class="grid grid-pad">
			<%  
			
			int i = 0;
			
			for(Event ev : recent_events) { 
			
				if (i == 4) break;
			
			%>
              <div class="col-1-4">
                <div class="module event">
                  <a href="<%= request.getContextPath() %>/eventpage.jsp?event_id=<%=Integer.toString(ev.getId()) %>">
                    <h4><%=ev.getEventName() %></h4>
                    <img class="card-img-top" id="image" src="<%=ev.getImage() %>" alt="Card image">
                  </a>
                </div>
              </div>
			<%  
			  i++;			
			}  
			%> 
			</div>
          </div>
      </div>
    </div>
 </body>
</div>
<%@ include file="footer.jsp"%>

</html>
