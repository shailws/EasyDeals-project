<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    double grandTotal = 0;
    for (Map<String, Object> item : cart) {
        double price = (double) item.get("p_price");
        int qty = (int) item.get("quantity");
        grandTotal += price * qty;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String state = request.getParameter("state");
        String paymentType = request.getParameter("paymentType");

        StringBuilder productSummary = new StringBuilder();
        for (Map<String, Object> item : cart) {
            productSummary.append(item.get("p_title")).append(" x ").append(item.get("quantity"))
                .append(" (₹").append(item.get("p_price")).append(" each), ");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO order_place (first_name, last_name, email, phone, address, city, pincode, state, payment_type, product_data, total_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, city);
            ps.setString(7, pincode);
            ps.setString(8, state);
            ps.setString(9, paymentType);
            ps.setString(10, productSummary.toString());
            ps.setDouble(11, grandTotal);

            ps.executeUpdate();

            session.removeAttribute("cart");

            if ("Cash on Delivery".equalsIgnoreCase(paymentType)) {
                response.sendRedirect("cashOnDelivery.jsp");
            } else if ("Card Payment".equalsIgnoreCase(paymentType)) {
                response.sendRedirect("cardPayment.jsp");
            } else if ("UPI".equalsIgnoreCase(paymentType)) {
                response.sendRedirect("upiPayment.jsp");
            }
            return;
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="header.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-md-6">
            <h4 class="mb-3">Shipping Information</h4>
            <form method="post">
                <div class="mb-2">
                    <input type="text" name="firstName" class="form-control" placeholder="First Name" required>
                </div>
                <div class="mb-2">
                    <input type="text" name="lastName" class="form-control" placeholder="Last Name" required>
                </div>
                <div class="mb-2">
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>
                <div class="mb-2">
                    <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>
                </div>
                <div class="mb-2">
                    <textarea name="address" class="form-control" placeholder="Full Address" required></textarea>
                </div>
                <div class="mb-2">
                    <input type="text" name="city" class="form-control" placeholder="City" required>
                </div>
                <div class="mb-2">
                    <input type="text" name="pincode" class="form-control" placeholder="Pincode" required>
                </div>
                <div class="mb-2">
                    <input type="text" name="state" class="form-control" placeholder="State" required>
                </div>
                <div class="mb-2">
                    <select name="paymentType" class="form-select" required>
                        <option value="">Select Payment Method</option>
                        <option value="Cash on Delivery">Cash on Delivery</option>
                        <option value="Card Payment">Card Payment</option>
                        <option value="UPI">UPI</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Place Order</button>
            </form>
        </div>

        <div class="col-md-6">
            <h4 class="mb-3">Order Summary</h4>
            <ul class="list-group mb-3">
                <% for (Map<String, Object> item : cart) {
                    String title = (String) item.get("p_title");
                    String image = (String) item.get("p_image");
                    double price = (double) item.get("p_price");
                    int qty = (int) item.get("quantity");
                    double subtotal = price * qty;
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <img src="<%=image%>" width="50" height="50" class="rounded">
                    <div><strong><%=title%></strong><br>Qty: <%=qty%></div>
                    <span>₹<%=subtotal%></span>
                </li>
                <% } %>
                <li class="list-group-item d-flex justify-content-between">
                    <strong>Grand Total</strong>
                    <strong>₹<%=grandTotal%></strong>
                </li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
