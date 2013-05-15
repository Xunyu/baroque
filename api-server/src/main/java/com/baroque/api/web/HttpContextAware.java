package com.baroque.api.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author elric.wang
 */
public interface HttpContextAware {

    public void setHttpServletRequest(HttpServletRequest request);

    public void setHttpServletResponse(HttpServletResponse response);
}
