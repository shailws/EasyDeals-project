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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />

</head>
<body>
	<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	String errorMsg = "";

	if (request.getParameter("login") != null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

			PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
			ps.setString(1, email);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
		HttpSession ses = request.getSession();
		ses.setAttribute("user_name", rs.getString("name"));
		response.sendRedirect("index.jsp");
			} else {
		errorMsg = "Invalid email or password!";
			}

		} catch (Exception e) {
			e.printStackTrace();
			errorMsg = "Something went wrong!";
		}
	}
	%>

	<%@ include file="header.jsp"%>
	<section>
		<div class="container mt-5 p-4 min-vh-100">
			<div
				class="row d-flex justify-content-center align-items-center pt-5">

				<!-- Image Section -->
				<div class="col-sm-12 col-md-6 col-lg-6 text-center">
					<img src="./images/ecom.png" alt="E-commerce"
						class="img-fluid rounded" style="max-height: 400px;">
				</div>

				<!-- Login Form Section -->
				<div
					class="col-sm-12 col-md-6 col-lg-6 d-flex justify-content-center">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounde w-100"
						style="max-width: 400px;">
						<div class="card-header text-center">
							<h4>User Login</h4>

							<%
							if (errorMsg != null && !errorMsg.trim().isEmpty()) {
							%>
							<div class="alert alert-danger mt-2" role="alert">
								<%=errorMsg%>
							</div>
							<%
							}
							%>

						</div>

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
								One</a>
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
