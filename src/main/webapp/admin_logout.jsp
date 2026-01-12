<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// Destroy the current session to log out the user
	session.invalidate();

	// Redirect the user back to the homepage after logout
	response.sendRedirect("adminLogin.jsp");
	%>
</body>
</html>