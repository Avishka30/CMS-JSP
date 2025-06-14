package lk.ijse.gdse.cmsjsp.controller;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cmsjsp.dto.Complaint;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.ComplaintModel;

import java.io.IOException;
import java.util.List;


@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    private ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (loggedUser == null) {
            response.sendRedirect("index.jsp?error=unauthorized");
            return;
        }

        if ("dashboard".equalsIgnoreCase(action)) {

            List<Complaint> complaints = complaintModel.getComplaintsByUserId(loggedUser.getId());
            request.setAttribute("complaints", complaints);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/employeeDashboard.jsp");
            dispatcher.forward(request, response);

        } else if ("editForm".equalsIgnoreCase(action)) {

            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Complaint c = complaintModel.getComplaintById(id);
                if (c != null && c.getUserId() == loggedUser.getId()) {
                    request.setAttribute("complaintToEdit", c);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/editComplaint.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            }
            response.sendRedirect("ComplaintServlet?action=dashboard&error=Invalid complaint");
        } else if ("delete".equalsIgnoreCase(action)) {

            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                boolean deleted = complaintModel.deleteComplaint(id);
                if (deleted) {
                    response.sendRedirect("ComplaintServlet?action=dashboard&msg=Complaint deleted");
                } else {
                    response.sendRedirect("ComplaintServlet?action=dashboard&error=Cannot delete complaint");
                }
            } else {
                response.sendRedirect("ComplaintServlet?action=dashboard&error=Invalid complaint ID");
            }
        } else {

            response.sendRedirect("ComplaintServlet?action=dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (loggedUser == null) {
            response.sendRedirect("index.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");

        if ("submit".equalsIgnoreCase(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            Complaint complaint = new Complaint();
            complaint.setTitle(title);
            complaint.setDescription(description);
            complaint.setUserId(loggedUser.getId());

            boolean added = complaintModel.addComplaint(complaint);
            if (added) {
                response.sendRedirect("ComplaintServlet?action=dashboard&msg=Complaint submitted successfully");
            } else {
                response.sendRedirect("ComplaintServlet?action=dashboard&error=Failed to submit complaint");
            }

        } else if ("update".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Complaint complaint = complaintModel.getComplaintById(id);

                if (complaint != null && complaint.getUserId() == loggedUser.getId() && "PENDING".equalsIgnoreCase(complaint.getStatus())) {
                    complaint.setTitle(title);
                    complaint.setDescription(description);
                    boolean updated = complaintModel.updateComplaint(complaint);
                    if (updated) {
                        response.sendRedirect("ComplaintServlet?action=dashboard&msg=Complaint updated successfully");
                    } else {
                        response.sendRedirect("ComplaintServlet?action=editForm&id=" + id + "&error=Failed to update complaint");
                    }
                } else {
                    response.sendRedirect("ComplaintServlet?action=dashboard&error=Invalid complaint or not editable");
                }
            } else {
                response.sendRedirect("ComplaintServlet?action=dashboard&error=Invalid complaint ID");
            }
        } else {
            response.sendRedirect("ComplaintServlet?action=dashboard");
        }
    }
}

