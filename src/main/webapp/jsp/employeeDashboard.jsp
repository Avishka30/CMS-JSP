<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 6/12/2025
  Time: 8:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User loggedUser = (User) session.getAttribute("user");
  if (loggedUser == null || !"EMPLOYEE".equals(loggedUser.getRole())) {
    response.sendRedirect("login.jsp?error=unauthorized");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #e9f0f7;
      margin: 0;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .dashboard {
      background-color: #ffffff;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 400px;
    }

    h2 {
      margin-bottom: 25px;
      color: #333;
    }

    .dashboard a {
      display: block;
      margin: 12px 0;
      padding: 12px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .dashboard a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="dashboard">
  <h2>Welcome, <%= loggedUser.getUsername() %> (Employee)</h2>

  <a href="submitComplaint.jsp">Submit New Complaint</a>
  <a href="<%=request.getContextPath()%>/ComplaintServlet?action=view">View My Complaints</a>
  <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>

</div>
</body>
</html>
