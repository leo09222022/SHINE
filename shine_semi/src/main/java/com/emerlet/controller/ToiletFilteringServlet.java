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
 * Servlet implementation class ToiletFilteringServlet
 */
@WebServlet("/ToiletFilteringServlet")
public class ToiletFilteringServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ToiletFilteringServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 요청 파라미터 가져오기
			String hasEmergencyBell = request.getParameter("hasEmergencyBell");
			String hasCctv = request.getParameter("hasCctv");
			String hasDiaperTable = request.getParameter("hasDiaperTable");
			String resetFilters = request.getParameter("resetFilters");
			String viewMap = request.getParameter("viewMap");
			String saveMapPosition = request.getParameter("saveMapPosition");
			String noRedirect = request.getParameter("noRedirect");

			// 세션 가져오기
			HttpSession session = request.getSession();

			// 필터 초기화 요청이 있을 경우
			if ("true".equals(resetFilters)) {
				System.out.println("▶ 필터 초기화 요청 처리");
				session.removeAttribute("filteredToilets");
				session.removeAttribute("hasEmergencyBell");
				session.removeAttribute("hasCctv");
				session.removeAttribute("hasDiaperTable");
				session.setAttribute("isFiltered", false);

				// 메인 지도 페이지로 리다이렉트
				response.sendRedirect("map");
				return;
			}

			// 필터 조건 확인
			boolean hasFilterConditions = "Y".equals(hasEmergencyBell) || "Y".equals(hasCctv)
					|| "Y".equals(hasDiaperTable);

			// 필터 적용 & 지도로 돌아가기 요청이면서 아무 필터도 체크하지 않은 경우
			if ("true".equals(viewMap) && !hasFilterConditions) {
				session.removeAttribute("filteredToilets");
				session.removeAttribute("hasEmergencyBell");
				session.removeAttribute("hasCctv");
				session.removeAttribute("hasDiaperTable");
				session.setAttribute("isFiltered", false);

				// 메인 지도 페이지로 리다이렉트
				response.sendRedirect("map");
				return;
			}

			if (hasFilterConditions) {

				// DAO를 통해 화장실 데이터 가져오기
				ToiletDAO toiletDAO = new ToiletDAO();
				ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
				ArrayList<ToiletVO> filteredToilets = new ArrayList<>();

				// 필터링 적용
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
				session.setAttribute("filteredToilets", filteredToilets);
				session.setAttribute("hasEmergencyBell", hasEmergencyBell);
				session.setAttribute("hasCctv", hasCctv);
				session.setAttribute("hasDiaperTable", hasDiaperTable);
				session.setAttribute("isFiltered", true);

				// 필터 적용 후 지도로 돌아가기 요청이 있는 경우
				if ("true".equals(viewMap)) {
					response.sendRedirect("map");
					return;
				}

				// 요청 속성에도 저장 (JSP에서 바로 사용)
				request.setAttribute("toilets", filteredToilets);
				request.setAttribute("hasEmergencyBell", hasEmergencyBell);
				request.setAttribute("hasCctv", hasCctv);
				request.setAttribute("hasDiaperTable", hasDiaperTable);
			} else {

				// 필터 조건이 없는 경우 기존 세션 확인
				if (session.getAttribute("filteredToilets") != null) {
					// 세션에 이미 필터링 결과가 있으면 그대로 사용
					ArrayList<ToiletVO> previousFiltered = (ArrayList<ToiletVO>) session
							.getAttribute("filteredToilets");
					request.setAttribute("toilets", previousFiltered);
					request.setAttribute("hasEmergencyBell", session.getAttribute("hasEmergencyBell"));
					request.setAttribute("hasCctv", session.getAttribute("hasCctv"));
					request.setAttribute("hasDiaperTable", session.getAttribute("hasDiaperTable"));
				} else {
					// 기존 필터링 결과가 없으면 모든 화장실 표시
					ToiletDAO toiletDAO = new ToiletDAO();
					ArrayList<ToiletVO> allToilets = toiletDAO.findAll();
					request.setAttribute("toilets", allToilets);
				}
			}

			// 필터링 결과 페이지로 포워딩
			RequestDispatcher dispatcher = request.getRequestDispatcher("/toiletFiltering.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect("map");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}