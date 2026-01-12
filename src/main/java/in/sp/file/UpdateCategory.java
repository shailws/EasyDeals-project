package in.sp.file;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/updateCategory")
public class UpdateCategory extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("update") != null) {

			String update_Id = request.getParameter("update_id");
			HttpSession session = request.getSession();

			String Name = request.getParameter("category_name");
			String Status = request.getParameter("isActive");

			// Get file
			Part part = request.getPart("category_img");
			String fileName = part.getSubmittedFileName();

			// Create upload folder path
			String uploadPath = getServletContext().getRealPath("") + "category_images";
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}

			// Save image
			part.write(uploadPath + File.separator + fileName);

			// create image path to store in DB
			String imagePath = "category_images/" + fileName;

			/* System.out.println("uploaded path = "+ uploadPath); */

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

				PreparedStatement ps = con.prepareStatement(
						"update category set category_name=?, isActive=?, category_img=? WHERE sr_no=?");

				ps.setString(1, Name);
				ps.setString(2, Status);
				ps.setString(3, imagePath);
				ps.setString(4, update_Id);

				int count = ps.executeUpdate();

				if (count > 0) {
					session.setAttribute("cU_message", "Category has been updated successfully.");
				} else {
					session.setAttribute("cU_message", "Something went wrong.");
				}
				response.sendRedirect("addCategory.jsp?success=1");

				con.close();

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("cU_message", "Something went wrong.");
				response.sendRedirect("addCategory.jsp");
			}
		}

	}
}
