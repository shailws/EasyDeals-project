<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Order Confirmation</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">
	<%@ include file="header.jsp"%>
	<section class="d-flex justify-content-center align-items-center min-vh-100">
		<div class="container mt-5 d-flex justify-content-center">
			<div class="card shadow-lg p-4"
				style="max-width: 500px; width: 100%;">
				<div class="card-body text-center">
					<h3 class="card-title text-success">Order Confirmed!</h3>
					<p class="card-text">Your order has been booked successfully.
						You will receive your delivery within 7 days.</p>
					<a href="product.jsp" class="btn btn-primary mt-3">Buy More</a>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
