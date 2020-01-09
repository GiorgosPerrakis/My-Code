<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user_package.*" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

UserDAO userdao = new UserDAO();

User newuser = null;

RequestDispatcher rderror = request.getRequestDispatcher("/loginform.jsp");
RequestDispatcher rdsuccess = request.getRequestDispatcher("/index.jsp");

try {
	userdao.authenticate(username, password);

	newuser = userdao.findUser(username);

	session.setAttribute("user-object", newuser);
		
	rdsuccess.forward(request, response);		

} catch(NumberFormatException e) {

	request.setAttribute("message", "Λάθος όνομα χρήστη ή κωδικός πρόσβασης");
	rderror.forward(request, response);
	return;

} catch(Exception e) {

	request.setAttribute("message", e.getMessage());
	rderror.forward(request, response);
	return;

}

%>
