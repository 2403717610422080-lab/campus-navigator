package com.campusnavigator.controller;

import com.campusnavigator.dao.UserDAO;
import com.campusnavigator.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller handling student registration.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String year = request.getParameter("year");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Server-side validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.usernameExists(username.trim())) {
            request.setAttribute("errorMessage", "Username '" + username + "' is already taken. Please choose another.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("errorMessage", "An account with email '" + email + "' already exists. Please log in.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(
                name.trim(),
                studentId != null ? studentId.trim() : "",
                email.trim().toLowerCase(),
                department != null ? department.trim() : "Computer Science",
                year != null ? year.trim() : "1st Year",
                username.trim(),
                password.trim(),
                "STUDENT"
        );

        boolean success = userDAO.register(newUser);

        if (success) {
            request.setAttribute("successMessage", "Registration successful! You can now log in with your credentials.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed due to a database error. Please try again.");
            preserveFields(request, name, studentId, email, department, year, username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void preserveFields(HttpServletRequest request, String name, String studentId, String email, String department, String year, String username) {
        request.setAttribute("name", name);
        request.setAttribute("studentId", studentId);
        request.setAttribute("email", email);
        request.setAttribute("department", department);
        request.setAttribute("year", year);
        request.setAttribute("username", username);
    }
}
