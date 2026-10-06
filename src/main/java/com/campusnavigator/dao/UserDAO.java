package com.campusnavigator.dao;

import com.campusnavigator.model.User;
import com.campusnavigator.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User entity handling authentication, registration, and profile lookups.
 */
public class UserDAO {

    /**
     * Authenticates a user by username or email and password against the MySQL database.
     */
    public User authenticate(String usernameOrEmail, String password) {
        if (usernameOrEmail == null || password == null) {
            return null;
        }

        String inputIdentifier = usernameOrEmail.trim();
        String inputPassword = password.trim();

        String sql = "SELECT id, name, student_id, email, department, year, username, password, role, created_at " +
                     "FROM users WHERE (LOWER(username) = LOWER(?) OR LOWER(email) = LOWER(?)) AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inputIdentifier);
            ps.setString(2, inputIdentifier);
            ps.setString(3, inputPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.authenticate database error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Registers a new student or staff account.
     */
    public boolean register(User user) {
        String sql = "INSERT INTO users (name, student_id, email, department, year, username, password, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getStudentId());
            ps.setString(3, user.getEmail().trim().toLowerCase());
            ps.setString(4, user.getDepartment() != null ? user.getDepartment() : "Computer Science");
            ps.setString(5, user.getYear() != null ? user.getYear() : "1st Year");
            ps.setString(6, user.getUsername().trim());
            ps.setString(7, user.getPassword());
            ps.setString(8, user.getRole() != null ? user.getRole() : "STUDENT");

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.register error: " + e.getMessage());
        }
        return false;
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username != null ? username.trim() : "");
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.usernameExists error: " + e.getMessage());
        }
        return false;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email != null ? email.trim().toLowerCase() : "");
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.emailExists error: " + e.getMessage());
        }
        return false;
    }

    public User getUserById(int id) {
        String sql = "SELECT id, name, student_id, email, department, year, username, password, role, created_at FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.getUserById error: " + e.getMessage());
        }
        return null;
    }

    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET name = ?, department = ?, year = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getDepartment());
            ps.setString(3, user.getYear());
            ps.setInt(4, user.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("UserDAO.updateProfile error: " + e.getMessage());
        }
        return false;
    }

    public int countUsersByRole(String role) {
        String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.countUsersByRole error: " + e.getMessage());
        }
        return 0;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id, name, student_id, email, department, year, username, password, role, created_at FROM users ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.getAllUsers error: " + e.getMessage());
        }
        return list;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setStudentId(rs.getString("student_id"));
        u.setEmail(rs.getString("email"));
        u.setDepartment(rs.getString("department"));
        u.setYear(rs.getString("year"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
}
