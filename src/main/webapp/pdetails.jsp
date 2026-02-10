<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Product Details</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

	<%@ include file="header.jsp"%>

	<div
		class="container mt-5 p-5 shadow bg-body-tertiary rounde min-vh-100">

		<%
		String sr_no = request.getParameter("sr_no");

		if (sr_no != null && !sr_no.isEmpty()) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

				PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE sr_no = ?");
				ps.setString(1, sr_no);

				ResultSet rs = ps.executeQuery();

				if (rs.next()) {

			String P_title = rs.getString("p_title");
			String P_description = rs.getString("p_description");
			String P_category = rs.getString("p_category");
			double P_price = rs.getDouble("p_price");
			String IsActive = rs.getString("isActive");
			String P_image = rs.getString("P_image");
			int P_discount = rs.getInt("p_discount");

			double discountedPrice = P_price - (P_price * P_discount / 100);
		%>

		<div class="row align-items-center">
			<div class="col-md-6 col-12 text-center mb-4 mb-md-0">
				<img src="<%=P_image%>" alt="Product Image"
					class="img-fluid rounded" style="object-fit: contain;">
			</div>

			<div class="col-md-6 col-12">
				<p class="fs-3"><%=P_title%></p>

				<p>
					<span class="fw-bold">Description:</span>
					<%=P_description%>
				</p>

				<p>
					<span class="fw-bold">Product Details:</span><br> Status: <span
						class="badge <%=IsActive.equalsIgnoreCase("active") ? "bg-success" : "bg-danger"%>">
						<%=IsActive%>
					</span> <br> Category:
					<%=P_category%><br> Policy: 7 Days Replacement & Return
				</p>

				<p class="fs-5 fw-bold">
					Price: <i class="fa-solid fa-rupee-sign"></i>
					<%=discountedPrice%>
					<span class="fs-6 text-decoration-line-through text-secondary">
						<%=P_price%>
					</span> <span class="fs-6 text-success"> <%=P_discount%>% Off
					</span>
				</p>

				<div class="row text-center">
					<div class="col-4 text-success p-2">
						<i class="fa-solid fa-money-bill-wave"></i>
						<p>Cash On Delivery</p>
					</div>
					<div class="col-4 text-danger p-2">
						<i class="fa-solid fa-rotate-left"></i>
						<p>Return Available</p>
					</div>
					<div class="col-4 text-primary p-2">
						<i class="fa-solid fa-truck-moving"></i>
						<p>Free Shipping</p>
					</div>
				</div>

				<%
				String user = (String) session.getAttribute("name");

				if (user == null) {
				%>
				<div class="alert alert-danger">Login to add to cart</div>
				<%
				} else if (!IsActive.equalsIgnoreCase("active")) {
				%>
				<div class="alert alert-warning">This product is inactive and
					cannot be added to the cart.</div>
				<%
				} else {
				%>
				<form action="AddToCart.jsp" method="post">
					<input type="hidden" name="sr_no" value="<%=rs.getInt("sr_no")%>">
					<input type="hidden" name="quantity" value="1">
					<button type="submit" class="btn btn-primary w-100">Add to
						Cart</button>
				</form>
				<%
				}
				%>

			</div>
		</div>

		<%
		} else {
		out.println("<h3 class='text-center'>Product not found!</h3>");
		}

		} catch (Exception e) {
		e.printStackTrace();
		}
		} else {
		out.println("<h3 class='text-center'>Product not found!</h3>");
		}
		%>

	</div>

	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
