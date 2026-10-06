package com.campusnavigator.controller;

import com.campusnavigator.dao.ClassroomDAO;
import com.campusnavigator.model.Classroom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller displaying full classroom specifications, facility badges, and step-by-step navigation path.
 */
@WebServlet(name = "ClassroomDetailsServlet", urlPatterns = {"/classroom-details"})
public class ClassroomDetailsServlet extends HttpServlet {

    private ClassroomDAO classroomDAO;

    @Override
    public void init() {
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String roomParam = request.getParameter("room");

        Classroom classroom = null;

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                classroom = classroomDAO.getClassroomById(id);
            } catch (NumberFormatException ignored) {}
        } else if (roomParam != null && !roomParam.trim().isEmpty()) {
            classroom = classroomDAO.getClassroomByRoomNumber(roomParam.trim());
        }

        if (classroom != null) {
            request.setAttribute("classroom", classroom);
            request.getRequestDispatcher("/classroom-details.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("errorMessage", "No classroom found matching your request.");
            response.sendRedirect(request.getContextPath() + "/find-classroom");
        }
    }
}
