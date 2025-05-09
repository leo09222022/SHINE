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
			
			// 필터 초기화 요청이 있을 경우
			if ("true".equals(resetFilters)) {
				session.removeAttribute("filteredToilets");
				session.removeAttribute("hasEmergencyBell");
				session.removeAttribute("hasCctv");
				session.removeAttribute("hasDiaperTable");
				session.removeAttribute("isFiltered");
				
				// 메인 지도 페이지로 리다이렉트
				return "redirect:index.html";
			}
			
			// DAO를 통해 화장실 데이터 가져오기
			ToiletDAO toiletDAO = new ToiletDAO();
			ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
			
			// 필터링 적용
			ArrayList<ToiletVO> filteredToilets = new ArrayList<>();
			
			// 필터 조건이 있는 경우만 필터링 적용
			boolean hasFilterConditions = hasEmergencyBell != null || hasCctv != null || hasDiaperTable != null;
			
			for (ToiletVO toilet : allToilets) {
				boolean include = true;
				
				// 비상벨 필터 적용
				if ("Y".equals(hasEmergencyBell) && toilet.getHasEmergencyBell() != 1) {
					include = false;
				}
				
				// CCTV 필터 적용
				if (include && "Y".equals(hasCctv) && toilet.getHasCctv() != 1) {
					include = false;
				}
				
				// 기저귀 교환대 필터 적용
				if (include && "Y".equals(hasDiaperTable) && toilet.getHasDiaperTable() != 1) {
					include = false;
				}
				
				// 모든 조건 통과시 필터링된 리스트에 추가
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
			
			// 지도로 돌아가기 요청이 있는 경우
			if ("true".equals(viewMap)) {
				// index.html로 리다이렉트 (index.html은 map 서블릿으로 리다이렉트됨)
				return "redirect:index.html";
			}
			
			// 요청 속성에도 저장 (JSP에서 바로 사용)
			request.setAttribute("toilets", filteredToilets);
			request.setAttribute("hasEmergencyBell", hasEmergencyBell);
			request.setAttribute("hasCctv", hasCctv);
			request.setAttribute("hasDiaperTable", hasDiaperTable);
			
			System.out.println("필터링 완료: 총 " + filteredToilets.size() + "개의 화장실이 검색되었습니다.");
			
			// 필터링 결과 페이지로 포워딩
			return "toiletFiltering.jsp";
			
		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
			e.printStackTrace();
			return "redirect:index.html";
		}
	}
}
