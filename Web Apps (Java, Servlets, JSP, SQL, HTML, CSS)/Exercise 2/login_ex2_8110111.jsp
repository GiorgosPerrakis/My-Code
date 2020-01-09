<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_ex2_8110111.jsp"%>
	
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<meta name="description" content="2η Ατομική άσκηση - Sign in page">
		<meta name="author" content="your email here">
		<link rel="icon" href="images/favicon.ico">
	
		<title>2η Ατομική άσκηση - Sign in page</title>
	
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
  
		<div class="container theme-showcase" role="main">

			<% if(request.getAttribute("message") != null) { %>		
				<div class="alert alert-danger text-center" role="alert"><%=(String)request.getAttribute("message") %></div>
			<% } %>

			<form class="form-signin" method="post" action="loginController_ex2_8110111.jsp">
				<h2 class="form-signin-heading text-center">Please sign in</h2>
				<label for="inputusername" class="sr-only">Username</label> 
				<input type="text" name="username" id="inputusername" class="form-control" placeholder="username" required>
				<label for="inputpassword" class="sr-only">Password</label>
				<input name="password" type="password" id="inputpassword" class="form-control" placeholder="password" required>

				<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
			</form>
			<div class="alert alert-info"><strong>Help: </strong>
				<ul>
					<li>For John Doe: jdoe 1111</li>
					<li>For Mary Smith: msmith 1111</li>
				</ul>
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