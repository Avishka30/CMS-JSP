package lk.ijse.gdse.cmsjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse.cmsjsp.dto.Complaint;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.ComplaintModel;

import java.io.IOException;
import java.util.List;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if ("submit".equals(action)) {
            if (user == null || !"EMPLOYEE".equals(user.getRole())) {
                response.sendRedirect("index.jsp?error=unauthorized");
                return;
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");

            Complaint complaint = new Complaint();
            complaint.setTitle(title);
            complaint.setDescription(description);
            complaint.setUserId(user.getId());

            ComplaintModel complaintModel = new ComplaintModel();
            boolean success = complaintModel.addComplaint(complaint);

            if (success) {
                response.sendRedirect("jsp/employeeDashboard.jsp?msg=success");
            } else {
                response.sendRedirect("jsp/submitComplaint.jsp?error=fail");
            }
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            Complaint complaint = new Complaint();
            complaint.setId(id);
            complaint.setTitle(title);
            complaint.setDescription(description);

            ComplaintModel complaintModel = new ComplaintModel();
            boolean updated = complaintModel.updateComplaint(complaint);

            if (updated) {
                response.sendRedirect("ComplaintServlet?action=view&msg=updated");
            } else {
                response.sendRedirect("ComplaintServlet?action=editForm&id=" + id + "&error=updateFailed");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ComplaintModel complaintModel = new ComplaintModel();

        if ("view".equals(action)) {
            if (user != null && "EMPLOYEE".equals(user.getRole())) {
                List<Complaint> complaints = complaintModel.getComplaintsByUserId(user.getId());
                request.setAttribute("complaints", complaints);
                request.getRequestDispatcher("jsp/viewComplaints.jsp").forward(request, response);
            } else {
                response.sendRedirect("index.jsp?error=unauthorized");
            }
        }

        if ("editForm".equals(action)) {
            int complaintId = Integer.parseInt(request.getParameter("id"));
            Complaint complaint = complaintModel.getComplaintById(complaintId);
            if (complaint != null && complaint.getUserId() == user.getId() && "PENDING".equals(complaint.getStatus())) {
                request.setAttribute("complaint", complaint);
                request.getRequestDispatcher("jsp/editComplaint.jsp").forward(request, response);
            } else {
                response.sendRedirect("ComplaintServlet?action=view&error=editNotAllowed");
            }
        }

        if ("delete".equals(action)) {
            int complaintId = Integer.parseInt(request.getParameter("id"));
            boolean deleted = complaintModel.deleteComplaint(complaintId);
            if (deleted) {
                response.sendRedirect("ComplaintServlet?action=view&msg=deleted");
            } else {
                response.sendRedirect("ComplaintServlet?action=view&error=deleteFailed");
            }
        }
    }
}
