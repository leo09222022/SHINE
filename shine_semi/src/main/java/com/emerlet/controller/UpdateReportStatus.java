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
 * Servlet implementation class UpdateStatus
 */
@WebServlet("/UpdateReportStatus")
public class UpdateReportStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateReportStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		int toilet_id = Integer.parseInt(request.getParameter("toilet_id"));
		String status = request.getParameter("status");
		System.out.println("toiletId: " + toilet_id);
		
		String male_toilet = request.getParameter("male_toilet");
		String female_toilet = request.getParameter("female_toilet");
		String disabled_toilet = request.getParameter("disabled_toilet");
		String has_diaper_table = request.getParameter("has_diaper_table");
		String description = request.getParameter("description");
		String photo_url = request.getParameter("photo_url");
		
		System.out.println("UpdateReportStatus..............................: ");
		System.out.println("male_toilet: "+male_toilet);
			
		
		ReportsToiletDAO dao1 = new ReportsToiletDAO();
		UserToiletDAO dao2 = new UserToiletDAO();
		
//		ReportsToiletVO vo = dao1.findById(id);
		UserToiletVO user = new UserToiletVO();
		user.setUserMaleToilet(male_toilet);
		user.setUserFemaleToilet(female_toilet);
		user.setUserMaleDisabledToilet(disabled_toilet);
		user.setUserHasDiaperTable(has_diaper_table);
		user.setUserDescription(description);
		user.setPhotoUrl(photo_url);
		user.setUserToiletId(toilet_id);
		
		dao1.updateStatus(id, status);
		dao2.updateData(toilet_id, user);
		
		request.setAttribute("add", status);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin.jsp");
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
