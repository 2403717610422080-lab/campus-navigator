package com.campusnavigator.controller;

import com.campusnavigator.dao.ClassroomDAO;
import com.campusnavigator.dao.RouteDAO;
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
 * Controller providing step-by-step navigation directions between campus points.
 */
@WebServlet(name = "RouteServlet", urlPatterns = {"/get-directions"})
public class RouteServlet extends HttpServlet {

    private RouteDAO routeDAO;
    private ClassroomDAO classroomDAO;

    @Override
    public void init() {
        routeDAO = new RouteDAO();
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");

        if (source == null || source.trim().isEmpty()) {
            source = "Main Gate";
        }

        Route matchedRoute = null;

        if (destination != null && !destination.trim().isEmpty()) {
            // First check pre-computed routes
            matchedRoute = routeDAO.findRoute(source, destination);

            // If not found in static routes table, check if destination is a classroom
            if (matchedRoute == null) {
                Classroom c = classroomDAO.getClassroomByRoomNumber(destination.trim());
                if (c == null) {
                    // Try searching by room name or ID
                    List<Classroom> list = classroomDAO.searchClassrooms(destination.trim(), null, null, null, null);
                    if (!list.isEmpty()) {
                        c = list.get(0);
                    }
                }

                if (c != null) {
                    matchedRoute = new Route();
                    matchedRoute.setSource(source);
                    matchedRoute.setDestination(c.getBlock() + " - " + c.getRoomNumber() + " (" + c.getRoomName() + ")");
                    matchedRoute.setEstimatedTime("2-3 mins");
                    matchedRoute.setRouteDescription("Navigate from " + source + " to " + c.getBlock() + " on " + c.getFloor() + ".");
                    matchedRoute.setSteps(c.getNavigationPath() != null ? c.getNavigationPath() : source + " → " + c.getBlock() + " → " + c.getFloor() + " → " + c.getRoomNumber());
                }
            }
        }

        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        request.setAttribute("matchedRoute", matchedRoute);

        request.getRequestDispatcher("/campus-map.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
