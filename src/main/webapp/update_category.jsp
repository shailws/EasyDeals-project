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
			String C_name = request.getParameter("c_name");
			String IsActive = request.getParameter("isActive");
			String C_image = request.getParameter("c_img");
			int Id1 = Integer.parseInt(request.getParameter("update_id")); // Fixed name

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

			// Fixed SQL query (removed extra comma)
			PreparedStatement ps4 = con4
			.prepareStatement("UPDATE category SET category_name=?, isActive=?, category_img=? WHERE sr_no=?");

			ps4.setString(1, C_name);
			ps4.setString(2, IsActive);
			ps4.setString(3, C_image);
			ps4.setInt(4, Id1);

			int rowsUpdated = ps4.executeUpdate();

			response.sendRedirect(
			"addCategory.jsp?updateMessage=Category+has+been+updated+successfully");

		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
	}
	%>
</body>
</html>