package com.campusnavigator.dao;

import com.campusnavigator.model.Classroom;
import com.campusnavigator.util.DBConnection;

import java.sql.*;
import java.util.*;

/**
 * Data Access Object for Classrooms and Laboratories.
 * Provides multi-criteria search, filters, and full CRUD operations.
 */
public class ClassroomDAO {

    /**
     * Retrieves all classrooms ordered by block and room number.
     */
    public List<Classroom> getAllClassrooms() {
        List<Classroom> list = new ArrayList<>();
        String sql = "SELECT id, room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path, created_at " +
                     "FROM classrooms ORDER BY block ASC, floor ASC, room_number ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToClassroom(rs));
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getAllClassrooms error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Multi-criteria search with dynamic SQL builder.
     */
    public List<Classroom> searchClassrooms(String roomNumber, String block, String floor, String department, String roomType) {
        List<Classroom> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT id, room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path, created_at " +
                "FROM classrooms WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (roomNumber != null && !roomNumber.trim().isEmpty()) {
            sql.append(" AND (room_number LIKE ? OR room_name LIKE ?) ");
            String term = "%" + roomNumber.trim() + "%";
            params.add(term);
            params.add(term);
        }
        if (block != null && !block.trim().isEmpty() && !"ALL".equalsIgnoreCase(block)) {
            sql.append(" AND block = ? ");
            params.add(block.trim());
        }
        if (floor != null && !floor.trim().isEmpty() && !"ALL".equalsIgnoreCase(floor)) {
            sql.append(" AND floor = ? ");
            params.add(floor.trim());
        }
        if (department != null && !department.trim().isEmpty() && !"ALL".equalsIgnoreCase(department)) {
            sql.append(" AND department = ? ");
            params.add(department.trim());
        }
        if (roomType != null && !roomType.trim().isEmpty() && !"ALL".equalsIgnoreCase(roomType)) {
            sql.append(" AND room_type = ? ");
            params.add(roomType.trim());
        }

        sql.append(" ORDER BY block ASC, floor ASC, room_number ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToClassroom(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.searchClassrooms error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Retrieves a single classroom by primary ID.
     */
    public Classroom getClassroomById(int id) {
        String sql = "SELECT id, room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path, created_at " +
                     "FROM classrooms WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClassroom(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getClassroomById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves a single classroom by unique room number (e.g. A204).
     */
    public Classroom getClassroomByRoomNumber(String roomNumber) {
        String sql = "SELECT id, room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path, created_at " +
                     "FROM classrooms WHERE room_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomNumber != null ? roomNumber.trim() : "");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClassroom(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getClassroomByRoomNumber error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Inserts a new classroom record.
     */
    public boolean addClassroom(Classroom c) {
        String sql = "INSERT INTO classrooms (room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getRoomNumber().trim());
            ps.setString(2, c.getRoomName().trim());
            ps.setString(3, c.getBlock());
            ps.setString(4, c.getFloor());
            ps.setString(5, c.getDepartment());
            ps.setString(6, c.getRoomType());
            ps.setInt(7, c.getCapacity());
            ps.setString(8, c.getFacilities());
            ps.setString(9, c.getDescription());
            ps.setString(10, c.getNavigationPath());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        c.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.addClassroom error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Updates an existing classroom record.
     */
    public boolean updateClassroom(Classroom c) {
        String sql = "UPDATE classrooms SET room_number = ?, room_name = ?, block = ?, floor = ?, department = ?, " +
                     "room_type = ?, capacity = ?, facilities = ?, description = ?, navigation_path = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getRoomNumber().trim());
            ps.setString(2, c.getRoomName().trim());
            ps.setString(3, c.getBlock());
            ps.setString(4, c.getFloor());
            ps.setString(5, c.getDepartment());
            ps.setString(6, c.getRoomType());
            ps.setInt(7, c.getCapacity());
            ps.setString(8, c.getFacilities());
            ps.setString(9, c.getDescription());
            ps.setString(10, c.getNavigationPath());
            ps.setInt(11, c.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.updateClassroom error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Deletes a classroom by ID.
     */
    public boolean deleteClassroom(int id) {
        String sql = "DELETE FROM classrooms WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.deleteClassroom error: " + e.getMessage());
        }
        return false;
    }

    public List<String> getDistinctBlocks() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT block FROM classrooms ORDER BY block ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("block"));
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getDistinctBlocks error: " + e.getMessage());
        }
        return list;
    }

    public List<String> getDistinctDepartments() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT department FROM classrooms ORDER BY department ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("department"));
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getDistinctDepartments error: " + e.getMessage());
        }
        return list;
    }

    public List<String> getDistinctFloors() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT floor FROM classrooms ORDER BY floor ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("floor"));
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getDistinctFloors error: " + e.getMessage());
        }
        return list;
    }

    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM classrooms";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.getTotalCount error: " + e.getMessage());
        }
        return 0;
    }

    public int countByType(String type) {
        String sql = "SELECT COUNT(*) FROM classrooms WHERE room_type = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("ClassroomDAO.countByType error: " + e.getMessage());
        }
        return 0;
    }

    private Classroom mapResultSetToClassroom(ResultSet rs) throws SQLException {
        Classroom c = new Classroom();
        c.setId(rs.getInt("id"));
        c.setRoomNumber(rs.getString("room_number"));
        c.setRoomName(rs.getString("room_name"));
        c.setBlock(rs.getString("block"));
        c.setFloor(rs.getString("floor"));
        c.setDepartment(rs.getString("department"));
        c.setRoomType(rs.getString("room_type"));
        c.setCapacity(rs.getInt("capacity"));
        c.setFacilities(rs.getString("facilities"));
        c.setDescription(rs.getString("description"));
        c.setNavigationPath(rs.getString("navigation_path"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}
