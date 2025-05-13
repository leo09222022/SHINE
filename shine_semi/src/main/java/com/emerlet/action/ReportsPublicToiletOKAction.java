package com.emerlet.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ReportsPublicToiletDAO;
import com.emerlet.vo.ReportsPublicToiletVO;

public class ReportsPublicToiletOKAction implements EmerletAction {

	@Override
	  public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 폼 데이터 받기
        int toiletId = Integer.parseInt(request.getParameter("toiletId"));

        // 2. VO 생성 및 값 설정
        ReportsPublicToiletVO vo = new ReportsPublicToiletVO();

        // 3. DAO 호출
        ReportsPublicToiletDAO dao = new ReportsPublicToiletDAO();
        int result = dao.insertReport(vo);

        // 4. 응답 처리 (redirect 또는 결과 페이지)
        if (result==1) {
            return "redirect:toiletReportOK.jsp";
        } else {
            request.setAttribute("errorMessage", "신고 등록에 실패했습니다.");
            return "toiletReport.jsp";
        }
    }
}
