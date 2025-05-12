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
        
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            ToiletDAO toiletDAO = new ToiletDAO();
            ArrayList<ToiletVO> searchResults = toiletDAO.searchByRoadAddress(keyword);
            request.setAttribute("searchResults", searchResults);
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/toiletSearch.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
