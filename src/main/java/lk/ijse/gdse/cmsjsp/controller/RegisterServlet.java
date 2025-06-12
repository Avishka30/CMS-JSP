package lk.ijse.gdse.cmsjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.cmsjsp.dto.User;
import lk.ijse.gdse.cmsjsp.model.RegisterModel;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = req.getParameter("role");

        if (!password.equals(confirmPassword)) {
            resp.sendRedirect(req.getContextPath() + "/jsp/register.jsp?error=password");
            return;
        }

        RegisterModel model = new RegisterModel();

        if (model.userExists(username)) {
            resp.sendRedirect(req.getContextPath() + "/jsp/register.jsp?error=exists");
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        boolean registered = model.registerUser(user);

        if (registered) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?msg=registered");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/register.jsp?error=db");
        }
    }
}
