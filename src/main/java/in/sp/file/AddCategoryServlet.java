package in.sp.file;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@MultipartConfig
@WebServlet("/addCategory")
public class AddCategoryServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("category_name");
		String status = request.getParameter("isActive");

		// Get file
		Part part = request.getPart("category_img");
		String fileName = part.getSubmittedFileName();

		// Create upload folder path
		String uploadPath = getServletContext().getRealPath("") + "category_images";
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists())
			uploadDir.mkdir();

		// Save image
		part.write(uploadPath + File.separator + fileName);
		
		// Store image path in DB
		String imagePath = "category_images/" + fileName;
		
		/* System.out.println("uploaded path = "+ uploadPath); */

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

			PreparedStatement ps = con
					.prepareStatement("INSERT INTO category (category_name, isActive, category_img) VALUES (?, ?, ?)");

			ps.setString(1, name);
			ps.setString(2, status);
			ps.setString(3, imagePath);

			int count = ps.executeUpdate();

			if (count > 0) {
				response.sendRedirect("addCategory.jsp?success=1");
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
