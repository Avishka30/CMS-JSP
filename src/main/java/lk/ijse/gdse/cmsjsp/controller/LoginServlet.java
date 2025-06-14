/*
package lk.ijse.gdse.cmsjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.UserModel;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserModel userModel = new UserModel();
        User user = userModel.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("EMPLOYEE".equals(user.getRole())) {
                response.sendRedirect("jsp/employeeDashboard.jsp");
            } else if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("jsp/adminDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp?error=role");
            }
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
    }
}
*/

package lk.ijse.gdse.cmsjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.UserModel;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserModel userModel = new UserModel();
        User user = userModel.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("EMPLOYEE".equals(user.getRole())) {
                // ✅ Redirect through ComplaintServlet to load data
                response.sendRedirect("ComplaintServlet?action=dashboard");
            } else if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("jsp/adminDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp?error=role");
            }
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
    }
}
