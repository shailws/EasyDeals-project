<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<%@ include file="header.jsp"%>

	<section>
		<div class="container mt-5 p-4 min-vh-100">
			<div class="row justify-content-center align-items-center pt-5">

				<!-- Image Section -->
				<div class="col-lg-6 col-md-6 col-sm-12 text-center">
					<img src="./images/ecom.png" alt="E-commerce"
						class="img-fluid rounded" style="max-height: 400px;">
				</div>

				<!-- Login Form Section -->
				<div
					class="col-lg-6 col-md-6 col-sm-12 d-flex justify-content-center">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounde w-100"
						style="max-width: 400px;">
						<div class="card-header text-center">
							<h4>Login</h4>
						</div>

						<%
						String invalidMsg = "";
						String updatePass = "";

						if (request.getParameter("login") != null) {
							String email = request.getParameter("email");
							String password = request.getParameter("password");

							try {
								Class.forName("com.mysql.cj.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
								PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
								ps.setString(1, email);
								ps.setString(2, password);

								ResultSet rs = ps.executeQuery();

								if (rs.next()) {

							/* String Name1 = rs.getString("name");
							session.setAttribute("name", Name1); */

							response.sendRedirect("index.jsp");

							return;
								} else {
							invalidMsg = "Invalid email or password!";
								}

							} catch (Exception e) {
								e.getMessage();
							}
						}

						if (request.getParameter("message") != null) {
							updatePass = request.getParameter("message");
						}
						%>

						<%
						if (!invalidMsg.isEmpty()) {
						%>
						<div class="alert alert-danger text-center mt-3"><%=invalidMsg%></div>
						<%
						}
						%>

						<%
						if (!updatePass.isEmpty()) {
						%>
						<div class="alert alert-success text-center mt-3"><%=updatePass%></div>
						<%
						}
						%>

						<div class="card-body">
							<form action="#" method="get">
								<div class="mb-3">
									<label class="form-label" for="email1">Email</label> <input
										type="email" class="form-control" name="email" id="email1"
										required autocomplete="off">
								</div>

								<div class="mb-3">
									<label class="form-label" for="pass1">Password</label> <input
										type="password" class="form-control" name="password"
										id="pass1" required autocomplete="off">
								</div>

								<div class="text-center">
									<button name="login" type="submit"
										class="btn btn-primary w-100">Login</button>
								</div>
							</form>
						</div>

						<div class="card-footer text-center">
							<a href="forgot_password.jsp" class="text-decoration-none">Forgot
								Password?</a><br> Don't have an account? <a
								href="./register.jsp" class="text-decoration-none">Create
								One</a><br>
								<a href="GoogleLoginServlet">login with google</a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>


	 <%@ include file="footer.jsp"%> 


	<!-- Bootstrap Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
