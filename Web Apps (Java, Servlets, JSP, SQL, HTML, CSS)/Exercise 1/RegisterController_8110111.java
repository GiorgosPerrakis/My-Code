import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterController_8110111 extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = new PrintWriter(response.getWriter(), true);

         String name = request.getParameter("name_field");
         String surname = request.getParameter("surname_field");
         String email = request.getParameter("email_field");
         String username = request.getParameter("username_field");
         String password = request.getParameter("password_field");
         String confirm = request.getParameter("confirm_field");
         String active = request.getParameter("checkbox_field");

         try {
			out.println("	<!DOCTYPE html>");
			out.println("	<html lang='en'>");
			out.println("	<head>");
			out.println("	<meta charset='utf-8'>");
			out.println("	<meta http-equiv='X-UA-Compatible' content='IE=edge'>");
			out.println("	<meta name='viewport' content='width=device-width, initial-scale=1'>");
			out.println("	<meta name='description' content='Lab exercise template 2018-2019'>");
			out.println("	<meta name='author' content='sofos@aueb.gr'>");
			out.println("	<link rel='icon' href='../images/favicon.ico'>");
			out.println("");
			out.println("	<title>Results</title>");
			out.println("");
			out.println("	<link rel='stylesheet' href='../css/bootstrap.min.css'>	");
			out.println("	<link rel='stylesheet' href='../css/bootstrap-theme.min.css'>");
			out.println("	<link href='../css/theme_8110111.css' rel='stylesheet'>");
			out.println("	</head>");
			out.println("	<body>");
			out.println("	   <nav class='navbar navbar-inverse navbar-fixed-top'>");
			out.println("			<div class='container'>");
			out.println("				<div class='navbar-header'>");
			out.println("					<button type='button' class='navbar-toggle collapsed' data-toggle='collapse' data-target='#navbar' aria-expanded='false' aria controls='navbar'>");
			out.println("						<span class='sr-only'>Toggle navigation</span>");
			out.println("						<span class='icon-bar'></span> <span class='icon-bar'></span>");
			out.println("						<span class='icon-bar'></span>");
			out.println("					</button>");
			out.println("					<a class='navbar-brand' href='#'>8110111</a>");
			out.println("				</div>");
			out.println("				<div id='navbar' class='navbar-collapse collapse'>");
			out.println("					<ul class='nav navbar-nav'>");
			out.println("						<li><a href='../index_8110111.html'>Home</a></li>");
			out.println("						<li class='active_8110111'><a href='../register_8110111.html'>Register</a></li>					");
			out.println("						<li><a href='../about_8110111.html'>About</a></li>					");
			out.println("					</ul>		");
			out.println("				</div>");
			out.println("			</div>");
			out.println("		</nav>");
			out.println("");
			out.println("		<div class='container theme-showcase' role='main'>");
			out.println("			<div class='jumbotron'>");
			out.println("				<h1>1η Ατομική Άσκηση</h1>");
			out.println("			</div>");


            name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
            surname = new String(surname.getBytes("ISO-8859-1"), "UTF-8");
            email = new String(email.getBytes("ISO-8859-1"), "UTF-8");
            username = new String(username.getBytes("ISO-8859-1"), "UTF-8");
            password = new String(password.getBytes("ISO-8859-1"), "UTF-8");
            confirm = new String(confirm.getBytes("ISO-8859-1"), "UTF-8");

			if(!("on".equals(active)))
			{
              out.println("<div class='page-header'>");
              out.println("<h1>Registration Failed!</h1>");
              out.println("</div>");
              out.println("<div class='panel panel-danger' class='well'>");
              out.println("<div class='panel-heading'>");
              out.println("<p class='panel-title'>Sorry, you must agree to terms and conditions in order to register</p>");
              out.println("</div>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("<footer class='navbar-inverse'>");
			  out.println("<div class='container'>");
			  out.println("<div class='row'>");
			  out.println("<div class='col-xs-12'>");
			  out.println("<p class='text-center'>&copy; Copyright 2018 by ismgroup21</p>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</footer>");
			  out.println("<script src='../js/jquery.min.js'></script>");
			  out.println("<script	src='../js/bootstrap.min.js'></script>");

              out.println("</body>");
              out.println("</html>");
              return;
			}
            else if (!(name.length() >= 3) || !(surname.length() >= 3) || !(username.length() >= 5) || !(password.length() >= 5) || !(password.equals(confirm)))
			{
              out.println("<div class='page-header'>");
              out.println("<h1>Registration Form errors</h1>");
              out.println("</div>");
              out.println("<div class='panel panel-danger' class='well'>");
              out.println("<div class='panel-heading'>");
              out.println("<ol>");

		      if (!(name.length() >= 3)) {
              	out.println("<li>Name must be at least 3 characters long</li>");		
			  }

		      if (!(surname.length() >= 3)) {
				out.println("<li>Surname must be at least 3 characters long</li>");
			  }

		      if (!(username.length() >= 5)) {
				out.println("<li>Username must be at least 5 characters long</li>");
			  }

		      if (!(password.length() >= 5)) {
				out.println("<li>Password must be at least 5 characters long</li>");
			  }

		      if (!(password.equals(confirm))) {
   				out.println("<li>Password must be the same as the Confirm</li>");
			  }
              out.println("</ol>");
              out.println("</div>");
              out.println("</div>");

              out.println("<p style='text-align: center;'><a href='../register_8110111.html' class='btn btn-info' role='button'><span class='glyphicon glyphicon-chevron-left'></span> Back to the form</a></p>");
			  out.println("</button>");
			  out.println("</div>");

			  out.println("<footer class='navbar-inverse'>");
			  out.println("<div class='container'>");
			  out.println("<div class='row'>");
			  out.println("<div class='col-xs-12'>");
			  out.println("<p class='text-center'>&copy; Copyright 2018 by ismgroup21</p>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</footer>");
			  out.println("<script src='../js/jquery.min.js'></script>");
			  out.println("<script	src='../js/bootstrap.min.js'></script>");

              out.println("</body>");
              out.println("</html>");
              return;
            }
			else {
              out.println("<div class='page-header'>");
              out.println("<h1>Registration almost done!</h1>");
              out.println("</div>");
              out.println("<div class='panel panel-warning' class='well'>");
              out.println("<div class='panel-heading'>");
              out.println("<b>Note: </b>" + "A verification link has been send to the email: " + email);
              out.println("</div>");
              out.println("</div>");
			  out.println("<ol class='list-unstyled'>");
              out.println("<li><b>Name: </b>" + name + "</li>");
              out.println("<li><b>Surname: </b>" + surname + "</li>");
              out.println("<li><b>Username: </b>" + username + "</li>");
              out.println("<li><b>Email: </b>" + email + "</li>");
              out.println("</ol>");			  
			  out.println("</div>");

			  out.println("<footer class='navbar-inverse'>");
			  out.println("<div class='container'>");
			  out.println("<div class='row'>");
			  out.println("<div class='col-xs-12'>");
			  out.println("<p class='text-center'>&copy; Copyright 2018 by ismgroup21</p>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</div>");
			  out.println("</footer>");
			  out.println("<script src='../js/jquery.min.js'></script>");
			  out.println("<script	src='../js/bootstrap.min.js'></script>");

              out.println("</body>");
              out.println("</html>");
			}

          } catch (Exception ex) {
            out.println("Exception: " + ex.getMessage());
            out.println("</body>");
            out.println("</html>");
          }
      }

      public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
            response.sendRedirect("../register_8110111.html");
      	}
}
