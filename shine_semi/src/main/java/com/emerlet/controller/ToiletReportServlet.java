package com.emerlet.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ToiletDAO;
import com.emerlet.dao.ToiletReportsDAO;
import com.emerlet.vo.ToiletVO;

/**
 * Servlet implementation class ToiletReportServlet
 */
@WebServlet("/toiletReport.do")
public class ToiletReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ToiletReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 파라미터 받아오기
		String toiletIdParam = request.getParameter("toilet_id");
		String userToiletIdParam = request.getParameter("user_toilet_id");

		Integer toiletId = null;
		Integer userToiletId = null;

		if (toiletIdParam != null && !toiletIdParam.isEmpty()) {
			toiletId = Integer.parseInt(toiletIdParam);
		}
		if (userToiletIdParam != null && !userToiletIdParam.isEmpty()) {
			userToiletId = Integer.parseInt(userToiletIdParam);
		}

		// DAO 호출
		ToiletReportsDAO dao = new ToiletReportsDAO();
		ToiletVO toilet = dao.findById(toiletId, userToiletId); // DAO 메서드는 VO 리턴하게 수정해야 함

		request.setAttribute("toilet", toilet);
		RequestDispatcher dispatcher = request.getRequestDispatcher("toiletReport.jsp");
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
