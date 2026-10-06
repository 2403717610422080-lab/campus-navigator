package com.campusnavigator.dao;

import com.campusnavigator.model.CampusLocation;
import com.campusnavigator.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Campus Locations and Blocks.
 */
public class CampusLocationDAO {

    public List<CampusLocation> getAllLocations() {
        List<CampusLocation> list = new ArrayList<>();
        String sql = "SELECT id, location_name, location_type, block, floor, description, key_features, created_at " +
                     "FROM campus_locations ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToLocation(rs));
            }
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.getAllLocations error: " + e.getMessage());
        }
        return list;
    }

    public CampusLocation getLocationById(int id) {
        String sql = "SELECT id, location_name, location_type, block, floor, description, key_features, created_at " +
                     "FROM campus_locations WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToLocation(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.getLocationById error: " + e.getMessage());
        }
        return null;
    }

    public boolean addLocation(CampusLocation loc) {
        String sql = "INSERT INTO campus_locations (location_name, location_type, block, floor, description, key_features) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, loc.getLocationName());
            ps.setString(2, loc.getLocationType());
            ps.setString(3, loc.getBlock());
            ps.setString(4, loc.getFloor());
            ps.setString(5, loc.getDescription());
            ps.setString(6, loc.getKeyFeatures());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        loc.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.addLocation error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateLocation(CampusLocation loc) {
        String sql = "UPDATE campus_locations SET location_name = ?, location_type = ?, block = ?, floor = ?, " +
                     "description = ?, key_features = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, loc.getLocationName());
            ps.setString(2, loc.getLocationType());
            ps.setString(3, loc.getBlock());
            ps.setString(4, loc.getFloor());
            ps.setString(5, loc.getDescription());
            ps.setString(6, loc.getKeyFeatures());
            ps.setInt(7, loc.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.updateLocation error: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteLocation(int id) {
        String sql = "DELETE FROM campus_locations WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.deleteLocation error: " + e.getMessage());
        }
        return false;
    }

    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM campus_locations";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("CampusLocationDAO.getTotalCount error: " + e.getMessage());
        }
        return 0;
    }

    private CampusLocation mapResultSetToLocation(ResultSet rs) throws SQLException {
        CampusLocation loc = new CampusLocation();
        loc.setId(rs.getInt("id"));
        loc.setLocationName(rs.getString("location_name"));
        loc.setLocationType(rs.getString("location_type"));
        loc.setBlock(rs.getString("block"));
        loc.setFloor(rs.getString("floor"));
        loc.setDescription(rs.getString("description"));
        loc.setKeyFeatures(rs.getString("key_features"));
        loc.setCreatedAt(rs.getTimestamp("created_at"));
        return loc;
    }
}
