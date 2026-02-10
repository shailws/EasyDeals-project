<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Categories</title>
<link rel="stylesheet" href="style2.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

	<%@ include file="header.jsp"%>


	<div class="container p-3 mt-5 pt-4 min-vh-100">

		<!-- ===== BACK TO ADMIN BUTTON ===== -->
		<div class="mb-3 text-start">
			<a href="admin.jsp" class="btn btn-outline-primary"> ← Back to
				Admin Dashboard </a>
		</div>

		<div class="row d-flex justify-content-center">
			<!-- Category Form Section -->
			<div class="col-md-6 col-lg-4  mb-3 mb-md-0">
				<div class="card shadow p-3 bg-body-tertiary rounded">

					<div class="card-header text-center bg-primary text-white fs-5">Add
						Category</div>

					<div class="card-body">
						<form action="addCategory" method="post"
							enctype="multipart/form-data">
							<div class="mb-3">
								<label class="form-label">Enter Category</label> <input
									type="text" class="form-control" name="category_name" required>
							</div>

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

							<div class="mb-3">
								<label class="form-label">Upload Image</label> <input
									type="file" name="category_img" class="form-control" required>
							</div>

							<button type="submit" class="btn btn-primary w-100" name="save">Save</button>
						</form>

					</div>
				</div>
			</div>


			<!-- Category Details Table -->
			<div class="col-md-6 col-lg-8">
				<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">

					<div class="card-header text-center bg-primary text-white fs-5">Category
						Details</div>

					<!-- ===== DELETE SUCCESS / ERROR MESSAGE ===== -->
					<%
					String CD_message = (String) session.getAttribute("cd_message");

					if (CD_message != null && !CD_message.isEmpty()) {
					%>
					<div
						class="alert text-center mt-3 <%=CD_message.equalsIgnoreCase("Category has been deleted successfully.") ? "alert-success" : "alert-danger"%>">
						<%=CD_message%>
					</div>
					<%
					session.removeAttribute("cd_message");
					}
					%>

					<!------------------------------------------------------------------------------------------------------------------  -->

					<!-- ===== UPDATE SUCCESS / ERROR MESSAGE ===== -->
					<%
					String CU_message = (String) session.getAttribute("cU_message");

					if (CU_message != null && !CU_message.isEmpty()) {
					%>
					<div
						class="alert text-center mt-3 <%=CU_message.equalsIgnoreCase("Category has been updated successfully.") ? "alert-success" : "alert-danger"%>">
						<%=CU_message%>
					</div>
					<%
					session.removeAttribute("cU_message");
					}
					%>


					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead class="table-light text-center">
									<tr>
										<th>Sl No</th>
										<th>Category</th>
										<th>Status</th>
										<th>Image</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody class="table-light text-center">
									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
										PreparedStatement ps = con.prepareStatement("SELECT * FROM category");
										ResultSet rs = ps.executeQuery();

										while (rs.next()) {
											String Sr_no = rs.getString("sr_no");
											String Category_name = rs.getString("category_name");
											String IsActive = rs.getString("isActive");
											String Category_img = rs.getString("category_img");
									%>
									<tr>
										<td><%=Sr_no%></td>
										<td><%=Category_name%></td>
										<td><span
											class="badge rounded-pill <%=IsActive.equalsIgnoreCase("active") ? "text-bg-success" : "text-bg-danger"%> "><%=IsActive%></span></td>
										<td><img src="<%=Category_img%>" alt="Category Image"
											width="50"></td>
										<td>
											<div
												class="d-flex justify-content-center align-items-center gap-2">

												<form action="DeleteCategory" method="post">
													<input type="hidden" name="delete_id" value="<%=Sr_no%>">
													<button class="btn btn-sm btn-danger" type="submit"
														name="delete">
														<i class="fa-solid fa-trash"></i> Delete
													</button>
												</form>

												<button type="button" class="btn btn-primary btn-sm"
													data-bs-toggle="modal"
													data-bs-target="#editModal<%=Sr_no%>">
													<i class="fa-solid fa-pen-to-square fa-1x"></i> Edit
												</button>


												<!-- Bootstrap Modal (Unique ID per Row) -->
												<div class="modal fade" id="editModal<%=Sr_no%>"
													tabindex="-1" aria-labelledby="editModalLabel"
													aria-hidden="true">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="editModalLabel">Edit
																	Category</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">

																<form action="updateCategory" method="post"
																	enctype="multipart/form-data">

																	<!-- Hidden field -->
																	<input type="hidden" name="update_id"
																		value="<%=Sr_no%>">

																	<!-- Category Name -->
																	<div class="mb-3">
																		<label class="form-label fw-bold">Category
																			Name</label> <input type="text" class="form-control"
																			name="category_name"
																			placeholder="Enter category name" required>
																	</div>

																	<!-- Status -->
																	<div class="mb-3">
																		<label class="form-label fw-bold d-block">Status</label>

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

																	<!-- Upload Image -->
																	<div class="mb-3">
																		<label class="form-label fw-bold">Category
																			Image</label> <input type="file" name="category_img"
																			class="form-control" accept="image/*" required>
																		<small class="text-muted"> Supported formats:
																			JPG, PNG, JPEG </small>
																	</div>

																	<!-- Modal Footer -->
																	<div class="modal-footer d-flex justify-content-center">
																		<button type="button"
																			class="btn btn-outline-secondary"
																			data-bs-dismiss="modal">Cancel</button>
																		<button type="submit" name="update"
																			class="btn btn-primary">
																			<i class="fa-solid fa-floppy-disk me-1"></i> Update
																			Category
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
									e.printStackTrace();
									}
									%>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>



	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
