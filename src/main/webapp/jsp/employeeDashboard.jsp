<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User loggedUser = (User) session.getAttribute("user");
  if (loggedUser == null || !"EMPLOYEE".equalsIgnoreCase(loggedUser.getRole())) {
    response.sendRedirect("index.jsp?error=unauthorized");
    return;
  }

  List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");

  String msg = request.getParameter("msg");
  String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard</title>
  <style>
    body { font-family: 'Segoe UI', sans-serif; background-color: #f0f4f8; margin: 0; padding: 20px; }
    h2 { text-align: center; color: #333; }
    .msg { color: green; text-align: center; font-weight: 600; }
    .error { color: red; text-align: center; font-weight: 600; }
    form, table { max-width: 900px; margin: 20px auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 6px 15px rgba(0,0,0,0.1); }
    form input[type=text], form textarea { width: 100%; padding: 8px; margin: 8px 0 15px; box-sizing: border-box; font-size: 1rem; }
    form button { background-color: #007bff; color: white; border: none; padding: 10px 15px; font-size: 1rem; cursor: pointer; border-radius: 5px; }
    form button:hover { background-color: #0056b3; }
    table { width: 100%; border-collapse: collapse; text-align: left; }
    table th, table td { padding: 12px; border-bottom: 1px solid #ddd; vertical-align: middle; }
    table th { background-color: #007bff; color: white; }
    .action-btn { padding: 6px 12px; margin-right: 5px; border: none; border-radius: 4px; cursor: pointer; font-weight: 600; color: white; }
    .edit-btn { background-color: #28a745; }
    .edit-btn:hover { background-color: #1e7e34; }
    .delete-btn { background-color: #dc3545; }
    .delete-btn:hover { background-color: #b02a37; }
    .logout-link { display: block; width: 120px; margin: 30px auto 0; text-align: center; background-color: #6c757d; color: white; padding: 10px; border-radius: 6px; text-decoration: none; font-weight: 700; }
    .logout-link:hover { background-color: #5a6268; }
    .no-data { text-align: center; font-style: italic; color: #777; }

    .status.pending { color: orange; font-weight: 600; }
    .status.resolved { color: green; font-weight: 600; }
    .status.other { color: gray; font-weight: 600; }
  </style>
</head>
<body>

<h2>Welcome, <%= loggedUser.getUsername() %> (Employee)</h2>

<% if (msg != null) { %>
<div class="msg"><%= msg %></div>
<% } else if (error != null) { %>
<div class="error"><%= error %></div>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/ComplaintServlet">
  <input type="hidden" name="action" value="submit">
  <label for="title">Title:</label><br>
  <input type="text" id="title" name="title" required maxlength="100" placeholder="Enter complaint title"><br>

  <label for="description">Description:</label><br>
  <textarea id="description" name="description" rows="4" required placeholder="Enter complaint description"></textarea><br>

  <button type="submit">Submit Complaint</button>
</form>

<table>
  <thead>
  <tr>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Status</th>
    <th>Remarks</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    if (complaints != null && !complaints.isEmpty()) {
      for (Complaint c : complaints) {
        String status = c.getStatus();
        String cssClass = "other";
        if ("PENDING".equalsIgnoreCase(status)) cssClass = "pending";
        else if ("RESOLVED".equalsIgnoreCase(status)) cssClass = "resolved";
  %>
  <tr>
    <td><%= c.getId() %></td>
    <td><%= c.getTitle() %></td>
    <td><%= c.getDescription() %></td>
    <td><span class="status <%= cssClass %>"><%= status %></span></td>
    <td><%= (c.getRemarks() != null && !c.getRemarks().isEmpty()) ? c.getRemarks() : "-" %></td>
    <td>
      <% if ("PENDING".equalsIgnoreCase(status)) { %>
      <a href="<%= request.getContextPath() %>/ComplaintServlet?action=editForm&id=<%= c.getId() %>" class="action-btn edit-btn">Edit</a>
      <a href="<%= request.getContextPath() %>/ComplaintServlet?action=delete&id=<%= c.getId() %>" class="action-btn delete-btn"
         onclick="return confirm('Are you sure you want to delete this complaint?');">Delete</a>
      <% } else { %>
      <em>Not editable</em>
      <% } %>
    </td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="6" class="no-data">You haven't submitted any complaints yet.</td>
  </tr>
  <% } %>
  </tbody>
</table>

<a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-link">Logout</a>

</body>
</html>
