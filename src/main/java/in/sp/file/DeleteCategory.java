package in.sp.file;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteCategory")
public class DeleteCategory extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if (req.getParameter("delete") != null) {

			int SR_no = Integer.parseInt(req.getParameter("delete_id"));
			HttpSession session = req.getSession();

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easydeals", "root", "root");

				PreparedStatement ps = con.prepareStatement("DELETE FROM category WHERE sr_no = ?");
				ps.setInt(1, SR_no);

				int count = ps.executeUpdate();

				if (count > 0) {
					session.setAttribute("cd_message", "Category has been deleted successfully.");
				} else {
					session.setAttribute("cd_message", "Something went wrong.");
				}

				resp.sendRedirect("addCategory.jsp");

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("cd_message", "Something went wrong.");
				resp.sendRedirect("addCategory.jsp");
			}
		}
	}
}
