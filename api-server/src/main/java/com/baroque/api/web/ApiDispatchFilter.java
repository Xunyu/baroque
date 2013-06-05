package com.baroque.api.web;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * @author elric.wang
 */
public class ApiDispatchFilter implements Filter, ApplicationContextAware {

    private Map<String, String> executorMap = new HashMap<String, String>();

    private ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    public void setExecutorMap(Map<String, String> executorMap) {
        this.executorMap = executorMap;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest htRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse htResponse = (HttpServletResponse) servletResponse;
        String uri = htRequest.getRequestURI();
        ApiExecutor executor = null;
        try {
            String  executorName = executorMap.get(uri);
            if (executorName != null) {
                executor = (ApiExecutor) applicationContext.getBean(executorName);
            }
        } catch (Exception e) {
        }

        if (executor == null) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        if (executor instanceof HttpContextAware) {
            HttpContextAware executorAlias = (HttpContextAware) executor;
            executorAlias.setHttpServletRequest(htRequest);
            executorAlias.setHttpServletResponse(htResponse);
        }
        try {
            executor.execute();
        } catch (Exception e) {
            // TODO:response 500
            throw new ServletException(e.getMessage(), e);
        }
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", executor.getCode());
        Object body = executor.getBody();
        if (body != null) {
            if (body instanceof Collection) {
                Collection<JSONObject> jsonColl = new ArrayList<JSONObject>();
                for (Object o : (Collection) body) {
                    jsonColl.add(new JSONObject(o));
                }
                result.put("body", new JSONArray(jsonColl));
            } else if (body instanceof Map) {
                result.put("body", new JSONObject((Map) body));
            } else {
                result.put("body", new JSONObject(body));
            }
        }
        String msg = executor.getMsg();
        if (msg != null) {
            result.put("msg", msg);
        }
        htResponse.setContentType("text/plain;charset=UTF-8");
        PrintWriter writer = htResponse.getWriter();
        writer.println(new JSONObject(result).toString());
    }

    @Override
    public void destroy() {
    }
}
