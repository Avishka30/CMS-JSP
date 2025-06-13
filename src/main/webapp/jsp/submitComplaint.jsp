<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 6/13/2025
  Time: 10:51 AM
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
    <title>Submit Complaint</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f8fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Submit Complaint</h2>
    <form action="../ComplaintServlet" method="post">
        <input type="hidden" name="action" value="submit">
        <input type="text" name="title" placeholder="Complaint Title" required>
        <textarea name="description" placeholder="Complaint Description" rows="5" required></textarea>
        <button type="submit">Submit</button>
    </form>
</div>
</body>
</html>

