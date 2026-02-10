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
@WebServlet("/registrationUser")
public class UserRegistration extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession ses = req.getSession();

		if (req.getParameter("register") != null) {
			String Name = req.getParameter("name");
			String mobileNo = req.getParameter("mobileno");
			String Email = req.getParameter("email");
			String Address = req.getParameter("address");
			String City = req.getParameter("city");
			String State = req.getParameter("state");
			String pinCode = req.getParameter("pincode");
			String Password = req.getParameter("password");
			String cPassword = req.getParameter("cpassword");

			if (!Password.equals(cPassword)) {
				ses.setAttribute("uR_message", "Password and Confirm Password didn't match!");
				resp.sendRedirect("register.jsp");
			} else {

				// Get file
				Part part = req.getPart("Profile_img");
				String fileName = part.getSubmittedFileName();

				// Create upload folder path
				String uploadPath = getServletContext().getRealPath("") + "user_images";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}

				// Save image
				part.write(uploadPath + File.separator + fileName);

				// create image path to store in DB
				String imagePath = "user_images/" + fileName;

				/* System.out.println("uploaded path = "+ uploadPath); */

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root",
							"root");
					PreparedStatement pst = con.prepareStatement(
							"INSERT INTO user (name, mobileno, email, address, city, state, pincode, password, Profile_img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
					pst.setString(1, Name);
					pst.setString(2, mobileNo);
					pst.setString(3, Email);
					pst.setString(4, Address);
					pst.setString(5, City);
					pst.setString(6, State);
					pst.setString(7, pinCode);
					pst.setString(8, Password);
					pst.setString(9, imagePath);

					int result = pst.executeUpdate();

					if (result > 0) {
						resp.sendRedirect("login.jsp");
					}

				} catch (Exception e) {
					e.printStackTrace();

					if (e.getMessage().contains("mobileno")) {

						ses.setAttribute("uR_message", "Mobile number is already registered!");

					} else if (e.getMessage().contains("email")) {

						ses.setAttribute("uR_message", "Email is already registered!");

					} else {

						ses.setAttribute("uR_message", "Somthing went wrong");
					}

					resp.sendRedirect("register.jsp");
				}

			}
		}
	}
}
