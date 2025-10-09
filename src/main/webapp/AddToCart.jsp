<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	String sr_no = request.getParameter("sr_no");
	int quantity = Integer.parseInt(request.getParameter("quantity"));

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");
	PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE sr_no = ?");
	ps.setString(1, sr_no);
	ResultSet rs = ps.executeQuery();

	if (rs.next()) {
		String p_title = rs.getString("p_title");
		String p_image = rs.getString("p_image");
		double p_price = rs.getDouble("p_price");
		int p_discount = rs.getInt("p_discount");
		double discountedPrice = p_price - (p_price * p_discount / 100);

		List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
		if (cart == null)
			cart = new ArrayList<>();

		boolean exists = false;
		for (Map<String, Object> item : cart) {
			if (item.get("sr_no").equals(sr_no)) {
		item.put("quantity", (int) item.get("quantity") + quantity);
		exists = true;
		break;
			}
		}
		if (!exists) {
			Map<String, Object> item = new HashMap<>();
			item.put("sr_no", sr_no);
			item.put("p_title", p_title);
			item.put("p_image", p_image);
			item.put("p_price", discountedPrice);
			item.put("quantity", quantity);
			cart.add(item);
		}
		session.setAttribute("cart", cart);
		
	}
	con.close();
	response.sendRedirect("cart.jsp");
	%>


</body>
</html>