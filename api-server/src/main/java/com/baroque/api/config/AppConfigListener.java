package com.baroque.api.config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author wenjing.wang
 * 
 */
public class AppConfigListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ConfigManager.init(sce.getServletContext());
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}

}
