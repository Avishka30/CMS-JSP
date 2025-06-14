
<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.Complaint" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User loggedUser = (User) session.getAttribute("user");
  if (loggedUser == null || !"EMPLOYEE".equalsIgnoreCase(loggedUser.getRole())) {
    response.sendRedirect("index.jsp?error=unauthorized");
    return;
  }

  Complaint c = (Complaint) request.getAttribute("complaintToEdit");
  if (c == null || c.getUserId() != loggedUser.getId() || !"PENDING".equalsIgnoreCase(c.getStatus())) {
    response.sendRedirect("ComplaintServlet?action=dashboard&error=Invalid complaint to edit");
    return;
  }

  String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Edit Complaint</title>
  <style>
    body { font-family: 'Segoe UI', sans-serif; background-color: #f0f4f8; margin: 0; padding: 20px; }
    form { max-width: 600px; margin: 30px auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 6px 15px rgba(0,0,0,0.1); }
    input[type=text], textarea { width: 100%; padding: 8px; margin: 8px 0 15px; box-sizing: border-box; font-size: 1rem; }
    button { background-color: #28a745; color: white; border: none; padding: 10px 15px; font-size: 1rem; cursor: pointer; border-radius: 5px; }
    button:hover { background-color: #1e7e34; }
    .error { color: red; text-align: center; font-weight: 600; }
    a.back-link { display: block; max-width: 600px; margin: 10px auto; text-align: center; text-decoration: none; color: #007bff; }
    a.back-link:hover { text-decoration: underline; }
  </style>
</head>
<body>

<h2 style="text-align:center;">Edit Complaint</h2>

<% if (error != null) { %>
<div class="error"><%= error %></div>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/ComplaintServlet">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="id" value="<%= c.getId() %>">

  <label for="title">Title:</label><br>
  <input type="text" id="title" name="title" required maxlength="100" value="<%= c.getTitle() %>"><br>

  <label for="description">Description:</label><br>
  <textarea id="description" name="description" rows="4" required><%= c.getDescription() %></textarea><br>

  <button type="submit">Update Complaint</button>
</form>

<a href="<%= request.getContextPath() %>/ComplaintServlet?action=dashboard" class="back-link">Back to Dashboard</a>

</body>
</html>
