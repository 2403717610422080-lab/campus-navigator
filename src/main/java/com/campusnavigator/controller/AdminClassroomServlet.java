package com.campusnavigator.controller;

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
 * Controller handling Admin CRUD operations for Classrooms and Laboratories.
 */
@WebServlet(name = "AdminClassroomServlet", urlPatterns = {"/admin/classrooms", "/admin/add-classroom", "/admin/edit-classroom", "/admin/delete-classroom"})
public class AdminClassroomServlet extends HttpServlet {

    private ClassroomDAO classroomDAO;

    @Override
    public void init() {
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if ("/admin/delete-classroom".equals(servletPath)) {
            handleDelete(request, response);
            return;
        }

        if ("/admin/add-classroom".equals(servletPath)) {
            request.setAttribute("formMode", "ADD");
            request.getRequestDispatcher("/admin/classroom-form.jsp").forward(request, response);
            return;
        }

        if ("/admin/edit-classroom".equals(servletPath)) {
            String idStr = request.getParameter("id");
            try {
                int id = Integer.parseInt(idStr);
                Classroom c = classroomDAO.getClassroomById(id);
                if (c != null) {
                    request.setAttribute("classroom", c);
                    request.setAttribute("formMode", "EDIT");
                    request.getRequestDispatcher("/admin/classroom-form.jsp").forward(request, response);
                    return;
                }
            } catch (Exception ignored) {}
            response.sendRedirect(request.getContextPath() + "/admin/classrooms");
            return;
        }

        // Default: list all classrooms
        String search = request.getParameter("search");
        List<Classroom> list;
        if (search != null && !search.trim().isEmpty()) {
            list = classroomDAO.searchClassrooms(search, null, null, null, null);
        } else {
            list = classroomDAO.getAllClassrooms();
        }

        request.setAttribute("classrooms", list);
        request.setAttribute("searchQuery", search != null ? search : "");
        request.getRequestDispatcher("/admin/manage-classrooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        String roomNumber = request.getParameter("roomNumber");
        String roomName = request.getParameter("roomName");
        String block = request.getParameter("block");
        String floor = request.getParameter("floor");
        String department = request.getParameter("department");
        String roomType = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String facilities = request.getParameter("facilities");
        String description = request.getParameter("description");
        String navigationPath = request.getParameter("navigationPath");

        int capacity = 60;
        try {
            capacity = Integer.parseInt(capacityStr);
        } catch (Exception ignored) {}

        if ("/admin/add-classroom".equals(servletPath)) {
            // Check for duplicate room number
            if (classroomDAO.getClassroomByRoomNumber(roomNumber) != null) {
                request.setAttribute("errorMessage", "Room number '" + roomNumber + "' already exists.");
                request.setAttribute("formMode", "ADD");
                request.getRequestDispatcher("/admin/classroom-form.jsp").forward(request, response);
                return;
            }

            Classroom c = new Classroom(0, roomNumber, roomName, block, floor, department, roomType, capacity, facilities, description, navigationPath, null);
            boolean success = classroomDAO.addClassroom(c);

            if (success) {
                request.getSession().setAttribute("successMessage", "Classroom " + roomNumber + " added successfully.");
                response.sendRedirect(request.getContextPath() + "/admin/classrooms");
            } else {
                request.setAttribute("errorMessage", "Failed to add classroom.");
                request.setAttribute("formMode", "ADD");
                request.getRequestDispatcher("/admin/classroom-form.jsp").forward(request, response);
            }
        } else if ("/admin/edit-classroom".equals(servletPath)) {
            String idStr = request.getParameter("id");
            try {
                int id = Integer.parseInt(idStr);
                Classroom c = new Classroom(id, roomNumber, roomName, block, floor, department, roomType, capacity, facilities, description, navigationPath, null);
                boolean success = classroomDAO.updateClassroom(c);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Classroom " + roomNumber + " updated successfully.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to update classroom.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Invalid classroom ID.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/classrooms");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            boolean success = classroomDAO.deleteClassroom(id);
            if (success) {
                request.getSession().setAttribute("successMessage", "Classroom deleted successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete classroom.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Invalid ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/classrooms");
    }
}
