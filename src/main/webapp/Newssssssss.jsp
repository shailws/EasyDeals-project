<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ import page="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card-body">
		<form action="#" method="get">
			<div class="mb-3">
				<label class="form-label" for="email1">Email</label> <input
					type="email" class="form-control" name="email" id="email1" required
					autocomplete="off">
			</div>

			<div class="mb-3">
				<label class="form-label" for="pass1">Password</label> <input
					type="password" class="form-control" name="password" id="pass1"
					required autocomplete="off">
			</div>

			<div class="text-center">
				<button name="login" type="submit" class="btn btn-primary w-100">Login</button>
			</div>
		</form>
		
		<%-- <%
	if (request.getParameter("login") != null) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
		PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
		ps.setString(1, email);
		ps.setString(2, password);
		
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			HttpSession ses = request.
		}
	}
	%> --%>
	</div>
</body>
</html>