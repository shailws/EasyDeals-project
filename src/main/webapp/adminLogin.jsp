<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

  <%@ include file="header.jsp" %>

  <%-- JSP Login Logic --%>
  <%
    String invalidMsg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String Email = request.getParameter("email");
        String Password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE email=? AND password=?");
            ps.setString(1, Email);
            ps.setString(2, Password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("admin", Email);
                response.sendRedirect("admin.jsp");
                return;
            } else {
                invalidMsg = "Invalid email or password!";
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            invalidMsg = "Login failed. Please try again.";
            e.printStackTrace();
        }
    }
  %>

  <section>
    <div class="container mt-5">
      <div class="row justify-content-center align-items-center pt-5">
        
        <!-- Image Section -->
        <div class="col-lg-6 col-md-6 text-center mb-4">
          <img src="./images/ecom.png" alt="E-commerce" class="img-fluid" style="max-height: 400px;">
        </div>

        <!-- Login Form Section -->
        <div class="col-lg-6 col-md-6 d-flex justify-content-center">
          <div class="card shadow p-4 w-100" style="max-width: 400px;">
            <div class="card-header text-center">
              <h4>Admin Login</h4>
            </div>

            <% if (!invalidMsg.isEmpty()) { %>
              <div class="alert alert-danger text-center mt-3">
                <%= invalidMsg %>
              </div>
            <% } %>

            <div class="card-body">
              <form action="adminLogin.jsp" method="post">
                <div class="mb-3">
                  <label class="form-label">Email</label>
                  <input type="email" class="form-control" name="email" required>
                </div>

                <div class="mb-3">
                  <label class="form-label">Password</label>
                  <input type="password" class="form-control" name="password" required>
                </div>

                <button name="login" type="submit" class="btn btn-primary w-100">Login</button>
              </form>
            </div>
            <div class="card-footer text-center">
              <a href="#" class="text-decoration-none">Forgot Password?</a>
            </div>
          </div>
        </div>

      </div>
    </div>
  </section>

  	 <%@ include file="footer.jsp"%>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
