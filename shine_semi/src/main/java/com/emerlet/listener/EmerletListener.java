package com.emerlet.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.emerlet.db.Init;

/**
 * Application Lifecycle Listener implementation class EmerletListener
 *
 */
@WebListener
public class EmerletListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public EmerletListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	Init.init();
    	String csvPath = sce.getServletContext().getRealPath("공중화장실.csv");
    	Init.insertToiletDataFromCSV(csvPath);

    }
	
}
