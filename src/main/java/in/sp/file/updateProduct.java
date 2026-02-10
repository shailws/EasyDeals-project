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
@WebServlet("/updateProduct")
public class updateProduct extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession ses = req.getSession();

		if (req.getParameter("update") != null) {

			String updateId = req.getParameter("update_id");

			// Get file
			Part part = req.getPart("p_img");
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

			String product_Title = req.getParameter("p_title");
			String product_Description = req.getParameter("p_description");
			String product_Category = req.getParameter("p_category");
			String product_Price = req.getParameter("p_price");
			String product_Status = req.getParameter("isActive");
			String product_Stock = req.getParameter("p_stock");
			String p_discount = req.getParameter("p_discount");

			int p_Discount = Integer.parseInt(p_discount);

			if (p_Discount < 0 || p_Discount > 100) {
				ses.setAttribute("pU_message", "Invalid percentage value.");
				resp.sendRedirect("viewProduct.jsp");
			} else {
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root",
							"root");

					PreparedStatement ps = con.prepareStatement(
							"update product set p_image=?, p_title=?, p_description=?, p_category=?, p_price=?, isActive=?, p_stock=?, p_discount=?  WHERE sr_no=?");

					ps.setString(1, imagePath);
					ps.setString(2, product_Title);
					ps.setString(3, product_Description);
					ps.setString(4, product_Category);
					ps.setString(5, product_Price);
					ps.setString(6, product_Status);
					ps.setString(7, product_Stock);
					ps.setInt(8, p_Discount);
					ps.setString(9, updateId);

					int count = ps.executeUpdate();

					if (count > 0) {
						ses.setAttribute("pU_message", "Product has been updated successfully.");
					} else {
						ses.setAttribute("pU_message", "Something went wrong.");
					}
					resp.sendRedirect("viewProduct.jsp");

					con.close();

				} catch (Exception e) {
					e.printStackTrace();
					ses.setAttribute("pU_message", "Something went wrong.");
					resp.sendRedirect("viewProduct.jsp");
				}
			}

		}
	}
}
