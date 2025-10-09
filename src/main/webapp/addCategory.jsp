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
<body class="d-flex flex-column min-vh-100">

	<%@ include file="header.jsp"%>

	<section>
		<div class="container p-3 pt-5 mt-5">
			<div class="row">
				<!-- Category Form Section -->
				<div class="col-lg-4 col-md-6 mb-2 mb-md-0">
					<div class="card shadow rounded-4">


						<%
						String message = "";

						if (request.getParameter("save") != null) {
							String Name1 = request.getParameter("category_name");
							String Status = request.getParameter("isActive");
							String Img = request.getParameter("category_img");

							try {
								Class.forName("com.mysql.cj.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
								PreparedStatement ps = con
								.prepareStatement("INSERT INTO category (category_name, isActive, category_img) VALUES (?, ?, ?)");
								ps.setString(1, Name1);
								ps.setString(2, Status);
								ps.setString(3, Img);
								int count = ps.executeUpdate();

								if (count > 0) {
							message = "Category has been added successfully!";

								}

							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						%>

						<div class="card-header text-center bg-primary text-white fs-5">Add
							Category</div>


						<%
						if (!message.isEmpty()) {
						%>
						<div class="alert alert-success text-center mt-3"><%=message%></div>
						<%
						}
						%>

						<div class="card-body">
							<form action="addCategory.jsp" method="get">
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
									<label class="form-label">Upload Image URL</label> <input
										type="text" name="category_img" class="form-control">
								</div>

								<button type="submit" class="btn btn-primary w-100" name="save">Save</button>
							</form>
						</div>
					</div>
				</div>



				<!-- Category Details Table -->
				<div class="col-lg-8 col-md-6">
					<div class="card shadow-sm">

						<%
						// Handle Delete Request
						String message2 = "";

						if (request.getParameter("delete") != null) {
							try {
								int SR_no = Integer.parseInt(request.getParameter("delete_id"));
								Class.forName("com.mysql.cj.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
								PreparedStatement ps = con.prepareStatement("DELETE FROM category WHERE sr_no=?");
								ps.setInt(1, SR_no);
								int count = ps.executeUpdate();

								if (count > 0) {
							message2 = "Category has been deleted successfully";

								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						%>


						<div class="card-header text-center bg-primary text-white fs-5">Category
							Details</div>

						<%
						if (!message2.isEmpty()) {
						%>
						<div class="alert alert-success text-center mt-3"><%=message2%></div>
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



						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-striped table-hover">
									<thead class="table-light text-center">
										<tr>
											<th>Sl No</th>
											<th>Category</th>
											<th>Status</th>
											<th>Image</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
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
																		Category</h5>
																	<button type="button" class="btn-close"
																		data-bs-dismiss="modal" aria-label="Close"></button>
																</div>
																<div class="modal-body">
																	<form method="get" action="update_category.jsp">
																		<!-- Hidden field to send the product ID -->
																		<input type="hidden" name="update_id"
																			value="<%=Sr_no%>">

																		<div class="mb-3">
																			<label class="form-label">Category</label> <input
																				type="text" name="c_name" class="form-control"
																				placeholder="Enter category name" required>
																		</div>

																		<div class="mb-3">
																			<label class="form-label">Status</label>
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
																			<label class="form-label">Image url</label> <input
																				type="text" name="c_img" class="form-control"
																				placeholder="Enter category image url " required>
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
	</section>
	<%@ include file="footer.jsp"%>



	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
