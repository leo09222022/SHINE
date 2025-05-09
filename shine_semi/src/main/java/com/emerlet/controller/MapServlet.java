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
 * Servlet implementation class MapServlet
 */
@WebServlet("/MapServlet")
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
	// MapServlet.java의 해당 부분 수정
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    ToiletDAO toiletDAO = new ToiletDAO();

	    String lat = request.getParameter("lat");
	    String lng = request.getParameter("lng");

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
	    String csvPath = getServletContext().getRealPath("공중화장실.csv");
	    toiletDAO.setupDB(csvPath);

	    // 세션에서 검색 결과 및 필터링된 화장실 목록 확인
	    HttpSession session = request.getSession();
	    ArrayList<ToiletVO> searchToilets = (ArrayList<ToiletVO>) session.getAttribute("searchToilets");
	    boolean isSearched = (session.getAttribute("isSearched") != null) ? (Boolean) session.getAttribute("isSearched")
	            : false;

	    ArrayList<ToiletVO> filteredToilets = (ArrayList<ToiletVO>) session.getAttribute("filteredToilets");
	    boolean isFiltered = (session.getAttribute("isFiltered") != null) ? (Boolean) session.getAttribute("isFiltered")
	            : false;
	    
	    // 검색 결과에 필터링 적용 (필터 상태가 true인 경우와 검색 결과가 있는 경우)
	    if (isFiltered && filteredToilets != null && isSearched && searchToilets != null) {
	        ArrayList<ToiletVO> searchAndFilteredToilets = new ArrayList<>();
	        String hasMaleToilet = (String) session.getAttribute("hasMaleToilet");
	        String hasFemaleToilet = (String) session.getAttribute("hasFemaleToilet");
	        String hasMaleDisabledToilet = (String) session.getAttribute("hasMaleDisabledToilet");
	        String hasFemaleDisabledToilet = (String) session.getAttribute("hasFemaleDisabledToilet");
	        String hasDiaperTable = (String) session.getAttribute("hasDiaperTable");

	        for (ToiletVO toilet : searchToilets) {
	            boolean include = true;

	            // 남자화장실 필터 적용
	            if ("Y".equals(hasMaleToilet) && toilet.getMaleToilet() < 1) {
	                include = false;
	            }

	            // 여자화장실 필터 적용
	            if (include && "Y".equals(hasFemaleToilet) && toilet.getFemaleToilet() < 1) {
	                include = false;
	            }

	            // 남성 장애인 화장실 필터 적용
	            if (include && "Y".equals(hasMaleDisabledToilet) && toilet.getMaleDisabledToilet() < 1) {
	                include = false;
	            }

	            // 여성 장애인 화장실 필터 적용
	            if (include && "Y".equals(hasFemaleDisabledToilet) && toilet.getFemaleDisabledToilet() < 1) {
	                include = false;
	            }

	            // 기저귀 교환대 필터 적용
	            if (include && "Y".equals(hasDiaperTable) && toilet.getHasDiaperTable() != 1) {
	                include = false;
	            }

	            if (include) {
	                searchAndFilteredToilets.add(toilet);
	            }
	        }

	        request.setAttribute("toilets", searchAndFilteredToilets);
	    }
	    // 검색 결과는 없고 필터링된 데이터가 있는 경우
	    else if (filteredToilets != null && isFiltered) {
	        request.setAttribute("toilets", filteredToilets);
	    }
	    // 검색 결과만 있고 필터링은 없는 경우
	    else if (searchToilets != null && isSearched) {
	        request.setAttribute("toilets", searchToilets);
	    }
	    // 그 외의 경우 모든 화장실 데이터 사용
	    else {
	        ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
	        request.setAttribute("toilets", allToilets);
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
