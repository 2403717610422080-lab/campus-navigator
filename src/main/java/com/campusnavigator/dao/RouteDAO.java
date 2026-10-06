package com.campusnavigator.dao;

import com.campusnavigator.model.Route;
import com.campusnavigator.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for pre-computed campus pathways and route directions.
 */
public class RouteDAO {

    public List<Route> getAllRoutes() {
        List<Route> list = new ArrayList<>();
        String sql = "SELECT id, source, destination, route_description, estimated_time, steps, created_at FROM routes ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToRoute(rs));
            }
        } catch (SQLException e) {
            System.err.println("RouteDAO.getAllRoutes error: " + e.getMessage());
        }
        return list;
    }

    public Route findRoute(String source, String destination) {
        String sql = "SELECT id, source, destination, route_description, estimated_time, steps, created_at FROM routes " +
                     "WHERE (source LIKE ? AND destination LIKE ?) LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (source != null ? source.trim() : "") + "%");
            ps.setString(2, "%" + (destination != null ? destination.trim() : "") + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRoute(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("RouteDAO.findRoute error: " + e.getMessage());
        }
        return null;
    }

    private Route mapResultSetToRoute(ResultSet rs) throws SQLException {
        Route r = new Route();
        r.setId(rs.getInt("id"));
        r.setSource(rs.getString("source"));
        r.setDestination(rs.getString("destination"));
        r.setRouteDescription(rs.getString("route_description"));
        r.setEstimatedTime(rs.getString("estimated_time"));
        r.setSteps(rs.getString("steps"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}
