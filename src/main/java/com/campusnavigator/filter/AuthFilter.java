package com.campusnavigator.filter;

import com.campusnavigator.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication and Role-Based Authorization Filter.
 * Protects application routes and prevents unauthenticated access.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/dashboard", "/find-classroom", "/classroom-details", "/campus-map", "/profile", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Prevent browser caching of sensitive authenticated pages
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        HttpSession session = httpRequest.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());

        // 1. Unauthenticated check
        if (currentUser == null) {
            httpRequest.getSession(true).setAttribute("errorMessage", "Please log in to access the Campus Navigator.");
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // 2. Admin authorization check
        if (path.startsWith("/admin") && !currentUser.isAdmin()) {
            httpRequest.getSession().setAttribute("errorMessage", "Access Denied: Administrator privileges required.");
            httpResponse.sendRedirect(contextPath + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
