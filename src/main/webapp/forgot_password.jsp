<%@ page language="java" %>
<html>
<head><title>Forgot Password</title></head>
<body>
    <h2>Forgot Password</h2>
    <form method="post" action="SendCodeServlet">
        Enter your registered email:
        <input type="email" name="email" required />
        <button type="submit">Send Verification Code</button>
    </form>
</body>
</html>
