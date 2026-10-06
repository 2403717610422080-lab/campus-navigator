package com.campusnavigator.controller;

import com.campusnavigator.dao.CampusLocationDAO;
import com.campusnavigator.dao.ClassroomDAO;
import com.campusnavigator.dao.UserDAO;
import com.campusnavigator.model.Classroom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller providing administrative statistics and quick management shortcuts.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private ClassroomDAO classroomDAO;
    private CampusLocationDAO locationDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        classroomDAO = new ClassroomDAO();
        locationDAO = new CampusLocationDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalRooms = classroomDAO.getTotalCount();
        int totalLabs = classroomDAO.countByType("Laboratory");
        int totalHalls = classroomDAO.countByType("Seminar Hall") + classroomDAO.countByType("Auditorium");
        int totalLocations = locationDAO.getTotalCount();
        int totalStudents = userDAO.countUsersByRole("STUDENT");

        List<Classroom> recentClassrooms = classroomDAO.getAllClassrooms();
        if (recentClassrooms.size() > 8) {
            recentClassrooms = recentClassrooms.subList(0, 8);
        }

        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("totalLabs", totalLabs);
        request.setAttribute("totalHalls", totalHalls);
        request.setAttribute("totalLocations", totalLocations);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("recentClassrooms", recentClassrooms);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
