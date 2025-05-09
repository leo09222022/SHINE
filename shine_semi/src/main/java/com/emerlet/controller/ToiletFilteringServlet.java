package com.emerlet.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emerlet.dao.ToiletDAO;
import com.emerlet.vo.ToiletVO;

/**
 * Servlet implementation class ToiletFilteringServlet
 */
@WebServlet("/ToiletFilteringServlet")
public class ToiletFilteringServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ToiletFilteringServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    try {
	        String hasMaleToilet = request.getParameter("hasMaleToilet");
	        String hasFemaleToilet = request.getParameter("hasFemaleToilet");
	        String hasMaleDisabledToilet = request.getParameter("hasMaleDisabledToilet");
	        String hasFemaleDisabledToilet = request.getParameter("hasFemaleDisabledToilet");
	        String hasDiaperTable = request.getParameter("hasDiaperTable");
	        String resetFilters = request.getParameter("resetFilters");
	        String viewMap = request.getParameter("viewMap");

	        HttpSession session = request.getSession();

	        if ("true".equals(resetFilters)) {
	            session.removeAttribute("filteredToilets");
	            session.removeAttribute("hasMaleToilet");
	            session.removeAttribute("hasFemaleToilet");
	            session.removeAttribute("hasMaleDisabledToilet");
	            session.removeAttribute("hasFemaleDisabledToilet");
	            session.removeAttribute("hasDiaperTable");
	            session.setAttribute("isFiltered", false);

	            response.sendRedirect("map");
	            return;
	        }

	        boolean hasFilterConditions = "Y".equals(hasMaleToilet)
	                || "Y".equals(hasFemaleToilet)
	                || "Y".equals(hasMaleDisabledToilet)
	                || "Y".equals(hasFemaleDisabledToilet)
	                || "Y".equals(hasDiaperTable);

	        if ("true".equals(viewMap) && !hasFilterConditions) {
	            session.removeAttribute("filteredToilets");
	            session.removeAttribute("hasMaleToilet");
	            session.removeAttribute("hasFemaleToilet");
	            session.removeAttribute("hasMaleDisabledToilet");
	            session.removeAttribute("hasFemaleDisabledToilet");
	            session.removeAttribute("hasDiaperTable");
	            session.setAttribute("isFiltered", false);

	            response.sendRedirect("map");
	            return;
	        }

	        if (hasFilterConditions) {

	            ToiletDAO toiletDAO = new ToiletDAO();
	            ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
	            ArrayList<ToiletVO> filteredToilets = new ArrayList<>();

	            for (ToiletVO toilet : allToilets) {
	                boolean include = true;

	                if ("Y".equals(hasMaleToilet) && toilet.getMaleToilet() < 1) {
	                    include = false;
	                }

	                if (include && "Y".equals(hasFemaleToilet) && toilet.getFemaleToilet() < 1) {
	                    include = false;
	                }

	                if (include && "Y".equals(hasMaleDisabledToilet) && toilet.getMaleDisabledToilet() < 1) {
	                    include = false;
	                }

	                if (include && "Y".equals(hasFemaleDisabledToilet) && toilet.getFemaleDisabledToilet() < 1) {
	                    include = false;
	                }

	                if (include && "Y".equals(hasDiaperTable) && toilet.getHasDiaperTable() != 1) {
	                    include = false;
	                }

	                if (include) {
	                    filteredToilets.add(toilet);
	                }
	            }

	            session.setAttribute("filteredToilets", filteredToilets);
	            session.setAttribute("hasMaleToilet", hasMaleToilet);
	            session.setAttribute("hasFemaleToilet", hasFemaleToilet);
	            session.setAttribute("hasMaleDisabledToilet", hasMaleDisabledToilet);
	            session.setAttribute("hasFemaleDisabledToilet", hasFemaleDisabledToilet);
	            session.setAttribute("hasDiaperTable", hasDiaperTable);
	            session.setAttribute("isFiltered", true);

	            if ("true".equals(viewMap)) {
	                response.sendRedirect("map");
	                return;
	            }

	            request.setAttribute("toilets", filteredToilets);
	            request.setAttribute("hasMaleToilet", hasMaleToilet);
	            request.setAttribute("hasFemaleToilet", hasFemaleToilet);
	            request.setAttribute("hasMaleDisabledToilet", hasMaleDisabledToilet);
	            request.setAttribute("hasFemaleDisabledToilet", hasFemaleDisabledToilet);
	            request.setAttribute("hasDiaperTable", hasDiaperTable);
	        } else {

	            if (session.getAttribute("filteredToilets") != null) {
	                ArrayList<ToiletVO> previousFiltered = (ArrayList<ToiletVO>) session
	                        .getAttribute("filteredToilets");
	                request.setAttribute("toilets", previousFiltered);
	                request.setAttribute("hasMaleToilet", session.getAttribute("hasMaleToilet"));
	                request.setAttribute("hasFemaleToilet", session.getAttribute("hasFemaleToilet"));
	                request.setAttribute("hasMaleDisabledToilet", session.getAttribute("hasMaleDisabledToilet"));
	                request.setAttribute("hasFemaleDisabledToilet", session.getAttribute("hasFemaleDisabledToilet"));
	                request.setAttribute("hasDiaperTable", session.getAttribute("hasDiaperTable"));
	            } else {
	                ToiletDAO toiletDAO = new ToiletDAO();
	                ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
	                request.setAttribute("toilets", allToilets);
	            }
	        }

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/toiletFiltering.jsp");
	        dispatcher.forward(request, response);

	    } catch (Exception e) {
	        System.out.println("예외 발생: " + e.getMessage());
	        e.printStackTrace();
	        response.sendRedirect("map");
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}