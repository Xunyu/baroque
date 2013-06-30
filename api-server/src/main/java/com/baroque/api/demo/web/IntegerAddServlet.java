package com.baroque.api.demo.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author wenjing.wang
 *
 */
public class IntegerAddServlet extends HttpServlet {

	private static final long serialVersionUID = 459281695515737085L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int a = Integer.parseInt(req.getParameter("a"));
		int b = Integer.parseInt(req.getParameter("b"));
		PrintWriter writer = resp.getWriter();
		writer.printf("%d", a + b);
		writer.flush();
	}
}