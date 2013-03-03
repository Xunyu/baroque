package com.baroque.api.demo.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.mock.web.MockServletContext;

import com.baroque.api.config.ConfigManager;
import com.baroque.api.demo.entity.UserEntity;

/**
 * @author elric.wang
 * 
 */
public class UserDao {

	private String driverClassName;
	private String url;
	private String user;
	private String password;

	public UserDao() {
		init();
	}

	public void init() {
		driverClassName = ConfigManager.getProperty("db.master.driverClass");
		url = ConfigManager.getProperty("db.master.url");
		user = ConfigManager.getProperty("db.master.user");
		password = ConfigManager.getProperty("db.master.password");
		try {
			Class.forName(driverClassName);
		} catch (ClassNotFoundException e) {
		}
	}

	public Integer getUserIdByPhoneNo(String phoneNo) {
		Connection connect = null;
		try {
			connect = DriverManager.getConnection(url, user, password);
			String sql = "select UserID from user where PhoneNo = ?";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setString(1, phoneNo);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("UserID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeQuietly(connect);
		}
		return null;
	}

	public Integer addUser(UserEntity userEntity) {
		Connection connect = null;
		try {
			connect = DriverManager.getConnection(url, user, password);
			String sql = "insert into user (PhoneNo, NickName) values (?, ?)";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setString(1, userEntity.getPhoneNo());
			ps.setString(2, userEntity.getNickName());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeQuietly(connect);
		}
		return null;
	}

	private void closeQuietly(Connection connect) {
		if (connect == null) {
			return;
		}
		try {
			connect.close();
		} catch (SQLException e) {
		}
	}

	public static void main(String[] args) {
		MockServletContext servletContext = new MockServletContext();
		servletContext.addInitParameter("appConfigLocation", "classpath:config/appConfig.properties");
		ConfigManager.init(servletContext);
		UserDao userDao = new UserDao();
		String phoneNo = "000";
		String nickName = "elric";
		Integer userId = userDao.getUserIdByPhoneNo(phoneNo);
		if (userId == null) {
			UserEntity userEntity = new UserEntity();
			userEntity.setPhoneNo(phoneNo);
			userEntity.setNickName(nickName);
			System.out.println(userDao.addUser(userEntity));
		} else {
			System.out.println("user exists, id=" + userId);
		}
	}
}
