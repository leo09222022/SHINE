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

@WebServlet("/ToiletSearch")
public class ToiletSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public ToiletSearchServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 검색어 파라미터 가져오기
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // ToiletDAO 객체 생성
            ToiletDAO toiletDAO = new ToiletDAO();
            
            // 주소로 검색 수행
            ArrayList<ToiletVO> searchResults = toiletDAO.searchByRoadAddress(keyword);
            
            // 검색 결과를 request에 저장
            request.setAttribute("searchResults", searchResults);
        }
        
        // 검색 페이지로 이동
        RequestDispatcher dispatcher = request.getRequestDispatcher("/toiletSearch.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
