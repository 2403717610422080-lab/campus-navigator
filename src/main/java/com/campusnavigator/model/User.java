package com.campusnavigator.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * User entity representing Students, Staff, and Administrators.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String studentId;
    private String email;
    private String department;
    private String year;
    private String username;
    private String password;
    private String role; // STUDENT, STAFF, ADMIN
    private Timestamp createdAt;

    public User() {
    }

    public User(int id, String name, String studentId, String email, String department, String year, String username, String password, String role, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.studentId = studentId;
        this.email = email;
        this.department = department;
        this.year = year;
        this.username = username;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
    }

    public User(String name, String studentId, String email, String department, String year, String username, String password, String role) {
        this.name = name;
        this.studentId = studentId;
        this.email = email;
        this.department = department;
        this.year = year;
        this.username = username;
        this.password = password;
        this.role = role != null ? role : "STUDENT";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.role);
    }

    public boolean isStaff() {
        return "STAFF".equalsIgnoreCase(this.role);
    }

    public boolean isStudent() {
        return "STUDENT".equalsIgnoreCase(this.role);
    }
}
