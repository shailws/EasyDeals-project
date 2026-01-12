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
@WebServlet("/addProduct")
public class AddProduct extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("add") != null) {

			HttpSession ses = req.getSession();

			String p_Title = req.getParameter("p_title");
			String p_Description = req.getParameter("p_description");
			String p_Category = req.getParameter("p_category");
			String p_Price = req.getParameter("p_price");
			String p_discount = req.getParameter("p_discount");

			int p_Discount = Integer.parseInt(p_discount);

			if (p_Discount < 0 || p_Discount > 100) {
				ses.setAttribute("p_Add", "Invalid percentage value.");
				resp.sendRedirect("addProduct.jsp");
			} else {
				String is_Active = req.getParameter("isActive");
				String p_Stock = req.getParameter("p_stock");

				// Get file
				Part part = req.getPart("p_image");
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
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root",
							"root");

					PreparedStatement ps = con.prepareStatement(
							"INSERT INTO product (p_title, p_description, p_category, p_price, isActive, p_stock, p_image, p_discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

					ps.setString(1, p_Title);
					ps.setString(2, p_Description);
					ps.setString(3, p_Category);
					ps.setString(4, p_Price);
					ps.setString(5, is_Active);
					ps.setString(6, p_Stock);
					ps.setString(7, imagePath);
					ps.setInt(8, p_Discount);

					int count = ps.executeUpdate();

					if (count > 0) {
						ses.setAttribute("p_Add", "Product has been added successfully.");
					}

					resp.sendRedirect("addProduct.jsp");
					con.close();

				} catch (Exception e) {
					e.printStackTrace();
					ses.setAttribute("p_Add", "Something went wrong.");
					resp.sendRedirect("addProduct.jsp");
				}

			}
		}
	}
}
