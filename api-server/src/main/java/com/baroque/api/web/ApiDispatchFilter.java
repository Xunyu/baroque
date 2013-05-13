package com.baroque.api.web;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * @author elric.wang
 */
public class ApiDispatchFilter implements Filter {

    private Map<String, ApiExecutor> executorMap = new HashMap<String, ApiExecutor>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        executorMap.put("/menu/list", null);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest htRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse htResponse = (HttpServletResponse) servletResponse;
        String uri = htRequest.getRequestURI();
        ApiExecutor executor = executorMap.get(uri);
        if (executor == null) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        executor.execute();
        PrintWriter writer = htResponse.getWriter();
        writer.println();
    }

    @Override
    public void destroy() {
    }
}
