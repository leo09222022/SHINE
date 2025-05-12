package com.emerlet.controller;


import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.action.EmerletAction;






/**
 * Servlet implementation class DispatcherServelet
 */
@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HashMap<String, EmerletAction> map = new HashMap<String, EmerletAction>();
	


	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init 동작함");
		String path= config.getServletContext().getRealPath("WEB-INF");
		try {
			Reader reader = new FileReader(path + "/emerlet.properties");
			Properties prop = new Properties();
			prop.load(reader);
			Iterator iter = prop.keySet().iterator();
			while(iter.hasNext()) {
				String key= (String)iter.next();
				String clsName = prop.getProperty(key);
				Object obj = Class.forName(clsName).newInstance();
				map.put(key, (EmerletAction)obj);
			}
			
		}catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
		
	}


	/**
     * @see HttpServlet#HttpServlet()
     */
    public FrontController() {
        super();
        // TODO Auto-generated constructor stub
    }


    public void pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
       	String uri = request.getRequestURI();
    	String cmd = uri.substring(uri.lastIndexOf("/")+1);
    	EmerletAction action= map.get(cmd);
    	System.out.println(cmd+"==>"+action);
    	
    	String viewPage = action.pro(request, response);
    	
    	if(viewPage.endsWith(".do")) {
    		response.sendRedirect(viewPage);
    	}
    	else if(viewPage.endsWith(".jsp")) {
    		request.setAttribute("viewPage", viewPage);
    		RequestDispatcher dispatcher 
    		= request.getRequestDispatcher("index.jsp");
    		dispatcher.forward(request, response);
    	}else {
    		response.setContentType("application/json;charset=utf-8");
    		PrintWriter out = response.getWriter();
    		out.print(viewPage);
    		out.close();
    	}    	
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("프론트 컨트롤러의 doGet 동작함.");
		pro(request, response);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		pro(request, response);
	}


}




