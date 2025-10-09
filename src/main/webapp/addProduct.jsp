<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Product Form</title>
<link rel="stylesheet" href="style2.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container  p-3 pt-5 mt-5">
		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-8 col-sm-10">

				<%-- Process Form Submission --%>
				<%
				String productMessage = "";

				if (request.getParameter("add") != null) {

					try {
						String P_title = request.getParameter("p_title");
						String P_description = request.getParameter("p_description");
						String P_category = request.getParameter("p_category");
						String IsActive = request.getParameter("isActive");
						int P_stock = Integer.parseInt(request.getParameter("p_stock"));
						String P_image = request.getParameter("p_image");
						double P_price = Double.parseDouble(request.getParameter("p_price"));
						int P_discount = Integer.parseInt(request.getParameter("p_discount"));

						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
						PreparedStatement ps = con.prepareStatement(
						"INSERT INTO product (p_title, p_description, p_category, p_price, isActive, p_stock, p_image, p_discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
						ps.setString(1, P_title);
						ps.setString(2, P_description);
						ps.setString(3, P_category);
						ps.setDouble(4, P_price);
						ps.setString(5, IsActive);
						ps.setInt(6, P_stock);
						ps.setString(7, P_image);
						ps.setInt(8, P_discount);

						int inserted = ps.executeUpdate();
						con.close();

						if (inserted > 0) {
					productMessage = "product has been added successfully";

						}
					} catch (Exception e) {
						e.getMessage();
					}

				}
				%>

				<div class="card shadow rounded-4">
					<div class="card-header text-center bg-primary text-white fs-5">Add
						Product</div>

					<%
					if (!productMessage.isEmpty()) {
					%>

					<div class="alert alert-success text-center mt-3"><%=productMessage%></div>
					<%
					}
					%>

					<div class="card-body">
						<form action="addProduct.jsp" method="POST">
							<div class="mb-3">
								<label class="form-label">Enter Title</label> <input type="text"
									name="p_title" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Enter Description</label>
								<textarea rows="3" name="p_description" class="form-control"
									required></textarea>
							</div>
							<div class="mb-3">
								<label class="form-label">Category</label> <select
									class="form-select" name="p_category" required>
									<option value="">---Select---</option>
									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
										PreparedStatement ps = con.prepareStatement("SELECT category_name FROM category WHERE isActive = 'active'");
										ResultSet rs = ps.executeQuery();
										while (rs.next()) {
											String categoryName = rs.getString("category_name");
									%>
									<option value="<%=categoryName%>"><%=categoryName%></option>
									<%
									}
									con.close();
									} catch (Exception e) {
									e.printStackTrace();
									}
									%>
								</select>
							</div>
							<div class="mb-3">
								<label class="form-label">Enter Price</label> <input
									type="number" name="p_price" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Enter Discount (%)</label> <input
									type="number" name="p_discount" class="form-control" required>
							</div>

							<script>
										document.addEventListener("DOMContentLoaded", function () {
											const discountInput = document.querySelector("input[name='p_discount']");
											const form = document.querySelector("form");
									
											function validDiscount() {
												let discountValue = parseInt(discountInput.value);
												if (discountValue < 0 || discountValue > 100 || isNaN(discountValue)) {
													discountInput.setCustomValidity("Invalid discount! Please enter a value between 0 and 100.");
												} else {
													discountInput.setCustomValidity(""); // Clear error message
												}
											}
									
											discountInput.addEventListener("input", validDiscount);
									
											form.addEventListener("submit", function (event) {
												validDiscount(); // Validate before submitting
												if (!form.checkValidity()) {
													event.preventDefault(); // Prevent form submission if invalid
												}
											});
										});
							</script>



							<div class="mb-3">
								<label class="form-label">Status</label>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="isActive"
										value="active" checked> <label
										class="form-check-label">Active</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="isActive"
										value="inactive"> <label class="form-check-label">Inactive</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<label class="form-label">Enter Stock</label> <input
										type="number" name="p_stock" class="form-control" required>
								</div>
								<div class="col-md-6">
									<label class="form-label">Upload Image</label> <input
										type="text" name="p_image" class="form-control">
								</div>
							</div>
							<div class="d-grid mt-4">
								<button type="submit" name="add" class="btn btn-primary">Add</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
