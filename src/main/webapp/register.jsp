<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
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

	<%
	String name1 = request.getParameter("name");
	String mobileno = request.getParameter("mobileno");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String pincode = request.getParameter("pincode");
	String password = request.getParameter("password");
	String cpassword = request.getParameter("cpassword");
	String profile_img = request.getParameter("Profile_img");

	String errorMsg = "";

	if (request.getParameter("register") != null) {

		if (!password.equals(cpassword)) {
			errorMsg = "Password and Confirm Password didn't match!";
		} else {

			try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
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
		}

			} catch (Exception e) {
		e.printStackTrace();

		if (e.getMessage().contains("mobileno")) {
			errorMsg = "Mobile number is already registered!";
		} else if (e.getMessage().contains("email")) {
			errorMsg = "Email is already registered!";
		} else {
			errorMsg = "Somthing went wrong";
		}
			}
		}
	}
	%>

	<%@ include file="header.jsp"%>
	<!-- Registration Form Section -->
	<section>
		<div class="container mt-5 p-3 min-vh-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-md-6 col-lg-5 text-center mt-4 mt-md-0 mb-4">
					<img src="./images/ecom.png" alt="E-commerce"
						class="img-fluid rounded ">
				</div>
				<div class="col-md-6 col-lg-7">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
						<div class="card-header text-center">
							<h4>Register</h4>

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
							<form action="#" method="Get" enctype="multipart/form-data">
								<div class="row g-3">
									<div class="col-md-6">
										<label class="form-label" for="name1">Name</label> <input
											type="text" class="form-control" name="name" id="name1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="mobileno1">Mobile
											Number</label> <input type="tel" class="form-control" name="mobileno"
											id="mobileno1" required>
									</div>
									<div class="col-12">
										<label class="form-label" for="email1">Email</label> <input
											type="email" class="form-control" name="email" id="email1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="address1">Address</label> <input
											type="text" class="form-control" name="address" id="address1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="city1">City</label> <input
											type="text" class="form-control" name="city" id="city1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="state1">State</label> <input
											type="text" class="form-control" name="state" id="state1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="pincode1">Pincode</label> <input
											type="text" class="form-control" name="pincode" id="pincode1"
											required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="pass1">Password</label> <input
											type="password" class="form-control" name="password"
											id="pass1" minlength="5" required>
									</div>
									<div class="col-md-6">
										<label class="form-label" for="cpass1">Confirm
											Password</label> <input type="password" class="form-control"
											name="cpassword" id="cpass1" minlength="5" required>
									</div>
									<div class="col-12">
										<label class="form-label" for="p_img1">Profile Image</label> <input
											type="file" class="form-control" name="Profile_img"
											id="p_img1" required>
									</div>
									<div class="col-12">
										<button type="submit" name="register"
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

	<script ="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
		
	</script>
</body>
</html>
