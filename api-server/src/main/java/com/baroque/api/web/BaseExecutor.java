package com.baroque.api.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author elric.wang
 */
public abstract class BaseExecutor implements ApiExecutor, HttpContextAware {

    protected int code;

    protected Object body;

    protected String msg;

    protected HttpServletRequest request;

    protected HttpServletResponse response;

    @Override
    public int getCode() {
        return code;
    }

    @Override
    public Object getBody() {
        return body;
    }

    @Override
    public String getMsg() {
        return msg;
    }

    @Override
    public void setHttpServletRequest(HttpServletRequest request) {
        this.request = request;
    }

    @Override
    public void setHttpServletResponse(HttpServletResponse response) {
        this.response = response;
    }
}
