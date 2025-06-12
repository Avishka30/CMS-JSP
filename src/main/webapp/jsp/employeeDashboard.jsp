<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 6/12/2025
  Time: 8:07 PM
  To change this template use File | Settings | File Templates.
--%>
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
</head>
<body>
<h2>Welcome, <%= loggedUser.getUsername() %> (Employee)</h2>
<ul>
  <li><a href="submit_complaint.jsp">Submit New Complaint</a></li>
  <li><a href="view_complaints.jsp">View My Complaints</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
</body>
</html>

