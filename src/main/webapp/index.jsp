<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Responsive Page</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"  />
	
	<style>
		.category-card img, .product-card img {
			max-width: 100%;
			height: auto;
		}
		.carousel-caption {
			text-shadow: 1px 1px 4px #000;
		}

		.card-title {
			font-size: 1rem;
		}

		@media (max-width: 768px) {
			.carousel-caption h2 {
				font-size: 1.5rem;
			}
			.carousel-caption p {
				font-size: 1rem;
			}
			/* .btn-lg {
				font-size: 1rem;
				padding: 0.5rem 1rem;
			} */
		}
	</style>
	
	
</head>
<body>
	<%@ include file="header.jsp"%>

	<section class="mt-5">
		<!-- Start Slider -->
		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000" data-bs-pause="false">
			<div class="carousel-inner">
				<!-- Slide 1 -->
				<div class="carousel-item active">
					<div class="position-relative" style="height: 100vh;">
						<img src="./images/shoping3.png" class="img-fluid w-100 h-100" style="object-fit: cover;" alt="Slide 1">
						<div class="carousel-caption d-flex flex-column justify-content-center align-items-center text-white bg-dark bg-opacity-50 w-100 h-100 position-absolute top-0 start-0 text-center px-3">
							<h2 class="mb-3 fw-bold display-6">Experience the Best of Online Shopping</h2>
							<p class="mb-4 fs-5">Find top deals on electronics, fashion, and groceries—all in one place!</p>
							<a href="product.jsp" class="btn btn-warning btn-lg  fw-semibold shadow-sm">Shop Now</a>
						</div>
					</div>
				</div>

				<!-- Slide 2 -->
				<div class="carousel-item">
					<div class="position-relative" style="height: 100vh;">
						<img src="./images/shoping1.webp" class="img-fluid w-100 h-100" style="object-fit: cover;" alt="Slide 2">
						<div class="carousel-caption d-flex flex-column justify-content-center align-items-center text-white bg-dark bg-opacity-50 w-100 h-100 position-absolute top-0 start-0 text-center px-3">
							<h2 class="mb-3 fw-bold display-6">Enjoy Seamless Online Shopping</h2>
							<p class="mb-4 fs-5">From trendy fashion to cutting-edge gadgets, shop your favorite items anytime.</p>
							<a href="product.jsp" class="btn btn-warning btn-lg fw-semibold shadow-sm">Shop Now</a>
						</div>
					</div>
				</div>

				<!-- Slide 3 -->
				<div class="carousel-item">
					<div class="position-relative" style="height: 100vh;">
						<img src="./images/shoping2.jpg" class="img-fluid w-100 h-100" style="object-fit: cover;" alt="Slide 3">
						<div class="carousel-caption d-flex flex-column justify-content-center align-items-center text-white bg-dark bg-opacity-50 w-100 h-100 position-absolute top-0 start-0 text-center px-3">
							<h2 class="mb-3 fw-bold display-6">Great Products, Unmatched Convenience</h2>
							<p class="mb-4 fs-5">Shop smarter with our latest collections and quick delivery options.</p>
							<a href="product.jsp" class="btn btn-warning btn-lg fw-semibold shadow-sm">Shop Now</a>
						</div>
					</div>
				</div>
			</div>

			<!-- Controls -->
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span>
			</button>
		</div>
		<!-- End Slider -->

		<!-- Start Category Module -->
		<div class="container mt-5">
			<h2 class="text-center">Categories</h2>
			<div class="row mt-4">
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
					PreparedStatement ps = con.prepareStatement("SELECT category_name, isActive, category_img FROM category WHERE isActive = 'active'");
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						
						String Category_name = rs.getString("category_name");
						String IsActive = rs.getString("isActive");
						String Cimage = rs.getString("category_img");
				%>
				<div class="col-12 col-md-6 col-lg-4 mb-4">
					<div class="card h-100 text-center shadow-sm rounded-4 d-flex flex-column position-relative">
						<span class="position-absolute top-0 end-0 m-2 badge <%=IsActive.equalsIgnoreCase("active") ? "bg-success" : "bg-danger"%>"><%=IsActive%></span>
						<div class="p-3" style="height: 200px;">
							<img src="<%=Cimage%>" alt="Category Image" class="img-fluid h-100" style="object-fit: contain;">
						</div>
						<div class="card-body text-center d-flex flex-column align-items-center">
							<a href="product.jsp?category=<%=Category_name%>" class="btn btn-outline-warning w-100 fw-semibold shadow-sm mb-3">
								<%=Category_name%>
							</a>
						</div>
					</div>
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
		<!-- End Category Module -->

		<!-- Start Latest Product Module -->
		<div class="container   mt-4">
			<h2 class="text-center mb-4">Latest Products</h2>
			<div class="row">
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
					PreparedStatement ps = con.prepareStatement("SELECT * FROM product ORDER BY sr_no DESC LIMIT 8");
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						String Sr_no = rs.getString("sr_no");
						String P_title = rs.getString("p_title");
						double P_price = rs.getDouble("p_price");
						String P_image = rs.getString("P_image");
						int P_discount = rs.getInt("p_discount");
						double discountedPrice = P_price - (P_price * P_discount / 100);
				%>
				<div class="col-12 col-md-6 col-lg-4 mb-4">
					<div class="card h-100 text-center shadow-sm rounded-4 d-flex flex-column">
						<div class="product-img-wrapper p-3" style="height: 200px;">
							<img src="<%=P_image%>" alt="Product Image" class="img-fluid h-100" style="object-fit: contain;">
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title text-truncate mb-2"><%=P_title%></h5>
							<p class="card-text mb-3">
								<strong>₹<%=String.format("%.2f", discountedPrice)%></strong><br>
								<small class="text-muted"><del>₹<%=P_price%></del></small>
								<span class="text-success ms-1"><%=P_discount%>% off</span>
							</p>
							<div class="mt-auto">
								<a href="pdetails.jsp?sr_no=<%=Sr_no%>" class="btn btn-primary w-100">View Details</a>
							</div>
						</div>
					</div>
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
		<!-- End Latest Product Module -->
	</section>

	 <%@ include file="footer.jsp"%>
	 
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>