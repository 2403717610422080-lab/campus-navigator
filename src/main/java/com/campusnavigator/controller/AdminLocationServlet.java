package com.campusnavigator.controller;

import com.campusnavigator.dao.CampusLocationDAO;
import com.campusnavigator.model.CampusLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller handling Admin CRUD operations for Campus Locations and Landmarks.
 */
@WebServlet(name = "AdminLocationServlet", urlPatterns = {"/admin/locations", "/admin/add-location", "/admin/edit-location", "/admin/delete-location"})
public class AdminLocationServlet extends HttpServlet {

    private CampusLocationDAO locationDAO;

    @Override
    public void init() {
        locationDAO = new CampusLocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if ("/admin/delete-location".equals(servletPath)) {
            handleDelete(request, response);
            return;
        }

        List<CampusLocation> list = locationDAO.getAllLocations();
        request.setAttribute("locations", list);
        request.getRequestDispatcher("/admin/manage-locations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        String locationName = request.getParameter("locationName");
        String locationType = request.getParameter("locationType");
        String block = request.getParameter("block");
        String floor = request.getParameter("floor");
        String description = request.getParameter("description");
        String keyFeatures = request.getParameter("keyFeatures");

        if ("/admin/add-location".equals(servletPath)) {
            CampusLocation loc = new CampusLocation(0, locationName, locationType, block, floor, description, keyFeatures, null);
            boolean success = locationDAO.addLocation(loc);

            if (success) {
                request.getSession().setAttribute("successMessage", "Campus location '" + locationName + "' added successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add location.");
            }
        } else if ("/admin/edit-location".equals(servletPath)) {
            String idStr = request.getParameter("id");
            try {
                int id = Integer.parseInt(idStr);
                CampusLocation loc = new CampusLocation(id, locationName, locationType, block, floor, description, keyFeatures, null);
                boolean success = locationDAO.updateLocation(loc);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Campus location updated successfully.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to update location.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Invalid location ID.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/locations");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            boolean success = locationDAO.deleteLocation(id);
            if (success) {
                request.getSession().setAttribute("successMessage", "Location deleted successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete location.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Invalid ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/locations");
    }
}
