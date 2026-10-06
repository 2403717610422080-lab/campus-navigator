package com.campusnavigator.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * CampusLocation entity representing campus blocks, facilities, amenities, and main landmarks.
 */
public class CampusLocation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String locationName;
    private String locationType; // Academic Block, Facility, Administrative, Recreation, Entrance
    private String block;
    private String floor;
    private String description;
    private String keyFeatures;
    private Timestamp createdAt;

    public CampusLocation() {
    }

    public CampusLocation(int id, String locationName, String locationType, String block, String floor, String description, String keyFeatures, Timestamp createdAt) {
        this.id = id;
        this.locationName = locationName;
        this.locationType = locationType;
        this.block = block;
        this.floor = floor;
        this.description = description;
        this.keyFeatures = keyFeatures;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getLocationType() {
        return locationType;
    }

    public void setLocationType(String locationType) {
        this.locationType = locationType;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getKeyFeatures() {
        return keyFeatures;
    }

    public void setKeyFeatures(String keyFeatures) {
        this.keyFeatures = keyFeatures;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
