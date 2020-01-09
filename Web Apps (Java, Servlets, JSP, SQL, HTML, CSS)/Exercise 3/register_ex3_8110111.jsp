<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exercise3_2018_2019_8110111.*, java.util.List" %>
<%@ page errorPage="error_ex3_8110111.jsp"%>


<%
			
User user = (User) session.getAttribute("ex3-user-object");

if(user != null) {		
    response.sendRedirect("dashboard_ex3_8110111.jsp");
	return;
}	


%>


<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Lab exercise template 2018-2019">
	<meta name="author" content="sofos@aueb.gr">
	<link rel="icon" href="images/favicon.ico">

	<title>Register</title>

	<link rel="stylesheet" href="css/bootstrap.min.css">	
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link href="css/theme_8110111.css" rel="stylesheet">
	</head>
	
	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span> <span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">8110111</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="index_ex3_8110111.jsp">Home</a></li>					
						<li><a href="about_ex3_8110111.jsp">About</a></li>					
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="active"><a href="register_ex3_8110111.jsp">Register</a></li>
			        	<li><a href="login_ex3_8110111.jsp">Sign in</a></li>			            
			        </ul>					
				</div>
			</div>
		</nav>

		<div class="container theme-showcase" role="main">
			<div class="jumbotron">
				<h1>3η Ατομική Άσκηση</h1>
			</div>
			<div class="page-header">
				<h1>Registration Form</h1>
			</div>

			<div class="panel panel-warning" class="well">
				<div class="panel-heading">
					<p class="panel-title" style="text-align:center;">
						Please fill in the following form to create an account.
					</p>
				</div>	
			</div>

			<form class="form-horizontal" name="register_form" method="post" action="servlet/RegisterController_ex3_8110111">
				<div class="form-group">
					<label class="col-sm-2 control-label">Name</label>
					<div class="col-sm-6">
						<input type="text" name="name_field" class="form-control" placeholder="your name">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Surname</label>
					<div class="col-sm-6">
						<input type="text" name="surname_field" class="form-control" placeholder="your surname">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Email</label>
					<div class="col-sm-6">
						<input type="email" name="email_field" class="form-control" placeholder="your email">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Username</label>
					<div class="col-sm-6">
						<input type="text" name="username_field" class="form-control" placeholder="your username">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Password</label>
					<div class="col-sm-6">
						<input type="password" name="password_field" class="form-control" placeholder="your password">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Confirm</label>
					<div class="col-sm-6">
						<input type="password" name="confirm_field" class="form-control" placeholder="confirm your password">
					</div>
				</div>	
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-6">
						<div class="checkbox">
							<label><input type="checkbox" name="checkbox_field"><b style="color:rgb(0, 122, 202);">I agree to the terms and conditions</b></label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-6 col-sm-offset-2">
						<button type="submit" name="submit_button" class="btn btn-success">
							<span class="glyphicon glyphicon-ok"></span> Submit
						</button>
						<button type="reset" name="reset_button" class="btn btn-danger">
							<span class="glyphicon glyphicon-remove" id="reset"></span> Cancel
						</button>
					</div>
				</div>
			</form>	
		</div>
		<!-- /container -->

		<%@ include file="footer_ex3_8110111.jsp"%>
	</body>
</html>

