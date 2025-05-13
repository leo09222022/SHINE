<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.emerlet.db.ConnectionProvider"%>
<%
request.setCharacterEncoding("UTF-8");

int toiletId = Integer.parseInt(request.getParameter("toiletId"));
String male = request.getParameter("reportMaleToilet");
String female = request.getParameter("reportFemaleToilet");
String maleDisabled = request.getParameter("reportMaleDisabledToilet");
String femaleDisabled = request.getParameter("reportFemaleDisabledToilet");
String diaper = request.getParameter("reportHasDiaperTable");
String cctv = request.getParameter("reportHasCctv");
String bell = request.getParameter("reportHasEmergencyBell");
String desc = request.getParameter("reportDescription");

// 필수 컬럼: photo_error, report_status 기본값 설정
String photoError = "N"; // 기본값으로 처리
String status = "W"; // W = 대기중

int result = 0;

try {
	Connection conn = ConnectionProvider.getConnection();
	String sql = "INSERT INTO reports_public_toilet (" + "report_id, toilet_id, reported_at, "
	+ "report_male_toilet, report_female_toilet, "
	+ "report_male_disabled_toilet, report_female_disabled_toilet, "
	+ "report_has_diaper_table, report_has_cctv, report_has_emergency_bell, "
	+ "report_description, report_photo_error, report_status) "
	+ "VALUES (report_seq.NEXTVAL, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, toiletId);
	pstmt.setString(2, male);
	pstmt.setString(3, female);
	pstmt.setString(4, maleDisabled);
	pstmt.setString(5, femaleDisabled);
	pstmt.setString(6, diaper);
	pstmt.setString(7, cctv);
	pstmt.setString(8, bell);
	pstmt.setString(9, desc);
	pstmt.setString(10, photoError);
	pstmt.setString(11, status);

	result = pstmt.executeUpdate();

	pstmt.close();
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}
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
