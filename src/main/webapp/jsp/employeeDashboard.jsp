<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 6/12/2025
  Time: 8:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%--%>
<%--  User loggedUser = (User) session.getAttribute("user");--%>
<%--  if (loggedUser == null || !"EMPLOYEE".equals(loggedUser.getRole())) {--%>
<%--    response.sendRedirect("login.jsp?error=unauthorized");--%>
<%--    return;--%>
<%--  }--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title>Employee Dashboard</title>--%>
<%--  <style>--%>
<%--    body {--%>
<%--      font-family: 'Segoe UI', sans-serif;--%>
<%--      background-color: #e9f0f7;--%>
<%--      margin: 0;--%>
<%--      padding: 0;--%>
<%--      display: flex;--%>
<%--      align-items: center;--%>
<%--      justify-content: center;--%>
<%--      height: 100vh;--%>
<%--    }--%>

<%--    .dashboard {--%>
<%--      background-color: #ffffff;--%>
<%--      padding: 30px 40px;--%>
<%--      border-radius: 10px;--%>
<%--      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);--%>
<%--      text-align: center;--%>
<%--      width: 400px;--%>
<%--    }--%>

<%--    h2 {--%>
<%--      margin-bottom: 25px;--%>
<%--      color: #333;--%>
<%--    }--%>

<%--    .dashboard a {--%>
<%--      display: block;--%>
<%--      margin: 12px 0;--%>
<%--      padding: 12px;--%>
<%--      background-color: #007bff;--%>
<%--      color: white;--%>
<%--      text-decoration: none;--%>
<%--      border-radius: 5px;--%>
<%--      font-weight: bold;--%>
<%--      transition: background-color 0.3s ease;--%>
<%--    }--%>

<%--    .dashboard a:hover {--%>
<%--      background-color: #0056b3;--%>
<%--    }--%>
<%--  </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="dashboard">--%>
<%--  <h2>Welcome, <%= loggedUser.getUsername() %> (Employee)</h2>--%>

<%--  <a href="submitComplaint.jsp">Submit New Complaint</a>--%>
<%--  <a href="<%=request.getContextPath()%>/ComplaintServlet?action=view">View My Complaints</a>--%>
<%--  <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>--%>

<%--</div>--%>
<%--</body>--%>
<%--</html>--%>

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
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      height: 100vh;
      padding-top: 50px;
    }

    h2 {
      color: #333;
      margin-bottom: 40px;
    }

    .card-container {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 30px;
      width: 90%;
      max-width: 900px;
    }

    .card {
      background-color: white;
      padding: 30px 20px;
      border-radius: 15px;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
      text-align: center;
      cursor: pointer;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      user-select: none;
    }

    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
    }

    .card a {
      text-decoration: none;
      color: #007bff;
      font-size: 1.4rem;
      font-weight: 700;
      display: block;
      margin-top: 15px;
    }

    .card-icon {
      font-size: 48px;
      color: #007bff;
    }
  </style>
</head>
<body>
<h2>Welcome, <%= loggedUser.getUsername() %> (Employee)</h2>

<div class="card-container">
  <div class="card" onclick="location.href='submitComplaint.jsp'">
    <div class="card-icon">📝</div>
    <div>Submit New Complaint</div>
    <a href="submitComplaint.jsp">Go</a>
  </div>

  <div class="card" onclick="location.href='<%=request.getContextPath()%>/ComplaintServlet?action=view'">
    <div class="card-icon">📋</div>
    <div>View My Complaints</div>
    <a href="<%=request.getContextPath()%>/ComplaintServlet?action=view">Go</a>
  </div>

  <div class="card" onclick="location.href='<%= request.getContextPath() %>/LogoutServlet'">
    <div class="card-icon">🚪</div>
    <div>Logout</div>
    <a href="<%= request.getContextPath() %>/LogoutServlet">Go</a>
  </div>
</div>
</body>
</html>

