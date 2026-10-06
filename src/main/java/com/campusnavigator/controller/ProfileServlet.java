package com.campusnavigator.controller;

import com.campusnavigator.dao.UserDAO;
import com.campusnavigator.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller allowing users to inspect and update their student/staff profile information.
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User freshUser = userDAO.getUserById(sessionUser.getId());
        request.setAttribute("profileUser", freshUser != null ? freshUser : sessionUser);

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String year = request.getParameter("year");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Full Name cannot be blank.");
            doGet(request, response);
            return;
        }

        User userToUpdate = userDAO.getUserById(sessionUser.getId());
        if (userToUpdate != null) {
            userToUpdate.setName(name.trim());
            userToUpdate.setDepartment(department != null ? department.trim() : "Computer Science");
            userToUpdate.setYear(year != null ? year.trim() : "1st Year");

            boolean success = userDAO.updateProfile(userToUpdate);
            if (success) {
                session.setAttribute("user", userToUpdate);
                session.setAttribute("userName", userToUpdate.getName());
                session.setAttribute("userDepartment", userToUpdate.getDepartment());
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile.");
            }
        }

        doGet(request, response);
    }
}
