<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%
    String sr_no = request.getParameter("sr_no");
    String action = request.getParameter("action");

    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart != null) {
        Iterator<Map<String, Object>> iterator = cart.iterator();
        while (iterator.hasNext()) {
            Map<String, Object> item = iterator.next();
            if (item.get("sr_no").equals(sr_no)) {
                int quantity = (int) item.get("quantity");
                if ("increase".equals(action)) {
                    item.put("quantity", quantity + 1);
                } else if ("decrease".equals(action)) {
                    if (quantity > 1) {
                        item.put("quantity", quantity - 1);
                    } else {
                        // If quantity is 1 and user clicks '-', remove the item
                        iterator.remove();
                    }
                }
                break;
            }
        }
        session.setAttribute("cart", cart);
    }
    response.sendRedirect("cart.jsp");
%>
