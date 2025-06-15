<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse.cmsjsp.dto.Complaint" %>
<%
    List<Complaint> allComplaints = (List<Complaint>) request.getAttribute("allComplaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - View All Complaints</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            padding: 40px;
        }
        h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f9ff;
        }
        input[type="text"], select {
            width: 100%;
            padding: 6px 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 2px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .delete-btn {
            background-color: #dc3545;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .msg {
            max-width: 900px;
            margin: 0 auto 20px auto;
            text-align: center;
            font-weight: bold;
            color: green;
        }
        .error-msg {
            max-width: 900px;
            margin: 0 auto 20px auto;
            text-align: center;
            font-weight: bold;
            color: red;
        }
        form.update-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        form.update-form select, form.update-form input[type="text"] {
            flex: 1;
        }
         #backBtn {
             display: inline-block;
             background-color: #007bff;
             color: white;
             padding: 8px 14px;
             border-radius: 6px;
             text-decoration: none;
             font-weight: 600;
             cursor: pointer;
             float: right;
             margin-bottom: 10px;
             transition: background-color 0.3s ease;
         }

        #backBtn:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
<h2>All Complaints</h2>

<a id="backBtn" href="<%= request.getContextPath() %>/jsp/adminDashboard.jsp" ...>Back to Dashboard</a>

<%
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
    if ("updated".equals(msg)) {
%>
<div class="msg">Complaint updated successfully.</div>
<%
} else if ("deleted".equals(msg)) {
%>
<div class="msg">Complaint deleted successfully.</div>
<%
} else if ("updateFailed".equals(error)) {
%>
<div class="error-msg">Failed to update complaint.</div>
<%
} else if ("deleteFailed".equals(error)) {
%>
<div class="error-msg">Failed to delete complaint.</div>
<%
    }
%>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status & Remarks</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (allComplaints != null && !allComplaints.isEmpty()) {
            for (Complaint c : allComplaints) {
    %>
    <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getUserId() %></td>
        <td><%= c.getTitle() %></td>
        <td><%= c.getDescription() %></td>
        <td>
            <form action="AdminServlet" method="post" class="update-form" style="margin:0;">
                <input type="hidden" name="action" value="adminUpdate">
                <input type="hidden" name="id" value="<%= c.getId() %>">

                <select name="status" required>
                    <option value="PENDING" <%= "PENDING".equals(c.getStatus()) ? "selected" : "" %>>PENDING</option>
                    <option value="REJECT" <%= "REJECT".equals(c.getStatus()) ? "selected" : "" %>>REJECT</option>
                    <option value="RESOLVED" <%= "RESOLVED".equals(c.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                </select>

                <input type="text" name="remarks" value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>" placeholder="Add remarks">

                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="AdminServlet" method="post" style="margin:0;">
                <input type="hidden" name="action" value="adminDelete">
                <input type="hidden" name="id" value="<%= c.getId() %>">
                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this complaint?');">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">No complaints found.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>
