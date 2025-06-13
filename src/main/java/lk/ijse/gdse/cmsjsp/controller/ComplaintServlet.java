package lk.ijse.gdse.cmsjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse.cmsjsp.dto.Complaint;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.ComplaintModel;


import java.io.IOException;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("submit".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null || !"EMPLOYEE".equals(user.getRole())) {
                response.sendRedirect("login.jsp?error=unauthorized");
                return;
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");

            Complaint complaint = new Complaint();
            complaint.setTitle(title);
            complaint.setDescription(description);
            complaint.setUserId(user.getId());

            System.out.println("User ID = " + user.getId());

            ComplaintModel complaintModel = new ComplaintModel();
            boolean success = complaintModel.addComplaint(complaint);

            if (success) {
                response.sendRedirect("jsp/employeeDashboard.jsp?msg=success");
            } else {
                response.sendRedirect("jsp/submitComplaint.jsp?error=fail");
            }
        }

        //view ekai delete ekai thiye
    }
}
