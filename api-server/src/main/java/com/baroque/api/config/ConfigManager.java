package com.baroque.api.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.ServletContext;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.util.Assert;
import org.springframework.util.ResourceUtils;

/**
 * @author wenjing.wang
 *
 */
public class ConfigManager {

	private static final String APP_CONFIG_LOCATION = "appConfigLocation";

	private static final Map<String, String> configCache = new HashMap<String, String>();

	public static void init(ServletContext servletContext) {
		String location = servletContext.getInitParameter(APP_CONFIG_LOCATION);
		Assert.notNull(location, "Config location must not be null.");
		try {
			File file = ResourceUtils.getFile(location);
			if (!file.exists()) {
				throw new FileNotFoundException("Config file [" + location + "] not found.");
			}
			loadConfig(file);
		} catch (IOException e) {
			throw new IllegalArgumentException("Could not load appConfi from [" + location + "].", e);
		}
	}

	private static void loadConfig(File file) throws FileNotFoundException, IOException {
		Properties properties = new Properties();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			properties.load(fis);
			Set<Object> keys = properties.keySet();
			if (CollectionUtils.isEmpty(keys)) {
				return;
			}
			for (Object key : keys) {
				String keyStr = (String) key;
				configCache.put(keyStr, properties.getProperty(keyStr));
			}
		} catch (Exception e) {
			throw new IOException(e);
		} finally {
			IOUtils.closeQuietly(fis);
		}
	}

	public static String getProperty(String key) {
		return get(key, null);
	}

	public static String get(String key, String defaultValue) {
		if (configCache.containsKey(key)) {
			return configCache.get(key);
		} else {
			return defaultValue;
		}
	}
}
