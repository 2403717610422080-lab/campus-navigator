package com.campusnavigator.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Route entity representing predefined point-to-point pathways across the campus.
 */
public class Route implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String source;
    private String destination;
    private String routeDescription;
    private String estimatedTime;
    private String steps;
    private Timestamp createdAt;

    public Route() {
    }

    public Route(int id, String source, String destination, String routeDescription, String estimatedTime, String steps, Timestamp createdAt) {
        this.id = id;
        this.source = source;
        this.destination = destination;
        this.routeDescription = routeDescription;
        this.estimatedTime = estimatedTime;
        this.steps = steps;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getRouteDescription() {
        return routeDescription;
    }

    public void setRouteDescription(String routeDescription) {
        this.routeDescription = routeDescription;
    }

    public String getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(String estimatedTime) {
        this.estimatedTime = estimatedTime;
    }

    public String getSteps() {
        return steps;
    }

    public void setSteps(String steps) {
        this.steps = steps;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<String> getStepsList() {
        List<String> list = new ArrayList<>();
        if (steps != null && !steps.trim().isEmpty()) {
            for (String step : steps.split("\n|\\\\n")) {
                if (!step.trim().isEmpty()) {
                    list.add(step.trim());
                }
            }
        }
        return list;
    }
}
