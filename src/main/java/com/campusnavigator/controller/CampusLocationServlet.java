package com.campusnavigator.controller;

import com.campusnavigator.dao.CampusLocationDAO;
import com.campusnavigator.dao.ClassroomDAO;
import com.campusnavigator.dao.RouteDAO;
import com.campusnavigator.model.CampusLocation;
import com.campusnavigator.model.Classroom;
import com.campusnavigator.model.Route;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller providing the interactive Campus Map, block explorer, and pathway guide.
 */
@WebServlet(name = "CampusLocationServlet", urlPatterns = {"/campus-map"})
public class CampusLocationServlet extends HttpServlet {

    private CampusLocationDAO locationDAO;
    private ClassroomDAO classroomDAO;
    private RouteDAO routeDAO;

    @Override
    public void init() {
        locationDAO = new CampusLocationDAO();
        classroomDAO = new ClassroomDAO();
        routeDAO = new RouteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CampusLocation> locations = locationDAO.getAllLocations();
        List<Classroom> allClassrooms = classroomDAO.getAllClassrooms();
        List<Route> routes = routeDAO.getAllRoutes();

        String selectedBlock = request.getParameter("block");
        if (selectedBlock != null && !selectedBlock.trim().isEmpty()) {
            List<Classroom> blockRooms = classroomDAO.searchClassrooms(null, selectedBlock.trim(), null, null, null);
            request.setAttribute("selectedBlock", selectedBlock.trim());
            request.setAttribute("blockRooms", blockRooms);
        }

        request.setAttribute("locations", locations);
        request.setAttribute("allClassrooms", allClassrooms);
        request.setAttribute("routes", routes);

        request.getRequestDispatcher("/campus-map.jsp").forward(request, response);
    }
}
