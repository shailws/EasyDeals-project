<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>UPI Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="header.jsp"%>

    <div class="d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow p-4" style="width: 100%; max-width: 500px;">
            <div class="card-body">
                <h3 class="text-center mb-4">UPI Payment</h3>
                <form action="payment_successful.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Enter UPI ID</label>
                        <input type="text" class="form-control" placeholder="example@upi" autocomplete="off" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Pay Now</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>
