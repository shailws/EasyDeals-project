<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="header.jsp"%>
    <div class="d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow p-4" style="max-width: 500px; width: 100%;">
            <div class="card-body text-center">
                <h3 class="text-success">Payment Successful!</h3>
                <p>Your payment has been done successfully!</p>
                <p>You will receive your delivery within 7 days.</p>
                <a href="product.jsp" class="btn btn-primary mt-3">Shop More</a>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</body>
</html>
