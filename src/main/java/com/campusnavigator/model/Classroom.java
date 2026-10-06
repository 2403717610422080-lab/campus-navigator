package com.campusnavigator.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Classroom entity representing classrooms, laboratories, seminar halls, auditoriums, and faculty rooms.
 */
public class Classroom implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String roomNumber;
    private String roomName;
    private String block;
    private String floor;
    private String department;
    private String roomType; // Classroom, Laboratory, Seminar Hall, Auditorium, Faculty Room, Office
    private int capacity;
    private String facilities;
    private String description;
    private String navigationPath;
    private Timestamp createdAt;

    public Classroom() {
    }

    public Classroom(int id, String roomNumber, String roomName, String block, String floor, String department, String roomType, int capacity, String facilities, String description, String navigationPath, Timestamp createdAt) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.roomName = roomName;
        this.block = block;
        this.floor = floor;
        this.department = department;
        this.roomType = roomType;
        this.capacity = capacity;
        this.facilities = facilities;
        this.description = description;
        this.navigationPath = navigationPath;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getBlock() {
        return block;
    }

    public void setBlock(String block) {
        this.block = block;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getFacilities() {
        return facilities;
    }

    public void setFacilities(String facilities) {
        this.facilities = facilities;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNavigationPath() {
        return navigationPath;
    }

    public void setNavigationPath(String navigationPath) {
        this.navigationPath = navigationPath;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Splits comma-separated facilities into a clean list for badges in UI.
     */
    public List<String> getFacilitiesList() {
        List<String> list = new ArrayList<>();
        if (facilities != null && !facilities.trim().isEmpty()) {
            for (String f : facilities.split(",")) {
                if (!f.trim().isEmpty()) {
                    list.add(f.trim());
                }
            }
        }
        return list;
    }

    /**
     * Splits navigation path by arrow delimiters ("→" or "->") into steps.
     */
    public List<String> getNavigationSteps() {
        List<String> steps = new ArrayList<>();
        if (navigationPath != null && !navigationPath.trim().isEmpty()) {
            String[] parts = navigationPath.split("→|->|\\\\n");
            for (String p : parts) {
                if (!p.trim().isEmpty()) {
                    steps.add(p.trim());
                }
            }
        }
        return steps;
    }

    public String getTypeBadgeClass() {
        if ("Laboratory".equalsIgnoreCase(roomType)) return "badge-lab";
        if ("Auditorium".equalsIgnoreCase(roomType)) return "badge-auditorium";
        if ("Seminar Hall".equalsIgnoreCase(roomType)) return "badge-seminar";
        if ("Faculty Room".equalsIgnoreCase(roomType)) return "badge-faculty";
        if ("Office".equalsIgnoreCase(roomType)) return "badge-office";
        return "badge-classroom";
    }
}
