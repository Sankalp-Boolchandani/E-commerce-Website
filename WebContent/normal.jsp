<%@page import="entities.User"%>
<%
	User user = (User) session.getAttribute("current_user");
	if (user == null) {
		session.setAttribute("message", "you are not logged in, login first");
		response.sendRedirect("login.jsp");
		return;
	} else {
		if (user.getUserType().equals("admin")) {
			session.setAttribute("message", "You are not an User");
			response.sendRedirect("login.jsp");
			return;
		} else {

		}
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<%
	response.sendRedirect("index.jsp");
	%>
</body>
</html>