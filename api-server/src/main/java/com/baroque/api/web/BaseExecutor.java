package com.baroque.api.web;

/**
 * @author elric.wang
 */
public abstract class BaseExecutor implements ApiExecutor {

    protected int code;

    protected Object body;

    @Override
    public int getCode() {
        return code;
    }

    @Override
    public Object getBody() {
        return body;
    }
}
