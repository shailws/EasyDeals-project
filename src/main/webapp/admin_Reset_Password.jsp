<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reset Password</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>

	<%
	/* ---------------- YOUR BACKEND CODE (unchanged) ---------------- */

	String newPass = request.getParameter("newPass");
	String mobile = (String) session.getAttribute("mobile");
	String msg = "";

	if (request.getParameter("reset") != null) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

			PreparedStatement ps = con.prepareStatement("UPDATE admin SET password=? WHERE phone=?");
			ps.setString(1, newPass);
			ps.setString(2, mobile);

			int count = ps.executeUpdate();

			if (count > 0) {
		response.sendRedirect("adminLogin.jsp");
			} else {
		msg = "Error updating password!";
			}

		} catch (Exception e) {
			msg = "Error updating password!";
			e.printStackTrace();
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

				<!-- Reset Password Card -->
				<div class="col-md-6 d-flex justify-content-center">
					<div class="card shadow p-3 w-100" style="max-width: 400px;">

						<div class="card-header text-center">
							<h4>Reset Password</h4>

							<%
							if (msg != null && !msg.isEmpty()) {
							%>
							<div class="alert alert-danger mt-2"><%=msg%></div>
							<%
							}
							%>
						</div>

						<div class="card-body">
							<form method="post">

								<div class="mb-3">
									<label class="form-label">New Password</label> <input
										type="password" name="newPass" class="form-control" required>
								</div>

								<button name="reset" class="btn btn-primary w-100">Save
									Password</button>

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
