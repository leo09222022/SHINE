<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emerlet.vo.UserToiletReportVO" %>
<%@ page import="com.emerlet.dao.UserToiletReportDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 받기
    int userToiletId = Integer.parseInt(request.getParameter("userToiletId"));
    String male = request.getParameter("reportMaleToilet");
    String female = request.getParameter("reportFemaleToilet");
    String maleDisabled = request.getParameter("reportMaleDisabledToilet");
    String femaleDisabled = request.getParameter("reportFemaleDisabledToilet");
    String diaper = request.getParameter("reportHasDiaperTable");
    String cctv = request.getParameter("reportHasCctv");
    String bell = request.getParameter("reportHasEmergencyBell");
    String desc = request.getParameter("reportDescription");

    // VO에 담기
    UserToiletReportVO vo = new UserToiletReportVO();
    vo.setUserToiletId(userToiletId);
    vo.setReportMaleToilet(male);
    vo.setReportFemaleToilet(female);
    vo.setReportMaleDisabledToilet(maleDisabled);
    vo.setReportFemaleDisabledToilet(femaleDisabled);
    vo.setReportHasDiaperTable(diaper);
    vo.setReportHasCctv(cctv);
    vo.setReportHasEmergencyBell(bell);
    vo.setReportDescription(desc);
    vo.setReportStatus("W"); // W: 대기중(Waiting)

    // DAO 호출
    UserToiletReportDAO dao = new UserToiletReportDAO();
    int result = dao.insertUserReport(vo);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>신고 결과</title>
</head>
<body>
  <h2>📢 신고 처리 결과</h2>
  <p><%= result > 0 ? "신고가 정상적으로 접수되었습니다!" : "신고 처리에 실패했습니다." %></p>
  <a href="index.jsp">홈으로</a>
</body>
</html>
