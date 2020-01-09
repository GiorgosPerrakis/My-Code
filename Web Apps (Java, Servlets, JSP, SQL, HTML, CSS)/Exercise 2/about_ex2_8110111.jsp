<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exercise2_2018_2019_8110111.*, java.util.List" %>
<%@ page errorPage="error_ex2_8110111.jsp"%>

<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="description" content="Lab exercise template 2018-2019">
	<meta name="author" content="sofos@aueb.gr">
	<link rel="icon" href="images/favicon.ico">

	<title>About</title>

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
						<li class="active"><a href="about_ex2_8110111.jsp">About</a></li>	
						   <%
								User user = (User) session.getAttribute("ex2-user-object");
								if(user != null)  {
						   %>  	          
								<li><a href="dashboard_ex2_8110111.jsp">Dashboard</a></li>	
						   <%
								} 
						   %>
								
					</ul>
					<ul class="nav navbar-nav navbar-right">
						   <%
								if(user != null)  {
						   %>  	          
								<li><p class="navbar-text">Signed in as <%=user.getUsername() %></p></li>	
								<li><a href="logout_ex2_8110111.jsp"><span class="glyphicon glyphicon-log-out"></span> Sign out</a></li>								
						   <%
								} else {
						   %>
								<li><a href="register_8110111.html">Register</a></li>
								<li><a href="login_ex2_8110111.jsp">Sign in</a></li>
						   <%
								}
						   %>			            
			        </ul>					
		
				</div>
				<!--/.nav-collapse -->
			</div>
		</nav>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="jumbotron">
				<h1>ismgroup21</h1>
			</div>

			<!-- Page Title -->
			<div class="page-header">
				<h1>Group Members</h1>
			</div>

			
		</div>
		
		
		<div class="container">
    <div class="media">
        <div class="media-left media-top">
            <img src="images/member1.png" class="media-object">
        </div>
        <div class="media-body">
            <h4 class="media-heading">Νίκος Περράκης</h4>
			<p class="media-heading">8110111</p>
            <p class="glyphicon glyphicon-envelope">n.perrakis@gmail.com</p>
        </div>
    </div>

    <div class="media">
        <div class="media-left media-top">
            <img src="images/member1.png" class="media-object">
        </div>
        <div class="media-body">
            <h4 class="media-heading">Μάνος Σπανάκης</h4> 
			<p class="media-heading">8100170</p>
            <p class="glyphicon glyphicon-envelope">manos@gmail.com</p>
        </div>
    </div>
	
	<br>
	<br>

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

