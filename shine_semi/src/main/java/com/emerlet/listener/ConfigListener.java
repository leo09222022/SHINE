// 경로: src/com/kosta/listener/ConfigListener.java
package com.emerlet.listener;

import javax.servlet.*;
import java.io.InputStream;
import java.util.Properties;

public class ConfigListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        try (InputStream input = context.getResourceAsStream("/WEB-INF/shine.properties")) {
            Properties prop = new Properties();
            prop.load(input);
            String apiKey = prop.getProperty("google_map_api");
            context.setAttribute("google_map_api", apiKey);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do here
    }
}
