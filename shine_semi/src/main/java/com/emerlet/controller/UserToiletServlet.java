package com.emerlet.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.action.UserToiletAddAction;
import com.emerlet.action.UserToiletAddOKAction;

/**
 * UserToiletServlet - Servlet that routes requests to appropriate Action
 * classes
 */
public class UserToiletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, Object> actionMap = new HashMap<>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserToiletServlet() {
		super();
		actionMap.put("/toiletAdd.do", new UserToiletAddAction());
		actionMap.put("/toiletAddOK.do", new UserToiletAddOKAction());
		System.out.println("UserToiletServlet initialized");
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Process both GET and POST requests
	 */
	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());

		String view = null;

		try {
			if (command.equals("/toiletAdd.do")) {
				UserToiletAddAction action = (UserToiletAddAction) actionMap.get(command);
				view = action.execute(request, response);
				System.out.println("View for toiletAdd.do: " + view);
			} else if (command.equals("/toiletAddOK.do")) {
				UserToiletAddOKAction action = (UserToiletAddOKAction) actionMap.get(command);
				view = action.execute(request, response);
				System.out.println("View for toiletAddOK.do: " + view);
			}

			if (view != null) {
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
		}
	}
}
