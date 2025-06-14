<%--
<%@ page import="lk.ijse.gdse.cmsjsp.dto.Complaint" %>
<%
  Complaint complaint = (Complaint) request.getAttribute("complaint");
  if (complaint == null) {
    response.sendRedirect("ComplaintServlet?action=view");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Edit Complaint</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      min-height: 100vh;
    }

    .container {
      background: white;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      max-width: 600px;
      width: 100%;
    }

    h2 {
      margin-bottom: 25px;
      color: #333;
      text-align: center;
    }

    label {
      display: block;
      margin-top: 20px;
      font-weight: 600;
      color: #555;
    }

    input[type="text"],
    textarea {
      width: 100%;
      padding: 12px 15px;
      margin-top: 6px;
      border: 1.5px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
      resize: vertical;
      font-family: inherit;
    }

    input[type="text"]:focus,
    textarea:focus {
      outline: none;
      border-color: #4a90e2;
      box-shadow: 0 0 6px rgba(74, 144, 226, 0.5);
    }

    button.btn {
      margin-top: 30px;
      width: 100%;
      padding: 12px 0;
      background-color: #4a90e2;
      border: none;
      border-radius: 8px;
      color: white;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button.btn:hover {
      background-color: #357ABD;
    }

    .back-link {
      display: block;
      margin-top: 20px;
      text-align: center;
      font-weight: 500;
      text-decoration: none;
      color: #4a90e2;
      transition: color 0.3s ease;
    }

    .back-link:hover {
      color: #357ABD;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Edit Complaint</h2>
  <form action="ComplaintServlet" method="post" novalidate>
    <input type="hidden" name="action" value="update" />
    <input type="hidden" name="id" value="<%= complaint.getId() %>" />

    <label for="title">Title:</label>
    <input type="text" id="title" name="title" value="<%= complaint.getTitle() %>" required />

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="5" required><%= complaint.getDescription() %></textarea>

    <button type="submit" class="btn">Update Complaint</button>
  </form>
  <a href="ComplaintServlet?action=view" class="back-link">&larr; Back to Complaints</a>
</div>

</body>
</html>
--%>
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
