<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

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
		<div class="container mt-5 py-5">
			<p class="text-center fs-3 mt-4">Admin Dashboard</p>

			<div class="row g-4">
				<!-- "g-4" adds gap between columns -->

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="addProduct.jsp" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-primary">
								<i class="fa-solid fa-square-plus fa-3x"></i>
								<h5 class="mt-2">Add Product</h5>
							</div>
						</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="addCategory.jsp" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-warning">
								<i class="fa-solid fa-list fa-3x"></i>
								<h5 class="mt-2">Manage Category</h5>
							</div>
						</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="viewProduct.jsp" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-success">
								<i class="fa-solid fa-table-list fa-3x"></i>
								<h5 class="mt-2">View Products</h5>
							</div>
						</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="#" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-warning">
								<i class="fa-solid fa-box-open fa-3x"></i>
								<h5 class="mt-2">Orders</h5>
							</div>
						</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="users.jsp" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-primary">
								<i class="fa-solid fa-user-large fa-3x"></i>
								<h5 class="mt-2">Users</h5>
							</div>
						</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12">
					<a href="#" class="text-decoration-none">
						<div class="card card-sh">
							<div class="card-body text-center text-primary">
								<i class="fa-solid fa-user-plus fa-3x"></i>
								<h5 class="mt-2">Add Admin</h5>
							</div>
						</div>
					</a>
				</div>

			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
