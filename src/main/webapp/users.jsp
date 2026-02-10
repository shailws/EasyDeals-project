<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

<!-- REQUIRED: stops mobile from shrinking content -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Users List</title>

<link rel="stylesheet" href="style2.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	rel="stylesheet">

</head>

<body>
	<%@ include file="header.jsp"%>

	<section>
		<div class="container p-3 mt-5 pt-5 min-vh-100">

			<div class="mb-3 text-start">
				<a href="admin.jsp" class="btn btn-outline-primary"> ← Back to
					Admin Dashboard </a>
			</div>

			<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
				<div class="card-header text-center bg-primary text-white fs-5">
					Users</div>

				<div class="card-body">

					<!-- SCROLLABLE TABLE -->
					<div class="table-responsive">
						<table class="table table-bordered table-hover w=100">
							<thead class="table-light text-center">
								<tr>
									<th>Sl No</th>
									<th>Profile</th>
									<th>Name</th>
									<th>Email</th>
									<th>Mobile No</th>
									<th>Address</th>
								</tr>
							</thead>

							<tbody class="table-light text-center">
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

									PreparedStatement ps = con.prepareStatement("SELECT * FROM user");
									ResultSet rs = ps.executeQuery();

									while (rs.next()) {
										String srNO = rs.getString("id");
										String p_image = rs.getString("Profile_img");
										String Name1 = rs.getString("name");
										String Email = rs.getString("email");
										String mobilNo = rs.getString("mobileno");
										String Address = rs.getString("address");
								%>
								<tr>
									<td><%=srNO%></td>

									<td><img src="<%=p_image%>"
										style="width: 60px; height: 60px; border-radius: 50%; object-fit: cover;">
									</td>

									<td><%=Name1%></td>
									<td><%=Email%></td>
									<td><%=mobilNo%></td>
									<td><%=Address%></td>
								</tr>
								<%
								}
								} catch (Exception e) {
								e.printStackTrace();
								}
								%>
							</tbody>
						</table>
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
