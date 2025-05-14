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
import com.emerlet.dao.UserToiletDAO;
import com.emerlet.vo.ToiletVO;

/**
 * Servlet implementation class MapServlet
 */
@WebServlet("/Emerlet")
public class MapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MapServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    ToiletDAO toiletDAO = new ToiletDAO();
	    UserToiletDAO userToiletDAO = new UserToiletDAO();

	    String lat = request.getParameter("lat");
	    String lng = request.getParameter("lng");
	    String selectLat = request.getParameter("select_lat");
	    String selectLng = request.getParameter("select_lng");

	    // 기존 길찾기 기능
	    if (lat != null && lng != null) {
	        lat = lat.trim();
	        lng = lng.trim();

	        // Google Maps 리디렉션 URL 구성
	        String redirectUrl = "https://www.google.com/maps/dir/" + "?api=1" + "&destination=" + lat + "," + lng
	                + "&travelmode=walking"; // 걷기 모드 명시

	        response.sendRedirect(redirectUrl);
	        return;
	    }

	    // CSV 경로 설정 (웹서버 루트 기준)
	   // String csvPath = getServletContext().getRealPath("공중화장실.csv");
	   // toiletDAO.setupDB(csvPath);

	    // 세션에서 필터링된 화장실 목록 확인
	    HttpSession session = request.getSession();
	    ArrayList<ToiletVO> filteredToilets = (ArrayList<ToiletVO>) session.getAttribute("filteredToilets");
	    boolean isFiltered = (session.getAttribute("isFiltered") != null) ? (Boolean) session.getAttribute("isFiltered")
	            : false;

	    // 필터링된 데이터가 있는 경우
	    if (filteredToilets != null && isFiltered) {
	        request.setAttribute("toilets", filteredToilets);
	    }
	    // 그 외의 경우 모든 화장실 데이터 사용
	    else {
	        ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
	        request.setAttribute("toilets", allToilets);
	    }
	    
	    // 사용자 등록 화장실 데이터 (status = 'approved')
	 	request.setAttribute("userToilets", userToiletDAO.findApprovedToilets());

	    // 선택된 화장실 정보 전달
	    if (selectLat != null && selectLng != null) {
	        request.setAttribute("selectLat", selectLat);
	        request.setAttribute("selectLng", selectLng);
	    }

	    RequestDispatcher dispatcher = request.getRequestDispatcher("/map.jsp");
	    dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
