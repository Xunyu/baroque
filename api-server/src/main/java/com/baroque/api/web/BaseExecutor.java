package com.baroque.api.web;

/**
 * @author elric.wang
 */
public abstract class BaseExecutor implements ApiExecutor {

    protected int code;

    protected Object body;

    protected String msg;

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
}
