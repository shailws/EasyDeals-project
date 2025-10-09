<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
%>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h2>Welcome, <%= name %>!</h2>
    <p>Email: <%= email %></p>
</body>
</html>