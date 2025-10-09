<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>EasyDeals - Responsive</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet" />
</head>
<body>

  <!-- Navbar Start -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">
        <i class="fa-solid fa-cart-shopping"></i> EasyDeals
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
     <!--  Left sizd -->
        <ul class="navbar-nav me-auto mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" href="index.jsp">
              <i class="fa-solid fa-house"></i> Home
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="product.jsp">Product</a>
          </li>

          <!-- Category Dropdown -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle active" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Category
            </a>
            <ul class="dropdown-menu" aria-labelledby="categoryDropdown">
              <li>
                <a href="product.jsp" class="dropdown-item">All</a>
              </li>
              <%
                try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
                  PreparedStatement ps = con.prepareStatement("SELECT category_name FROM category WHERE isActive = 'active'");
                  ResultSet rs = ps.executeQuery();
                  while (rs.next()) {
                    String categoryName = rs.getString("category_name");
              %>
              <li>
                <a class="dropdown-item" href="product.jsp?category=<%=URLEncoder.encode(categoryName, "UTF-8")%>">
                  <%= categoryName %>
                </a>
              </li>
              <%
                  }
                  rs.close();
                  ps.close();
                  con.close();
                } catch (Exception e) {
                  out.println("<li class='dropdown-item text-danger'>Category Load Error</li>");
                }
              %>
            </ul>
          </li>
        </ul>

        <!-- Right Side -->
        <ul class="navbar-nav ms-auto mb-lg-0">
          <%
            String Name = (String) session.getAttribute("name");
            int totalQuantity2 = 0;
            Object qtyObj = session.getAttribute("totalQuantity");
            if (qtyObj != null) {
              try {
                totalQuantity2 = Integer.parseInt(qtyObj.toString());
              } catch (Exception e) {
                e.printStackTrace();
              }
            }

            if (Name != null) {
          %>
          <li class="nav-item">
            <a class="nav-link active" href="cart.jsp">
              <i class="fa-solid fa-cart-shopping"></i> [ <%= totalQuantity2 %> ]
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle active" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
              <i class="fa-solid fa-user"></i> <%= Name %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
              <li><a class="dropdown-item" href="#">Profile</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="logout.jsp">
              <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a>
          </li>
          <%
            } else {
          %>
          <li class="nav-item">
            <a class="nav-link active" href="login.jsp">
              <i class="fa-solid fa-right-to-bracket"></i> Login
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="register.jsp">Register</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="adminLogin.jsp">Admin</a>
          </li>
          <%
            }
          %>
        </ul>
      </div>
    </div>
  </nav>
  <!-- Navbar End -->

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
