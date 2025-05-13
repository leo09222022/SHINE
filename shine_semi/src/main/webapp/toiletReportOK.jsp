<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emerlet.dao.UnifiedToiletReportDAO" %>
<%@ page import="com.emerlet.vo.UnifiedToiletReportVO" %>
<%
request.setCharacterEncoding("UTF-8");

String toiletType = request.getParameter("toiletType"); // "public" or "user"
int toiletRefId = Integer.parseInt(request.getParameter("toiletRefId"));

UnifiedToiletReportVO vo = new UnifiedToiletReportVO();
vo.setToiletType(toiletType);
vo.setToiletRefId(toiletRefId);
vo.setReportMale(request.getParameter("reportMaleToilet"));
vo.setReportFemale(request.getParameter("reportFemaleToilet"));
vo.setReportMaleDisabled(request.getParameter("reportMaleDisabledToilet"));
vo.setReportFemaleDisabled(request.getParameter("reportFemaleDisabledToilet"));
vo.setReportHasDiaperTable(request.getParameter("reportHasDiaperTable"));
vo.setReportHasCctv(request.getParameter("reportHasCctv"));
vo.setReportHasEmergencyBell(request.getParameter("reportHasEmergencyBell"));
vo.setReportDescription(request.getParameter("reportDescription"));
vo.setReportStatus("W"); // 기본값 대기중

int result = new UnifiedToiletReportDAO().insertReport(vo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 결과</title>
</head>
<body>
	<h2>📢 신고 처리 결과</h2>
	<p><%=result > 0 ? "신고가 정상적으로 접수되었습니다!" : "신고 처리에 실패했습니다."%></p>
	<a href="index.jsp">홈으로</a>
</body>
</html>
