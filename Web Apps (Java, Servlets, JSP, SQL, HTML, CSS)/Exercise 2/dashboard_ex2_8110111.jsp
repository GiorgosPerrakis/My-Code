<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exercise2_2018_2019_8110111.*, java.util.List" %>
<%@ page errorPage="error_ex2_8110111.jsp"%>


<%
RequestDispatcher rderror1 = request.getRequestDispatcher("/login_ex2_8110111.jsp");
			
User user = (User) session.getAttribute("ex2-user-object");

if(user == null) {		
	request.setAttribute("message", "You are not authorized to access this resource. Please login.");
	rderror1.forward(request, response);
	return;
}	


%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<meta name="description" content="2η Ατομική Άσκηση 2018-2019 - Dashboard">
		<meta name="author" content="your email here">
		<link rel="icon" href="images/favicon.ico">

		<title>2η Ατομική Άσκηση - Dashboard</title>

		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="css/bootstrap.min.css">	
		<!-- Bootstrap Optional theme -->
		<link rel="stylesheet" href="css/bootstrap-theme.min.css">
		<!-- Custom styles for this template -->
		<link href="css/theme_8110111.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	
	<body>

		<!-- Fixed navbar -->
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span> <span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">8110111</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="index_ex2_8110111.jsp">Home</a></li>										
						<li><a href="about_ex2_8110111.jsp">About</a></li>
						<li class="active"><a href="dashboard_ex2_8110111.jsp">Dashboard</a></li>					
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><p class="navbar-text">Signed in as <%=user.getUsername() %></p></li>
			        	<li><a href="logout_ex2_8110111.jsp"><span class="glyphicon glyphicon-log-out"></span> Sign out</a></li>			            
			        </ul>		
		
				</div>
				<!--/.nav-collapse -->
			</div>
		</nav>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="jumbotron">
				<h1>2η Ατομική Άσκηση</h1>
			</div>

			<!-- Page Title -->
			<div class="page-header">
				<h1>Welcome <%=user.getName() %> <%=user.getSurname() %></h1>
			</div>
			
		</div>
		<!-- /container -->

		<!-- footer -->
		<footer class="navbar-inverse">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<p class="text-center">&copy; Copyright 2018 by ismgroup21</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- End footer -->
		
		<!-- =================== Place all javascript at the end of the document so the pages load faster =================== -->
		<!-- jQuery library -->
		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>
	</body>
</html>
