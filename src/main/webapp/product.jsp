<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Product Page</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="style2.css">

</head>
<body>

	<%@ include file="header.jsp"%>

	<section class="mt-5">
		<!-- Search Bar -->
		<div class="container-fluid bg-primary p-4 text-center">
			<form action="product.jsp" method="get"
				class="row g-2 justify-content-center">
				<div class="col-10 col-sm-8 col-md-6">
					<input type="text" class="form-control" name="ch"
						placeholder="Search for products">
				</div>
				<div class="col-auto">
					<button class="btn btn-light text-dark">
						<i class="fa-solid fa-magnifying-glass"></i> Search
					</button>
				</div>
			</form>
		</div>

		<!-- Main Content -->
		<div class="container py-5">
			<div class="row">
				<!-- Categories -->
				<div class="col-md-3 mb-4">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
						<div class="card-body">
							<h5 class="card-title text-center">Categories</h5>
							<div class="list-group">
								<a href="product.jsp"
									class="list-group-item list-group-item-action">All</a>
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
									PreparedStatement ps = con.prepareStatement("SELECT category_name FROM category WHERE isActive = 'active'");
									ResultSet rs = ps.executeQuery();
									while (rs.next()) {
										String Category_name = rs.getString("category_name");
								%>
								<a href="product.jsp?category=<%=Category_name%>"
									class="list-group-item list-group-item-action"> <%=Category_name%>
								</a>
								<%
								}
								con.close();
								} catch (Exception e) {
								e.printStackTrace();
								}
								%>
							</div>
						</div>
					</div>
				</div>

				<!-- Products -->
				<div class="col-md-9">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
						<div class="card-body">
							<h3 class="text-center mb-4">Products</h3>
							<div class="row g-4">
								<%
								String selectedCategory = request.getParameter("category");
								String searchKeyword = request.getParameter("ch");

								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
									PreparedStatement ps;

									if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
										ps = con.prepareStatement("SELECT * FROM product WHERE p_title LIKE ?");
										ps.setString(1, "%" + searchKeyword + "%");
									} else if (selectedCategory != null && !selectedCategory.trim().isEmpty()) {
										ps = con.prepareStatement("SELECT * FROM product WHERE p_category = ?");
										ps.setString(1, selectedCategory);
									} else {
										ps = con.prepareStatement("SELECT * FROM product");
									}

									ResultSet rs = ps.executeQuery();
									boolean hasProducts = false;

									while (rs.next()) {
										hasProducts = true;
										String Sr_no = rs.getString("sr_no");
										String P_title = rs.getString("p_title");
										double P_price = rs.getDouble("p_price");
										String P_image = rs.getString("P_image");
										int P_discount = rs.getInt("p_discount");
										double discountedPrice = P_price - (P_price * P_discount / 100);
								%>
								<div class="col-12 col-sm-6 col-md-4">
									<div
										class="card h-100 text-center shadow p-3 mb-5 bg-body-tertiary rounded d-flex flex-column">
										<div class="product-img-wrapper p-3" style="height: 200px;">
											<img src="<%=P_image%>" alt="Product Image"
												class="img-fluid h-100" style="object-fit: contain;">
										</div>
										<div class="card-body d-flex flex-column">
											<h5 class="card-title text-truncate mb-2"><%=P_title%></h5>
											<p class="card-text mb-3">
												<strong>₹<%=String.format("%.2f", discountedPrice)%></strong><br>
												<small class="text-muted"><del>
														₹<%=P_price%></del></small> <span class="text-success ms-1"><%=P_discount%>%
													off</span>
											</p>
											<div class="mt-auto">
												<a href="pdetails.jsp?sr_no=<%=Sr_no%>"
													class="btn btn-primary w-100">View Details</a>
											</div>
										</div>
									</div>
								</div>

								<%
								}
								if (!hasProducts) {
								%>
								<div class="col-12">
									<div class="alert alert-info text-center" role="alert">
										No products found.</div>
								</div>
								<%
								}
								con.close();
								} catch (Exception e) {
								e.printStackTrace();
								}
								%>
							</div>
						</div>
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
