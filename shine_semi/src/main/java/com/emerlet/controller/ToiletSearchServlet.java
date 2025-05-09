package com.emerlet.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emerlet.dao.ToiletDAO;
import com.emerlet.vo.ToiletVO;

@WebServlet("/ToiletSearchServlet")
public class ToiletSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public ToiletSearchServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 검색어 파라미터 가져오기
        String keyword = request.getParameter("keyword");
        
        // 세션 가져오기
        HttpSession session = request.getSession();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // ToiletDAO 객체 생성
            ToiletDAO toiletDAO = new ToiletDAO();
            
            // 주소로 검색 수행
            ArrayList<ToiletVO> searchResults = toiletDAO.searchByRoadAddress(keyword);
            
            // 검색 결과와 검색어를 세션에 저장
            session.setAttribute("searchToilets", searchResults);
            session.setAttribute("searchKeyword", keyword);
            session.setAttribute("isSearched", true);
            
            System.out.println("검색 완료: 키워드 '" + keyword + "', 결과 " + searchResults.size() + "개");
        } else {
            // 검색어가 없는 경우 세션에서 검색 관련 속성 제거
            session.removeAttribute("searchToilets");
            session.removeAttribute("searchKeyword");
            session.setAttribute("isSearched", false);
            
            System.out.println("검색 초기화 (검색어 없음)");
        }
        
        // 지도 페이지로 리다이렉트
        response.sendRedirect("map");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
