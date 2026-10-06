package com.campusnavigator.controller;

import com.campusnavigator.dao.CampusLocationDAO;
import com.campusnavigator.dao.ClassroomDAO;
import com.campusnavigator.model.Classroom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller serving the student and staff campus dashboard with quick links and statistics.
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private ClassroomDAO classroomDAO;
    private CampusLocationDAO locationDAO;

    @Override
    public void init() {
        classroomDAO = new ClassroomDAO();
        locationDAO = new CampusLocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalClassrooms = classroomDAO.countByType("Classroom");
        int totalLabs = classroomDAO.countByType("Laboratory");
        int totalSeminarHalls = classroomDAO.countByType("Seminar Hall") + classroomDAO.countByType("Auditorium");
        int totalLocations = locationDAO.getTotalCount();

        List<String> blocks = classroomDAO.getDistinctBlocks();
        List<String> departments = classroomDAO.getDistinctDepartments();
        List<Classroom> featuredClassrooms = classroomDAO.getAllClassrooms();
        if (featuredClassrooms.size() > 6) {
            featuredClassrooms = featuredClassrooms.subList(0, 6);
        }

        request.setAttribute("totalClassrooms", totalClassrooms);
        request.setAttribute("totalLabs", totalLabs);
        request.setAttribute("totalSeminarHalls", totalSeminarHalls);
        request.setAttribute("totalLocations", totalLocations);
        request.setAttribute("blocks", blocks);
        request.setAttribute("departments", departments);
        request.setAttribute("featuredClassrooms", featuredClassrooms);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
