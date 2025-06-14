package lk.ijse.gdse.cmsjsp.controller;//package lk.ijse.gdse.cmsjsp.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import lk.ijse.gdse.cmsjsp.dto.Complaint;
//import lk.ijse.gdse.cmsjsp.dto.User;
//import lk.ijse.gdse.cmsjsp.model.ComplaintModel;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/ComplaintServlet")
//public class ComplaintServlet extends HttpServlet {
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//
//        if ("submit".equals(action)) {
//            if (user == null || !"EMPLOYEE".equals(user.getRole())) {
//                response.sendRedirect("index.jsp?error=unauthorized");
//                return;
//            }
//
//            String title = request.getParameter("title");
//            String description = request.getParameter("description");
//
//            Complaint complaint = new Complaint();
//            complaint.setTitle(title);
//            complaint.setDescription(description);
//            complaint.setUserId(user.getId());
//
//            ComplaintModel complaintModel = new ComplaintModel();
//            boolean success = complaintModel.addComplaint(complaint);
//
//            if (success) {
//                response.sendRedirect("jsp/employeeDashboard.jsp?msg=success");
//            } else {
//                response.sendRedirect("jsp/submitComplaint.jsp?error=fail");
//            }
//        }
//
//        if ("update".equals(action)) {
//            int id = Integer.parseInt(request.getParameter("id"));
//            String title = request.getParameter("title");
//            String description = request.getParameter("description");
//
//            Complaint complaint = new Complaint();
//            complaint.setId(id);
//            complaint.setTitle(title);
//            complaint.setDescription(description);
//
//            ComplaintModel complaintModel = new ComplaintModel();
//            boolean updated = complaintModel.updateComplaint(complaint);
//
//            if (updated) {
//                response.sendRedirect("ComplaintServlet?action=view&msg=updated");
//            } else {
//                response.sendRedirect("ComplaintServlet?action=editForm&id=" + id + "&error=updateFailed");
//            }
//        }
//    }
//
//   /* protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        ComplaintModel complaintModel = new ComplaintModel();
//
//        if ("view".equals(action)) {
//            if (user != null && "EMPLOYEE".equals(user.getRole())) {
//                List<Complaint> complaints = complaintModel.getComplaintsByUserId(user.getId());
//                request.setAttribute("complaints", complaints);
//                request.getRequestDispatcher("jsp/viewComplaints.jsp").forward(request, response);
//            } else {
//                response.sendRedirect("index.jsp?error=unauthorized");
//            }
//        }
//
//        if ("editForm".equals(action)) {
//            int complaintId = Integer.parseInt(request.getParameter("id"));
//            Complaint complaint = complaintModel.getComplaintById(complaintId);
//            if (complaint != null && complaint.getUserId() == user.getId() && "PENDING".equals(complaint.getStatus())) {
//                request.setAttribute("complaint", complaint);
//                request.getRequestDispatcher("jsp/editComplaint.jsp").forward(request, response);
//            } else {
//                response.sendRedirect("ComplaintServlet?action=view&error=editNotAllowed");
//            }
//        }
//
//        if ("delete".equals(action)) {
//            int complaintId = Integer.parseInt(request.getParameter("id"));
//            boolean deleted = complaintModel.deleteComplaint(complaintId);
//            if (deleted) {
//                response.sendRedirect("ComplaintServlet?action=view&msg=deleted");
//            } else {
//                response.sendRedirect("ComplaintServlet?action=view&error=deleteFailed");
//            }
//        }
//    }*/
//   protected void doGet(HttpServletRequest request, HttpServletResponse response)
//           throws ServletException, IOException {
//
//       HttpSession session = request.getSession(false);
//       if (session == null) {
//           response.sendRedirect("index.jsp?error=unauthorized");
//           return;
//       }
//
//       User user = (User) session.getAttribute("user");
//       if (user == null) {
//           response.sendRedirect("index.jsp?error=unauthorized");
//           return;
//       }
//
//       String action = request.getParameter("action");
//
//       ComplaintModel complaintModel = new ComplaintModel();
//
//       // Default action: redirect to view complaints if no action given
//       if (action == null || action.isEmpty()) {
//           response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=view");
//           return;
//       }
//
//       switch (action) {
//           case "view":
//               if ("EMPLOYEE".equals(user.getRole())) {
//                   List<Complaint> complaints = complaintModel.getComplaintsByUserId(user.getId());
//                   request.setAttribute("complaints", complaints);
//                   request.getRequestDispatcher("jsp/employeeDashboard.jsp").forward(request, response);
//               } else {
//                   response.sendRedirect("index.jsp?error=unauthorized");
//               }
//               break;
//
//           case "editForm":
//               if ("EMPLOYEE".equals(user.getRole())) {
//                   int complaintId = Integer.parseInt(request.getParameter("id"));
//                   Complaint complaint = complaintModel.getComplaintById(complaintId);
//                   if (complaint != null
//                           && complaint.getUserId() == user.getId()
//                           && "PENDING".equals(complaint.getStatus())) {
//                       request.setAttribute("complaint", complaint);
//                       request.getRequestDispatcher("jsp/editComplaint.jsp").forward(request, response);
//                   } else {
//                       response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=view&error=editNotAllowed");
//                   }
//               } else {
//                   response.sendRedirect("index.jsp?error=unauthorized");
//               }
//               break;
//
//           case "delete":
//               if ("EMPLOYEE".equals(user.getRole())) {
//                   int complaintId = Integer.parseInt(request.getParameter("id"));
//                   boolean deleted = complaintModel.deleteComplaint(complaintId);
//                   if (deleted) {
//                       response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=view&msg=deleted");
//                   } else {
//                       response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=view&error=deleteFailed");
//                   }
//               } else {
//                   response.sendRedirect("index.jsp?error=unauthorized");
//               }
//               break;
//
//           default:
//               response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=view");
//               break;
//       }
//   }
//
//}
//



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
            // Load complaints for logged-in employee
            List<Complaint> complaints = complaintModel.getComplaintsByUserId(loggedUser.getId());
            request.setAttribute("complaints", complaints);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/employeeDashboard.jsp");
            dispatcher.forward(request, response);

        } else if ("editForm".equalsIgnoreCase(action)) {
            // Load complaint data for edit form
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
            // Delete complaint if PENDING
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
            // Default redirect to dashboard
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
            // Handle complaint submission
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
            // Handle complaint update
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

