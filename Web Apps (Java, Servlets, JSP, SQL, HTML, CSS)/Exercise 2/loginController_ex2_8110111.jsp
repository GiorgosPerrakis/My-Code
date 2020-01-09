<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exercise2_2018_2019_8110111.*, java.util.List" %>
<%@ page errorPage="error_ex2_8110111.jsp"%>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

UserDAO userdao = new UserDAO();

User newuser = null;

RequestDispatcher rderror = request.getRequestDispatcher("/login_ex2_8110111.jsp");
RequestDispatcher rdsuccess = request.getRequestDispatcher("/dashboard_ex2_8110111.jsp");

try {
	userdao.authenticate(username, password);

	newuser = userdao.findUser(username);

	session.setAttribute("ex2-user-object", newuser);
		
	rdsuccess.forward(request, response);		

} catch(NumberFormatException e) {

	request.setAttribute("message", "Wrong username or password");
	rderror.forward(request, response);
	return;

} catch(Exception e) {

	request.setAttribute("message", e.getMessage());
	rderror.forward(request, response);
	return;

}

%>
