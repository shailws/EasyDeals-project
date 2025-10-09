<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if (request.getParameter("update") != null) {
		try {
			String P_image = request.getParameter("p_image");
			String P_title = request.getParameter("p_title");
			String P_description = request.getParameter("p_description");
			String P_category = request.getParameter("p_category");
			double P_price = Double.parseDouble(request.getParameter("p_price"));
			int P_discount = Integer.parseInt(request.getParameter("p_discount"));
			String IsActive = request.getParameter("isActive");
			String P_stock = request.getParameter("p_stock");

			int Id1 = Integer.parseInt(request.getParameter("update_id")); // Fixed name

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

			// Fixed SQL query (removed extra comma)
			PreparedStatement ps4 = con4.prepareStatement(
			"UPDATE product SET p_title=?, p_category=?, p_price=?, isActive=?, p_stock=?, P_image=?, p_discount=?, p_description=? WHERE sr_no=?");

			ps4.setString(1, P_title);
			ps4.setString(2, P_category);
			ps4.setDouble(3, P_price);
			ps4.setString(4, IsActive);
			ps4.setString(5, P_stock);
			ps4.setString(6, P_image);
			ps4.setInt(7, P_discount);
			ps4.setString(8, P_description);
			ps4.setInt(9, Id1);

			int rowsUpdated = ps4.executeUpdate();

			response.sendRedirect(
			"viewProduct.jsp?updateMessage=Product+has+been+updated+successfully&alertClass3=text-success");
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace(); // Prints error details in the server logs
		}
	}
	%>
</body>
</html>