<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
	<div class="container">

		<!-- Logo -->
		<a class="navbar-brand" href="index.jsp"> <i
			class="fa-solid fa-cart-shopping"></i> EasyDeals
		</a>

		<!-- Toggler -->
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<!-- Menu -->
		<div class="collapse navbar-collapse" id="navbarNav">

			<!-- Left -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">

				<li class="nav-item"><a class="nav-link active"
					href="index.jsp"><i class="fa-solid fa-house"></i> Home</a></li>

				<li class="nav-item"><a class="nav-link active"
					href="product.jsp">Product</a></li>

				<!-- Category Dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle active" href="#" role="button"
					data-bs-toggle="dropdown"> Category </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
						<li><a class="dropdown-item" href="#">Something else here</a></li>
					</ul></li>

			</ul>

			<!-- Right -->
			<ul class="navbar-nav ms-auto">

				<%
				String Name = (String) session.getAttribute("user_name");
				int totalQuantity = 0;

				String admin_Name = (String) session.getAttribute("admin_Name");
				%>

				<%
				if (Name != null) {
				%>

				<li class="nav-item"><a class="nav-link active" href="cart.jsp">
						<i class="fa-solid fa-cart-shopping"></i> [ <%=totalQuantity%> ]
				</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle active" href="#" role="button"
					data-bs-toggle="dropdown"> <i class="fa-solid fa-user"></i> <%=Name%>
				</a>
					<ul class="dropdown-menu dropdown-menu-end">
						<li><a class="dropdown-item" href="#">Profile</a></li>
					</ul></li>

				<li class="nav-item"><a class="nav-link active"
					href="logout.jsp"> <i class="fa-solid fa-right-from-bracket"></i>
						Logout
				</a></li>

				<%
				} else if (admin_Name != null) {
				%>

				<li class="nav-item"><a class="nav-link active" href="#"><i
						class="fa-solid fa-user"></i> <%=admin_Name%></a></li>
				<li class="nav-item"><a class="nav-link active"
					href="admin_logout.jsp"> <i
						class="fa-solid fa-right-from-bracket"></i> Logout
				</a></li>

				<%
				} else {
				%>

				<li class="nav-item"><a class="nav-link active"
					href="login.jsp"> <i class="fa-solid fa-right-to-bracket"></i>
						Login
				</a></li>

				<li class="nav-item"><a class="nav-link active"
					href="register.jsp">Register</a></li>

				<li class="nav-item"><a class="nav-link active"
					href="adminLogin.jsp">Admin</a></li>

				<%
				}
				%>

			</ul>

		</div>
	</div>
</nav>
