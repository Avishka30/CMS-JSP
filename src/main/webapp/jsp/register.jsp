
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Account</title>
  <link rel="stylesheet" href="../css/register.css">
</head>
<body>

<div class="form-container">
  <h2>Create Account (Employee)</h2>
  <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
    <input type="text" name="username" placeholder="Username" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

    <input type="hidden" name="role" value="EMPLOYEE">

    <button type="submit">Sign Up</button>
  </form>

  <%
    String error = request.getParameter("error");
  %>
  <div class="error">
    <% if ("password".equals(error)) { %>
    Passwords do not match!
    <% } else if ("exists".equals(error)) { %>
    Username already exists!
    <% } else if ("db".equals(error)) { %>
    Something went wrong! Please try again.
    <% } %>
  </div>
</div>

<script src="../js/register.js"></script>
</body>
</html>
