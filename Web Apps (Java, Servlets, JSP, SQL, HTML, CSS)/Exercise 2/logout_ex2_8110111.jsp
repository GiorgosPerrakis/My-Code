<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_ex2_8110111.jsp"%>

<%
session.invalidate();
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">	
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- automatically will redirect to index_ex2_8110111.jsp after 2 seconds -->
		<meta http-equiv="refresh" content="2;url=index_ex2_8110111.jsp" />
		
		<meta name="description" content="2η Ατομική Άσκηση - Sign out page">
		<meta name="author" content="your email here">
		<link rel="icon" href="images/favicon.ico">
		
		<title>2η Ατομική Άσκηση - Sign out page</title>
		
		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="css/bootstrap.min.css">

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
					</ul>
					<ul class="nav navbar-nav navbar-right">
							<li><a href="register_8110111.html">Register</a></li>
							<li><a href="login_ex2_8110111.jsp">Sign in</a></li>			            
					</ul>		
		
				</div>
				<!--/.nav-collapse -->
			</div>
		</nav>

		<div class="container theme-showcase" role="main">

			<div class="alert alert-success text-center" role="alert">Η έξοδος πραγματοποιηθηκε με επιτυχία</div>		

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
