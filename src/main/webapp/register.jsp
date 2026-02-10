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

							<!-- ===== ADD USER SUCCESS / ERROR MESSAGE ===== -->
							<%
							String uR_message = (String) session.getAttribute("uR_message");

							if (uR_message != null && !uR_message.isEmpty()) {
							%>
							<div class="alert text-center mt-3 alert-danger">
								<%=uR_message%>
							</div>
							<%
							session.removeAttribute("uR_message");
							}
							%>

						</div>
						<div class="card-body">
							<form action="registrationUser" method="post"
								enctype="multipart/form-data">
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
