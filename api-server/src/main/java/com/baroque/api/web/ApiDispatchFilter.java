package com.baroque.api.web;

import com.baroque.api.web.api.MenuListApi;
import org.json.JSONArray;
import org.json.JSONObject;

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
public class ApiDispatchFilter implements Filter {

    private Map<String, Class> executorMap = new HashMap<String, Class>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        executorMap.put("/menu/list", MenuListApi.class);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest htRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse htResponse = (HttpServletResponse) servletResponse;
        String uri = htRequest.getRequestURI();
        ApiExecutor executor = null;
        try {
            Class executorClass = executorMap.get(uri);
            if (executorClass != null) {
                executor = (ApiExecutor) executorClass.newInstance();
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
        executor.execute();
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", executor.getCode());
        Object body = executor.getBody();
        if (body instanceof Collection) {
            Collection<JSONObject> jsonColl = new ArrayList<JSONObject>();
            for (Object o : (Collection) body) {
                jsonColl.add(new JSONObject(o));
            }
            result.put("body", new JSONArray(jsonColl));
        } else {
            result.put("body", new JSONObject(body));
        }
        PrintWriter writer = htResponse.getWriter();
        writer.println(new JSONObject(result).toString());
    }

    @Override
    public void destroy() {
    }
}
