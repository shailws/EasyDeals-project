
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
	 
	   private static final String CLIENT_ID = "19671921021-1o31nbfsgp1cvsh4kuap3j7s7um3rrc1.apps.googleusercontent.com";
	    
	    
	    private static final String REDIRECT_URI = "http://localhost:8080/OneNewFinalProject/oauth2callback";
    private static final String SCOPE = "openid email profile";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oauthURL = "https://accounts.google.com/o/oauth2/v2/auth?"
                + "scope=" + SCOPE
                + "&access_type=online"
                + "&include_granted_scopes=true"
                + "&response_type=code"
                + "&state=state_parameter_passthrough_value"
                + "&redirect_uri=" + REDIRECT_URI
                + "&client_id=" + CLIENT_ID;

        response.sendRedirect(oauthURL);
    }
}
