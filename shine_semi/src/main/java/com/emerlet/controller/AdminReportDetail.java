package com.emerlet.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ReportsToiletDAO;
import com.emerlet.dao.UserToiletDAO;
import com.emerlet.vo.ReportsToiletVO;
import com.emerlet.vo.UserToiletVO;

/**
 * Servlet implementation class AdminReportDetail
 */
@WebServlet("/AdminReportDetail")
public class AdminReportDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReportDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(request.getParameter("id"));
		int toilet_id = Integer.parseInt(request.getParameter("toilet_id"));
		ReportsToiletDAO dao1 = new ReportsToiletDAO();
		UserToiletDAO dao2 = new UserToiletDAO();
		
		ReportsToiletVO vo1 = dao1.findById(id);
		request.setAttribute("vo1", vo1);
		
		UserToiletVO vo2 = dao2.findByID(toilet_id);
		request.setAttribute("vo2", vo2);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin_report_detail.jsp");
	    dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
