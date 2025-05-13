<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.emerlet.dao.UnifiedToiletReportDAO"%>
<%@ page import="com.emerlet.vo.UnifiedToiletReportVO"%>
<%
request.setCharacterEncoding("UTF-8");

String type = request.getParameter("toiletType");
int refId = Integer.parseInt(request.getParameter("toiletRefId"));

UnifiedToiletReportVO vo = new UnifiedToiletReportVO();
vo.setToiletType(type);
vo.setToiletRefId(refId);
vo.setReportMale(request.getParameter("reportMaleToilet"));
vo.setReportFemale(request.getParameter("reportFemaleToilet"));
vo.setReportMaleDisabled(request.getParameter("reportMaleDisabledToilet"));
vo.setReportFemaleDisabled(request.getParameter("reportFemaleDisabledToilet"));
vo.setReportHasDiaperTable(request.getParameter("reportHasDiaperTable"));
vo.setReportHasCctv(request.getParameter("reportHasCctv"));
vo.setReportHasEmergencyBell(request.getParameter("reportHasEmergencyBell"));
vo.setReportDescription(request.getParameter("reportDescription"));
vo.setReportStatus("W");

int result = new UnifiedToiletReportDAO().insertReport(vo);
%>
<p><%=result > 0 ? "신고 완료" : "신고 실패"%></p>