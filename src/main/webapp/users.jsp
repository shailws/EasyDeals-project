<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
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
		<div class="container p-3 pt-5 mt-5">
			<div class="card shadow rounded-4">
				<div class="card-header text-center bg-primary text-white fs-5">
					Users</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-hover">
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
							<tbody>
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
									PreparedStatement ps = con.prepareStatement("SELECT * FROM user");
									ResultSet rs = ps.executeQuery();
									while (rs.next()) {
										String Sr_no = rs.getString("id");
										String Name7 = rs.getString("name");
										String Mobileno = rs.getString("mobileno");
										String Email = rs.getString("email");
										String Address = rs.getString("address");
										String Profile_img = rs.getString("Profile_img");
								%>
								<tr>
									<td class="text-center"><%=Sr_no%></td>
									<td class="text-center">
										<%
										if (Profile_img != null && !Profile_img.isEmpty()) {
										%> <img src="<%=Profile_img%>" alt="Profile"
										class="img-fluid rounded-circle"
										style="width: 50px; height: 50px;"> <%
 } else {
 %> <img src="default-profile.png" alt="Default Profile"
										class="img-fluid rounded-circle"
										style="width: 50px; height: 50px;"> <%
 }
 %>
									</td>
									<td class="text-break"><%=Name7%></td>
									<td class="text-break"><%=Email%></td>
									<td class="text-nowrap"><%=Mobileno%></td>
									<td class="text-break"><%=Address%></td>
								</tr>
								<%
								}
								} catch (Exception e) {
								out.println("<tr><td colspan='6' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
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



	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
