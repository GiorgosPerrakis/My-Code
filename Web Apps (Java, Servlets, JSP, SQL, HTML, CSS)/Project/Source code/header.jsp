<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user_package.*" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.3/sketchy/bootstrap.min.css" rel="stylesheet" integrity="sha384-7ELRJF5/u1pkLd0W7K793Y7ZCb1ISE8FjEKiDAwHD3nSDbA2E9Txc423ovuNf1CV" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<nav class="navbar navbar-expand-lg justify-content-between">
    <a class="navbar-brand" href="index.jsp">
      <img src="images/logo.png" width="120" height="100" class="d-inline-block align-top">
    </a>
    <div>
		<%
			Event new_event = (Event) session.getAttribute("event-object");
		
			Organizer organizer = (Organizer) session.getAttribute("organizer-object");	
			
			User user = (User) session.getAttribute("user-object");
						
			if(user != null)  {
		%>  	          
			<a style="color:white;"><%=user.getUsername() %></a>
			&nbsp;			
			&nbsp;			
			<a href="logout.jsp" class="btn btn-danger my-2 my-sm-0" type="submit"> Αποσύνδεση</a>								
		<%
			} else if (organizer != null){
		%>	
			<a style="color:white;"><%=organizer.getUsername() %></a>
			&nbsp;			
			&nbsp;			
			<a href="logout.jsp" class="btn btn-danger my-2 my-sm-0" type="submit"> Αποσύνδεση</a>			
		<%
			} else {
		%>
			<a href="loginform.jsp" class="btn btn-warning my-2 my-sm-0" type="submit">Σύνδεση</a>
			&nbsp;
			<a href="signupform.jsp" class="btn btn-danger my-2 my-sm-0" type="submit">Εγγραφή</a>
		<%
			}
		%>			            
    </div>
</nav>