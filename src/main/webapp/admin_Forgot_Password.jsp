<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forgot Password</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
</head>

<body>

	<%
	String mobile = request.getParameter("mobile");
		String error = "";

		if (request.getParameter("sendOtp") != null) {
			try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

		PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE phone=?");
		ps.setString(1, mobile);
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			// Generate OTP
			int otp = new Random().nextInt(900000) + 100000;

			// Store OTP & mobile in session
			session.setAttribute("otp", otp);
			session.setAttribute("mobile", mobile);

			// Show OTP temporarily
			out.println("<script>alert(' Please Copy Your OTP: " + otp + "');</script>");

			// Redirect to verify page
			out.println("<script>setTimeout(function(){ window.location='admin_Verify_Otp.jsp'; }, 1000);</script>");

		} else {
			error = "Mobile number not registered!";
		}

	} catch (Exception e) {
		error = "Something went wrong!";
		e.printStackTrace();
	}
	}
	%>

	<%@ include file="header.jsp"%>

	<section>
		<div class="container mt-5 p-4 min-vh-100">
			<div
				class="row d-flex justify-content-center align-items-center pt-5">

				<!-- Left Image -->
				<div class="col-md-6 text-center">
					<img src="./images/ecom.png" class="img-fluid rounded"
						style="max-height: 380px;">
				</div>

				<!-- Right Card -->
				<div class="col-md-6 d-flex justify-content-center">
					<div class="card shadow p-3 w-100" style="max-width: 400px;">

						<div class="card-header text-center">
							<h4>Forgot Password</h4>

							<%
							if (error != null && !error.isEmpty()) {
							%>
							<div class="alert alert-danger mt-2"><%=error%></div>
							<%
							}
							%>
						</div>

						<div class="card-body">
							<form method="post">

								<div class="mb-3">
									<label class="form-label">Mobile Number</label> <input
										type="text" name="mobile" class="form-control" required>
								</div>

								<button type="submit" name="sendOtp"
									class="btn btn-primary w-100">Send OTP</button>
							</form>
						</div>

						<div class="card-footer text-center">
							<a href="adminLogin.jsp" class="text-decoration-none">Back to
								Login</a>
						</div>

					</div>
				</div>

			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>

</body>
</html>
