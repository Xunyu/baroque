package com.baroque.api.demo.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.baroque.api.demo.dao.UserDao;
import com.baroque.api.demo.entity.UserEntity;

/**
 * @author elric.wang
 * 
 */
public class RegisterServlet extends HttpServlet {

	private String phoneNo;

	private String nickName;

	private UserDao userDao = new UserDao();

	private static final long serialVersionUID = 2211490921126629693L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		phoneNo = req.getParameter("phoneNo").trim();
		nickName = req.getParameter("nickName").trim();
		if (StringUtils.isEmpty(phoneNo) || !StringUtils.isNumeric(phoneNo)) {
			respone(resp, "{\"code\":500,\"msg\":\"increct phone number.\"}");
			return;
		}
		Integer userId = userDao.getUserIdByPhoneNo(phoneNo);
		if (userId != null) {
			respone(resp, "{\"code\":500,\"msg\":\"user already exists.\"}");
			return;
		}
		UserEntity user = new UserEntity();
		user.setPhoneNo(phoneNo);
		user.setNickName(nickName);
		userId = userDao.addUser(user);
		respone(resp, "{\"code\":200,\"msg\":\"add user successfully.\",\"userId\":" + userId + "}");
	}

	private void respone(HttpServletResponse resp, String string) throws IOException {
		PrintWriter writer = resp.getWriter();
		writer.print(string);
		writer.flush();
		writer.close();
	}
}
