package com.baroque.api.web;

import com.baroque.api.config.ConfigManager;
import com.baroque.api.config.Env;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author elric.wang
 */
public abstract class BaseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        if (ConfigManager.getEnv() == Env.DEV) {
//            doPost(req, resp);
//        } else {
//            throw new ServletException("Get not supported.");
//        }
        doPost(req, resp);
    }
}
