<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*"%>
<%
List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
if (cart == null) {
	cart = new ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Your Cart</title>

<!-- Bootstrap 5.3 CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- FontAwesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
/* Image sizing */
.cart-table img {
	width: 60px;
	height: 60px;
	object-fit: cover;
}

@media ( min-width : 768px) {
	.cart-table img {
		width: 80px;
		height: 80px;
	}
}
</style>
</head>
<body class="bg-light">
	<%@ include file="header.jsp"%>

	<div class="container p-3 pt-5 mt-5">
		<div class="card shadow rounded-4">
			<div class="card-header text-center bg-primary text-white fs-5">
				<i class="fa-solid fa-cart-shopping me-2"></i>Your Cart
			</div>

			<div class="card-body">
				<%
				if (cart.size() == 0) {
				%>
				<div class="alert alert-info text-center" role="alert">Your
					cart is empty.</div>
				<%
				} else {
				%>
				<div class="table-responsive">
					<table
						class="table table-bordered table-striped table-hover cart-table">
						<thead class="table-light text-center">
							<tr>
								<th scope="col">Product Image</th>
								<th scope="col">Product Title</th>
								<th scope="col">Price</th>
								<th scope="col">Quantity</th>
								<th scope="col">Total</th>
							</tr>
						</thead>
						<tbody>
							<%
							double total = 0;
							int totalQunatity = 0;
							String sr_no;
							String p_title;
							String p_image;
							int quantity;
							double p_price;
							double subtotal;
							
							for (Map<String, Object> item : cart) {
								 sr_no = (String) item.get("sr_no");
								 p_title = (String) item.get("p_title");
								 p_image = (String) item.get("p_image");
								 p_price = (double) item.get("p_price");
								 quantity = (int) item.get("quantity");

								subtotal = p_price * quantity;
								total += subtotal;
								totalQunatity += quantity;
							%>
							<tr>
								<td><img src="<%=p_image%>" class="img-fluid rounded"></td>
								<td class="text-break"><%=p_title%></td>
								<td class="text-nowrap">₹<%=p_price%></td>
								<td>
									<div
										class="d-flex flex-column flex-md-row justify-content-center align-items-center gap-2">
										<form action="updateCart.jsp" method="post" class="d-inline">
											<input type="hidden" name="sr_no" value="<%=sr_no%>">
											<input type="hidden" name="action" value="decrease">
											<button type="submit"
												class="btn btn-danger btn-sm rounded-circle">
												<i class="fa fa-minus"></i>
											</button>
										</form>

										<span class="fw-bold fs-6"><%=quantity%></span>

										<form action="updateCart.jsp" method="post" class="d-inline">
											<input type="hidden" name="sr_no" value="<%=sr_no%>">
											<input type="hidden" name="action" value="increase">
											<button type="submit"
												class="btn btn-success btn-sm rounded-circle">
												<i class="fa fa-plus"></i>
											</button>
										</form>
									</div>
								</td>
								<td class="text-nowrap fw-semibold">₹<%=subtotal%></td>
							</tr>
							<%
							}
							 session.setAttribute("totalQuantity", totalQunatity); 
							%>
							<tr class="table-info">
								<td colspan="4" class="text-end fs-5 fw-bold">Grand Total:</td>
								<td class="text-center fs-5 fw-bold text-nowrap text-success">₹
									<%=total%></td>
							</tr>
						</tbody>
					</table>
				</div>

				<!-- Checkout Button -->
				<div class="text-center mt-3">
					<a href="checkout.jsp"
						class="btn btn-md btn-success px-5 rounded-pill"> Proceed to
						Checkout <i class="fa fa-arrow-right ms-2"></i>
					</a>
				</div>

				<%
				
				}
				%>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>

	<!-- Bootstrap Bundle JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
