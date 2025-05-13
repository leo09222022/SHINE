package com.emerlet.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ReportsToiletDAO;
import com.emerlet.dao.UserToiletDAO;
import com.emerlet.vo.ReportsToiletVO;
import com.emerlet.vo.UserToiletVO;
import com.google.gson.Gson;

/**
 * Servlet implementation class AdminReport
 */
@WebServlet("/AdminReport")
public class AdminReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String status = "신규";
		/*
		 * status 매개변수로 받아서 ReportsToiletDao의 findByStatus 메소드 실행
		 */
		
		if(request.getParameter("status") != null) {
			status = request.getParameter("status");
		}
		
		
		ReportsToiletDAO dao = new ReportsToiletDAO();
		ArrayList<ReportsToiletVO> list = null;
		list = dao.findByStatus(status);
		
		Gson gson = new Gson();
		String r = gson.toJson(list);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(r);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
