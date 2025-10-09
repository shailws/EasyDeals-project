<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Card Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="header.jsp"%>

    <div class="d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow p-4" style="width: 100%; max-width: 500px;">
            <div class="card-body">
                <h3 class="text-center mb-4">Card Payment</h3>
                <form action="payment_successful.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Card Number</label>
                       <input type="text" inputmode="numeric" autocomplete="cc-number" class="form-control" placeholder="1234 5678 9012 3456" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Expiry Date</label>
                        <input type="text" autocomplete="cc-exp" class="form-control" placeholder="MM/YY" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">CVV</label>
                       <input type="password" autocomplete="cc-csc" class="form-control" placeholder="123" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Pay Now</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>
