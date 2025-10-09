<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Product</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="style2.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<%@ include file="header.jsp"%>

	<section>
		<div class="container p-3 pt-5 mt-5">
			<div class="card shadow rounded-4">
				<div class="card-header text-center bg-primary text-white fs-5">
					View Product</div>
				<div class="card-body">
					<%
					String deleteMessage = "";

					if (request.getParameter("delete") != null) {
						try {
							int SR_no = Integer.parseInt(request.getParameter("delete_id"));
							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection con3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
							PreparedStatement ps3 = con3.prepareStatement("DELETE FROM product WHERE sr_no=?");
							ps3.setInt(1, SR_no);
							int rowDeleted = ps3.executeUpdate();
							if (rowDeleted > 0) {
						deleteMessage = "Product has been deleted successfully";

							}
						} catch (Exception e) {
							e.getMessage();
						}
					}
					%>

					<%
					if (!deleteMessage.isEmpty()) {
					%>
					<div class="alert alert-success text-center mt-3"><%=deleteMessage%></div>
					<%
					}
					%>

					<%
					String updateMessage = "";

					if (request.getParameter("updateMessage") != null) {
						updateMessage = request.getParameter("updateMessage");
					}
					if (!updateMessage.isEmpty()) {
					%>
					<div class="alert alert-success text-center mt-3"><%=updateMessage%></div>
					<%
					}
					%>

					<div class="table-responsive">
						<table class="table table-bordered table-striped table-hover">
							<thead class="table-light text-center">
								<tr>
									<th>Sl No</th>
									<th>Image</th>
									<th>Title</th>
									<th>Category</th>
									<th>Price</th>
									<th>Discount</th>
									<th>Discount Price</th>
									<th>Status</th>
									<th>Stock</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
									PreparedStatement ps = con.prepareStatement("SELECT * FROM product");
									ResultSet rs = ps.executeQuery();
									while (rs.next()) {
										String Sr_no = rs.getString("sr_no");
										String P_title = rs.getString("p_title");
										String P_description = rs.getString("p_description");
										String P_category = rs.getString("p_category");
										double P_price = rs.getDouble("p_price");
										String IsActive = rs.getString("isActive");
										String P_stock = rs.getString("p_stock");
										String P_image = rs.getString("P_image");
										int P_discount = rs.getInt("p_discount");
										double discountedPrice = P_price - (P_price * P_discount / 100);
								%>
								<tr>
									<td><%=Sr_no%></td>
									<td><img src="<%=P_image%>" alt="Product Image"
										class="img-fluid" style="max-width: 60px;"></td>
									<td><%=P_title%></td>
									<td><%=P_category%></td>
									<td><i class="fa-solid fa-indian-rupee-sign"></i> <%=P_price%></td>
									<td><%=P_discount%>%</td>
									<td><i class="fa-solid fa-indian-rupee-sign"></i> <%=String.format("%.2f", discountedPrice)%></td>
									<td><%=IsActive%></td>
									<td><%=P_stock%></td>
									<td>
										<div class="d-flex gap-2">

											<form method="get">
												<input type="hidden" name="delete_id" value="<%=Sr_no%>">
												<button class="btn btn-sm btn-danger" type="submit"
													name="delete">
													<i class="fa-solid fa-trash"></i> Delete
												</button>
											</form>



											<form method="get">
												<button type="button" class="btn btn-primary btn-sm"
													data-bs-toggle="modal"
													data-bs-target="#editModal<%=Sr_no%>">
													<i class="fa-solid fa-pen-to-square fa-1x"></i> Edit
												</button>
											</form>
											<!-- Bootstrap Modal (Unique ID per Row) -->
											<div class="modal fade" id="editModal<%=Sr_no%>"
												tabindex="-1" aria-labelledby="editModalLabel"
												aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="editModalLabel">Edit
																Product</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															<form method="get" action="update_product.jsp">
																<!-- Hidden field to send the product ID -->
																<input type="hidden" name="update_id" value="<%=Sr_no%>">

																<div class="mb-3">
																	<label class="form-label">Image Url</label> <input
																		type="text" name="p_image" class="form-control"
																		placeholder="Enter Image Url" required>
																</div>

																<div class="mb-3">
																	<label class="form-label">Product Title</label> <input
																		type="text" name="p_title" class="form-control"
																		placeholder="Enter Product Title" required>
																</div>

																<div class="mb-3">
																	<label class="form-label">Product p_description</label>


																	<textarea rows="3" name="p_description"
																		placeholder="Enter Product Description"
																		class="form-control" required></textarea>
																</div>



																<div class="mb-3">
																	<label class="form-label">Category</label> <select
																		class="form-select" name="p_category" required>
																		<option value="">---Select---</option>
																		<%
																		try {
																			Class.forName("com.mysql.cj.jdbc.Driver");
																			Connection catCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
																			PreparedStatement catPs = catCon.prepareStatement("SELECT category_name FROM category");
																			ResultSet catRs = catPs.executeQuery();
																			while (catRs.next()) {
																				String categoryName = catRs.getString("category_name");
																		%>
																		<option value="<%=categoryName%>"><%=categoryName%></option>
																		<%
																		}

																		} catch (Exception e) {
																		e.printStackTrace();
																		}
																		%>
																	</select>
																</div>





																<div class="mb-3">
																	<label class="form-label">Product Price</label> <input
																		type="number" name="p_price" class="form-control"
																		placeholder="Enter Product Price" required>
																</div>
																<div class="mb-3">
																	<label class="form-label">Product Discount (%)</label>
																	<input type="number" name="p_discount"
																		class="form-control"
																		placeholder="Enter Product Discount" required>
																</div>

																<script>
															    document.addEventListener("DOMContentLoaded", function () {
															        const forms = document.querySelectorAll("form");
															
															        forms.forEach((form) => {
															            const discountInput = form.querySelector("input[name='p_discount']");
															            if (discountInput) {
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
															                        event.stopPropagation();
															                    }
															                });
															            }
															        });
															    });
															</script>


																<div class="mb-3">
																	<label class="form-label">Product Status</label>
																	<div class="form-check">
																		<input class="form-check-input" type="radio"
																			name="isActive" value="active" checked> <label
																			class="form-check-label">Active</label>
																	</div>
																	<div class="form-check">
																		<input class="form-check-input" type="radio"
																			name="isActive" value="inactive"> <label
																			class="form-check-label">Inactive</label>
																	</div>
																</div>
																<div class="mb-3">
																	<label class="form-label">Product Stock</label> <input
																		type="number" name="p_stock" class="form-control"
																		placeholder="Enter Product Stock" required>
																</div>

																<div class="modal-footer">
																	<button type="button" class="btn btn-secondary"
																		data-bs-dismiss="modal">Close</button>
																	<button type="submit" name="update"
																		class="btn btn-primary">Update</button>
																</div>
															</form>
														</div>
													</div>
												</div>
											</div>


										</div>
									</td>


								</tr>
								<%
								}
								} catch (Exception e) {
								out.println("Error: " + e.getMessage());
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
