package com.emerlet.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emerlet.dao.ToiletDAO;
import com.emerlet.vo.ToiletVO;

public class ToiletFilteringAction {

	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("ToiletFilteringAction.execute() called");
		
		try {
			// 요청 파라미터 가져오기
			String hasEmergencyBell = request.getParameter("hasEmergencyBell");
			String hasCctv = request.getParameter("hasCctv");
			String hasDiaperTable = request.getParameter("hasDiaperTable");
			String resetFilters = request.getParameter("resetFilters");
			String viewMap = request.getParameter("viewMap");
			
			// 세션 가져오기
			HttpSession session = request.getSession();
			
			if ("true".equals(resetFilters)) {
				session.removeAttribute("filteredToilets");
				session.removeAttribute("hasEmergencyBell");
				session.removeAttribute("hasCctv");
				session.removeAttribute("hasDiaperTable");
				session.removeAttribute("isFiltered");
				
				return "redirect:index.html";
			}
			
			ToiletDAO toiletDAO = new ToiletDAO();
			ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
			
			// 필터링 적용
			ArrayList<ToiletVO> filteredToilets = new ArrayList<>();
			
			boolean hasFilterConditions = hasEmergencyBell != null || hasCctv != null || hasDiaperTable != null;
			
			for (ToiletVO toilet : allToilets) {
				boolean include = true;
				
				if ("Y".equals(hasEmergencyBell) && toilet.getHasEmergencyBell() != 1) {
					include = false;
				}
				
				if (include && "Y".equals(hasCctv) && toilet.getHasCctv() != 1) {
					include = false;
				}
				
				if (include && "Y".equals(hasDiaperTable) && toilet.getHasDiaperTable() != 1) {
					include = false;
				}
				
				if (include) {
					filteredToilets.add(toilet);
				}
			}
			
			// 필터링 결과와 필터 설정을 세션에 저장 (지도 페이지에서 사용)
			if (hasFilterConditions) {
				session.setAttribute("filteredToilets", filteredToilets);
				session.setAttribute("hasEmergencyBell", hasEmergencyBell);
				session.setAttribute("hasCctv", hasCctv);
				session.setAttribute("hasDiaperTable", hasDiaperTable);
				session.setAttribute("isFiltered", true);
			}
			
			if ("true".equals(viewMap)) {
				return "redirect:index.html";
			}
			
			request.setAttribute("toilets", filteredToilets);
			request.setAttribute("hasEmergencyBell", hasEmergencyBell);
			request.setAttribute("hasCctv", hasCctv);
			request.setAttribute("hasDiaperTable", hasDiaperTable);
			
			System.out.println("필터링 완료: 총 " + filteredToilets.size() + "개의 화장실이 검색되었습니다.");
			
			return "toiletFiltering.jsp";
			
		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
			e.printStackTrace();
			return "redirect:index.html";
		}
	}
}
