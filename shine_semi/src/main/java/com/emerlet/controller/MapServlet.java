package com.emerlet.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ToiletDAO toiletDAO = new ToiletDAO();

        // CSV 경로 설정 (웹서버 루트 기준)
        String csvPath = getServletContext().getRealPath("공중화장실.csv");
        toiletDAO.setupDB(csvPath);

        ArrayList<ToiletVO> toilets = toiletDAO.findAll();
        request.setAttribute("toilets", toilets);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/map.jsp");
        dispatcher.forward(request, response);
    }

//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // ToiletDAO 객체 생성
//        ToiletDAO toiletDAO = new ToiletDAO();
//        
//        // findAll() 메서드를 통해 모든 화장실 데이터 가져오기
//        ArrayList<ToiletVO> toilets = toiletDAO.findAll();
//        
//        // 가져온 데이터를 request에 속성으로 저장
//        request.setAttribute("toilets", toilets);
//
//        // map.jsp로 포워딩
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/map.jsp");
//        dispatcher.forward(request, response);
//    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
