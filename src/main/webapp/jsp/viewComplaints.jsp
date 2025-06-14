<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.Complaint" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Your Complaints</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1000px;
      margin: 60px auto;
      background: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }

    .message {
      text-align: center;
      font-weight: bold;
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 20px;
    }

    .message.success {
      color: green;
      background: #e0ffe0;
    }

    .message.error {
      color: red;
      background: #ffe0e0;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      text-align: left;
      padding: 12px 15px;
      border-bottom: 1px solid #ccc;
    }

    th {
      background-color: #4a90e2;
      color: white;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    .status {
      font-weight: bold;
      padding: 5px 10px;
      border-radius: 5px;
      display: inline-block;
    }

    .status.pending {
      background-color: #ffecb3;
      color: #b88f00;
    }

    .status.resolved {
      background-color: #c8e6c9;
      color: #256029;
    }

    .status.other {
      background-color: #e3f2fd;
      color: #1e88e5;
    }

    .no-data {
      text-align: center;
      color: #777;
      font-style: italic;
      padding: 20px 0;
    }

    .action-btn {
      padding: 6px 12px;
      margin-right: 5px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
    }

    .edit-btn {
      background-color: #4CAF50;
      color: white;
    }

    .delete-btn {
      background-color: #f44336;
      color: white;
    }

    form.inline {
      display: inline;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Your Submitted Complaints</h2>

  <%
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
    if (msg != null) {
  %>
  <div class="message success"><%= msg %></div>
  <% } else if (error != null) { %>
  <div class="message error"><%= error %></div>
  <% } %>

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
      List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
      if (complaints != null && !complaints.isEmpty()) {
        for (Complaint c : complaints) {
    %>
    <tr>
      <td><%= c.getId() %></td>
      <td><%= c.getTitle() %></td>
      <td><%= c.getDescription() %></td>
      <td>
        <%
          String status = c.getStatus();
          String cssClass = "other";
          if ("PENDING".equalsIgnoreCase(status)) cssClass = "pending";
          else if ("RESOLVED".equalsIgnoreCase(status)) cssClass = "resolved";
        %>
        <span class="status <%= cssClass %>"><%= status %></span>
      </td>
      <td><%= (c.getRemarks() != null && !c.getRemarks().isEmpty()) ? c.getRemarks() : "-" %></td>
      <td>
        <% if ("PENDING".equalsIgnoreCase(c.getStatus())) { %>
        <a href="ComplaintServlet?action=editForm&id=<%= c.getId() %>" class="action-btn edit-btn">Edit</a>
        <a href="ComplaintServlet?action=delete&id=<%= c.getId() %>" class="action-btn delete-btn"
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
</div>
<div style="text-align: right; margin-bottom: 20px;">
  <a href="jsp/employeeDashboard.jsp"
     style="background-color: #4a90e2; color: white; padding: 8px 16px; text-decoration: none; border-radius: 5px; font-weight: bold;">
    &larr; Back to Dashboard
  </a>
</div>
</body>
</html>
