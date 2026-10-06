package com.campusnavigator.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility for Campus Navigator.
 * Uses standard MySQL JDBC Driver with configurable environment variables and system properties.
 */
public class DBConnection {

    // Default Connection Parameters for Local Development
    private static final String DEFAULT_HOST = "localhost";
    private static final String DEFAULT_PORT = "3306";
    private static final String DEFAULT_DB = "campus_navigator";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "ilak_2007";

    private static String dbUrl;
    private static String dbUser;
    private static String dbPassword;

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String host = getEnvOrProperty("DB_HOST", DEFAULT_HOST);
            String port = getEnvOrProperty("DB_PORT", DEFAULT_PORT);
            String db = getEnvOrProperty("DB_NAME", getEnvOrProperty("DB_DATABASE", DEFAULT_DB));
            
            dbUser = getEnvOrProperty("DB_USER", getEnvOrProperty("DB_USERNAME", DEFAULT_USER));
            dbPassword = getEnvOrProperty("DB_PASSWORD", getEnvOrProperty("DB_PASS", DEFAULT_PASS));
            
            dbUrl = "jdbc:mysql://" + host + ":" + port + "/" + db +
                    "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver (com.mysql.cj.jdbc.Driver) not found in classpath: " + e.getMessage());
        }
    }

    private static String getEnvOrProperty(String key, String defaultValue) {
        String prop = System.getProperty(key);
        if (prop != null && !prop.trim().isEmpty()) {
            return prop.trim();
        }
        String env = System.getenv(key);
        if (env != null && !env.trim().isEmpty()) {
            return env.trim();
        }
        return defaultValue;
    }

    /**
     * Obtains a standard single JDBC database Connection.
     * 
     * @return active java.sql.Connection
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    public static String getDbUrl() {
        return dbUrl;
    }

    public static String getDbUser() {
        return dbUser;
    }
}
