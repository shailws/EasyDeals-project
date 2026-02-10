<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Product</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<%@ include file="header.jsp"%>

	<section>
		<div class="container p-3 mt-5 pt-4 min-vh-100">

			<!-- ===== BACK TO ADMIN BUTTON ===== -->
			<div class="mb-3 text-start">
				<a href="admin.jsp" class="btn btn-outline-primary"> ← Back to
					Admin Dashboard </a>
			</div>

			<div class="card card shadow p-3 mb-5 bg-body-tertiary rounded">
				<div class="card-header text-center bg-primary text-white fs-5">
					View Product</div>
				<div class="card-body">

					<!-- ===== DELETE SUCCESS / ERROR MESSAGE ===== -->
					<%
					String PD_message = (String) session.getAttribute("pd_message");

					if (PD_message != null && !PD_message.isEmpty()) {
					%>
					<div
						class="alert text-center mt-3 <%=PD_message.equalsIgnoreCase("Product has been deleted successfully.") ? "alert-success" : "alert-danger"%>">
						<%=PD_message%>
					</div>
					<%
					session.removeAttribute("pd_message");
					}
					%>

					<!------------------------------------------------------------------------------------------------------------------  -->


					<!-- ===== DELETE SUCCESS / ERROR MESSAGE ===== -->
					<%
					String PU_message = (String) session.getAttribute("pU_message");

					if (PU_message != null && !PU_message.isEmpty()) {
					%>
					<div
						class="alert text-center mt-3 <%=PU_message.equalsIgnoreCase("Product has been updated successfully.") ? "alert-success" : "alert-danger"%>">
						<%=PU_message%>
					</div>
					<%
					session.removeAttribute("pU_message");
					}
					%>

					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<!-- table-striped -->
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
							<tbody class="table-light text-center">
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

											<form action="DeleteProduct" method="post">
												<input type="hidden" name="delete_id" value="<%=Sr_no%>">
												<button class="btn btn-sm btn-danger" type="submit"
													name="delete">
													<i class="fa-solid fa-trash"></i> Delete
												</button>
											</form>


											<button type="button" class="btn btn-primary btn-sm"
												data-bs-toggle="modal" data-bs-target="#editModal<%=Sr_no%>">
												<i class="fa-solid fa-pen-to-square fa-1x"></i> Edit
											</button>

											<!-- Bootstrap Modal (Unique ID per Row) -->
											<div class="modal fade" id="editModal<%=Sr_no%>"
												tabindex="-1" aria-labelledby="editModalLabel"
												aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">Edit Product</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															<form method="post" action="updateProduct"
																enctype="multipart/form-data">
																<!-- Hidden field to send the product ID -->
																<input type="hidden" name="update_id" value="<%=Sr_no%>">

																<!-- Upload Image -->
																<div class="mb-3">
																	<label class="form-label fw-bold">Product Image</label>
																	<input type="file" name="p_img" class="form-control"
																		required> <small class="text-muted">
																		Supported formats: JPG, PNG, JPEG </small>
																</div>

																<div class="mb-3">
																	<label class="form-label fw-bold">Product Title</label>
																	<input type="text" name="p_title" class="form-control"
																		placeholder="Enter Product Title" required>
																</div>

																<div class="mb-3">
																	<label class="form-label fw-bold">Product
																		p_description</label>

																	<textarea rows="3" name="p_description"
																		placeholder="Enter Product Description"
																		class="form-control" required></textarea>
																</div>

																<div class="mb-3">
																	<label class="form-label fw-bold">Category</label> <select
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
																	<label class="form-label fw-bold">Product Price</label>
																	<input type="number" name="p_price"
																		class="form-control" placeholder="Enter Product Price"
																		required>
																</div>
																<div class="mb-3">
																	<label class="form-label fw-bold">Product
																		Discount (%)</label> <input type="number" name="p_discount"
																		class="form-control"
																		placeholder="Enter Product Discount" required>
																</div>

																<!-- <script>
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
															</script> -->


																<!-- Status -->
																<div class="mb-3">
																	<label class="form-label fw-bold d-block">Product
																		Status</label>

																	<div class="form-check d-inline-block">
																		<input class="form-check-input" type="radio"
																			name="isActive" value="active" checked> <label
																			class="form-check-label">Active</label>
																	</div>

																	<div class="form-check d-inline-block">
																		<input class="form-check-input" type="radio"
																			name="isActive" value="inactive"> <label
																			class="form-check-label">Inactive</label>
																	</div>
																</div>
																<div class="mb-3">
																	<label class="form-label fw-bold">Product Stock</label>
																	<input type="number" name="p_stock"
																		class="form-control" placeholder="Enter Product Stock"
																		required>
																</div>

																<!-- Modal Footer -->
																<div class="modal-footer d-flex justify-content-center">
																	<button type="button" class="btn btn-outline-secondary"
																		data-bs-dismiss="modal">Cancel</button>
																	<button type="submit" name="update"
																		class="btn btn-primary">
																		<i class="fa-solid fa-floppy-disk me-1"></i> Update
																		Product
																	</button>
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
