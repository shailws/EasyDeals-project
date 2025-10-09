<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - EasyDeals</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<%@ include file="header.jsp"%>

	<%
	String msg = "";

	String name1 = request.getParameter("name") != null ? request.getParameter("name") : "";
	String mobileno = request.getParameter("mobileno") != null ? request.getParameter("mobileno") : "";
	String email = request.getParameter("email") != null ? request.getParameter("email") : "";
	String address = request.getParameter("address") != null ? request.getParameter("address") : "";
	String city = request.getParameter("city") != null ? request.getParameter("city") : "";
	String state = request.getParameter("state") != null ? request.getParameter("state") : "";
	String pincode = request.getParameter("pincode") != null ? request.getParameter("pincode") : "";
	String password = request.getParameter("password") != null ? request.getParameter("password") : "";
	String cpassword = request.getParameter("cpassword") != null ? request.getParameter("cpassword") : "";
	String profile_img = request.getParameter("Profile_img") != null ? request.getParameter("Profile_img") : "";

	if (request.getParameter("register") != null) {
		if (!password.equals(cpassword)) {
			msg = "Passwords do not match!";
		} else {
			try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

		PreparedStatement checkStmt = con.prepareStatement("SELECT mobileno FROM user WHERE mobileno = ?");
		checkStmt.setString(1, mobileno);
		ResultSet rs = checkStmt.executeQuery();

		if (rs.next()) {
			msg = "Mobile number already exists!";
		} else {
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO user (name, mobileno, email, address, city, state, pincode, password, Profile_img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pst.setString(1, name1);
			pst.setString(2, mobileno);
			pst.setString(3, email);
			pst.setString(4, address);
			pst.setString(5, city);
			pst.setString(6, state);
			pst.setString(7, pincode);
			pst.setString(8, password);
			pst.setString(9, profile_img);

			int result = pst.executeUpdate();
			if (result > 0) {
				response.sendRedirect("login.jsp");
			} else {
				msg = "Registration failed. Please try again.";
			}
			pst.close();
		}
		rs.close();
		checkStmt.close();
		con.close();
			} catch (Exception e) {
		msg = "Error: " + e.getMessage();
			}
		}
	}
	%>

	<!-- Registration Form Section -->
	<section>
		<div class="container mt-5 p-3 min-vh-100">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-5 col-md-6 text-center mt-4 mt-md-0 mb-4">
					<img src="./images/ecom.png" alt="E-commerce"
						class="img-fluid rounded ">
				</div>
				<div class="col-lg-7 col-md-6">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
						<div class="card-header text-center">
							<h4>Register</h4>
						</div>

						<%
						if (!msg.isEmpty()) {
						%>
						<div class="alert alert-danger text-center mt-3"><%=msg%></div>
						<%
						}
						%>

						<div class="card-body">
							<form action="register.jsp" method="post">
								<div class="row g-3">
									<div class="col-md-6">
										<label class="form-label" for="name1">Name</label> <input
											type="text" class="form-control" name="name" id="name1"
											value="<%=name1%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="mobileno1">Mobile
											Number</label> <input type="tel" class="form-control" name="mobileno"
											id="mobileno1" value="<%=mobileno%>" required>
									</div>
									<div class="col-12">
										<label class="form-label" for="email1">Email</label> <input
											type="email" class="form-control" name="email" id="email1"
											value="<%=email%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="address1">Address</label> <input
											type="text" class="form-control" name="address" id="address1"
											value="<%=address%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="city1">City</label> <input
											type="text" class="form-control" name="city" id="city1"
											value="<%=city%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="state1">State</label> <input
											type="text" class="form-control" name="state" id="state1"
											value="<%=state%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="pincode1">Pincode</label> <input
											type="text" class="form-control" name="pincode" id="pincode1"
											value="<%=pincode%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="pass1">Password</label> <input
											type="password" class="form-control" name="password"
											id="pass1" value="<%=password%>" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="cpass1">Confirm
											Password</label> <input type="password" class="form-control"
											name="cpassword" id="cpass1" value="<%=cpassword%>"
											required>
									</div>
									<div class="col-md-12">
										<label class="form-label" for="p_img1">Profile Image
											(Path or URL)</label> <input type="text" class="form-control"
											name="Profile_img" id="p_img1" value="<%=profile_img%>"
											required>
									</div>
									<div class="col-12">
										<button name="register" type="submit"
											class="btn btn-primary w-100">Register</button>
									</div>
								</div>
							</form>
						</div>
						<div class="card-footer text-center">
							<p>
								Have an account? <a href="./login.jsp"
									class="text-decoration-none">Login</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
