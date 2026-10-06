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
 * Controller handling classroom and lab multi-criteria search and filter queries.
 */
@WebServlet(name = "ClassroomSearchServlet", urlPatterns = {"/find-classroom"})
public class ClassroomSearchServlet extends HttpServlet {

    private ClassroomDAO classroomDAO;

    @Override
    public void init() {
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        String block = request.getParameter("block");
        String floor = request.getParameter("floor");
        String department = request.getParameter("department");
        String roomType = request.getParameter("roomType");

        List<Classroom> searchResults;

        boolean isSearchAttempt = (roomNumber != null || block != null || floor != null || department != null || roomType != null);

        if (isSearchAttempt) {
            searchResults = classroomDAO.searchClassrooms(roomNumber, block, floor, department, roomType);
        } else {
            searchResults = classroomDAO.getAllClassrooms();
        }

        List<String> blocks = classroomDAO.getDistinctBlocks();
        List<String> floors = classroomDAO.getDistinctFloors();
        List<String> departments = classroomDAO.getDistinctDepartments();

        request.setAttribute("classrooms", searchResults);
        request.setAttribute("blocks", blocks);
        request.setAttribute("floors", floors);
        request.setAttribute("departments", departments);

        // Preserve current filter values
        request.setAttribute("selectedRoom", roomNumber != null ? roomNumber : "");
        request.setAttribute("selectedBlock", block != null ? block : "ALL");
        request.setAttribute("selectedFloor", floor != null ? floor : "ALL");
        request.setAttribute("selectedDept", department != null ? department : "ALL");
        request.setAttribute("selectedType", roomType != null ? roomType : "ALL");
        request.setAttribute("isSearchAttempt", isSearchAttempt);

        request.getRequestDispatcher("/find-classroom.jsp").forward(request, response);
    }
}
