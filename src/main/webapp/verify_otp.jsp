<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Verify OTP</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>

	<%
	/* ---------------- YOUR BACKEND CODE (unchanged) ---------------- */

	String userOtp = request.getParameter("otp");
	String error = "";

	if (request.getParameter("verify") != null) {
		int sessionOtp = (int) session.getAttribute("otp");

		if (String.valueOf(sessionOtp).equals(userOtp)) {
			response.sendRedirect("reset_password.jsp");
		} else {
			error = "Incorrect OTP!";
		}
	}
	%>

	<%@ include file="header.jsp"%>

	<section>
		<div class="container mt-5 p-4 min-vh-100">
			<div
				class="row d-flex justify-content-center align-items-center pt-5">

				<!-- Image -->
				<div class="col-md-6 text-center">
					<img src="./images/ecom.png" class="img-fluid rounded"
						style="max-height: 380px;">
				</div>

				<!-- OTP Card -->
				<div class="col-md-6 d-flex justify-content-center">
					<div class="card shadow p-3 w-100" style="max-width: 400px;">

						<div class="card-header text-center">
							<h4>Verify OTP</h4>

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
									<label class="form-label">Enter OTP</label> <input type="text"
										name="otp" class="form-control" required>
								</div>

								<button name="verify" class="btn btn-primary w-100">Verify</button>

							</form>
						</div>

						<div class="card-footer text-center">
							<a href="forgot_password.jsp" class="text-decoration-none">Resend
								OTP</a>
						</div>

					</div>
				</div>

			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>

</body>
</html>
