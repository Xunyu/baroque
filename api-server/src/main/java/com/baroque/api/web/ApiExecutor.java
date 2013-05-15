package com.baroque.api.web;

/**
 * @author elric.wang
 */
public interface ApiExecutor {
    public void execute();

    public int getCode();

    public Object getBody();

    public String getMsg();
}
