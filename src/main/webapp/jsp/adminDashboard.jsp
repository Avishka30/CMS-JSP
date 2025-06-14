<%@ page import="lk.ijse.gdse.cmsjsp.dto.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
      grid-template-columns: repeat(2, 1fr);
      gap: 30px;
      width: 90%;
      max-width: 700px;
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
<h2>Welcome, <%= loggedUser.getUsername() %> (Admin)</h2>

<div class="card-container">
  <div class="card" onclick="location.href='<%= request.getContextPath() %>/AdminServlet?action=adminView'">
    <div class="card-icon">🧾</div>
    <div>View All Complaints</div>
    <a href="<%= request.getContextPath() %>/AdminServlet?action=adminView">Go</a>
  </div>

  <div class="card" onclick="location.href='<%= request.getContextPath() %>/LogoutServlet'">
    <div class="card-icon">🚪</div>
    <div>Logout</div>
    <a href="<%= request.getContextPath() %>/LogoutServlet">Go</a>
  </div>
</div>
</body>
</html>

