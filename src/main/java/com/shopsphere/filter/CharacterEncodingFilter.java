package com.shopsphere.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Ensures UTF-8 character encoding across all incoming HTTP requests and responses.
 * Also attaches essential HTTP security response headers.
 */
@WebFilter(filterName = "CharacterEncodingFilter", urlPatterns = {"/*"})
public class CharacterEncodingFilter implements Filter {

    private static final String ENCODING = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[CharacterEncodingFilter] Initialized with encoding: " + ENCODING);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Force UTF-8 request encoding
        request.setCharacterEncoding(ENCODING);

        // Force UTF-8 response encoding
        response.setCharacterEncoding(ENCODING);

        // Security headers
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            httpResponse.setHeader("X-Content-Type-Options", "nosniff");
            httpResponse.setHeader("X-Frame-Options", "SAMEORIGIN");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("[CharacterEncodingFilter] Destroyed.");
    }
}
