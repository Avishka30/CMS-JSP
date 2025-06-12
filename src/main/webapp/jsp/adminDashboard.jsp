<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 6/12/2025
  Time: 8:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>
<%
  User loggedUser = (User) session.getAttribute("user");
  if (loggedUser == null || !"ADMIN".equals(loggedUser.getRole())) {
    response.sendRedirect("login.jsp?error=unauthorized");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
</head>
<body>
<h2>Welcome, <%= loggedUser.getUsername() %> (Admin)</h2>
<ul>
  <li><a href="view_complaints.jsp">View All Complaints</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
</body>
</html>
