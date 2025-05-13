<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.emerlet.dao.UnifiedToiletReportDAO"%>
<%@ page import="com.emerlet.vo.UnifiedToiletReportVO"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
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
boolean isSuccess = result > 0;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Emerlet</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f5f5f5;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	background-color: white;
	padding: 30px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	text-align: center;
}

h2 {
	color: #333;
}

p {
	margin: 20px 0;
	line-height: 1.5;
	font-size: 16px;
}

.success-icon {
	font-size: 48px;
	margin-bottom: 20px;
}

.success {
	color: #4CAF50;
}

.fail {
	color: #E53935;
}

.btn {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #4285F4;
	color: white;
	text-decoration: none;
	border-radius: 4px;
}

.btn:hover {
	background-color: #3367d6;
}
</style>
</head>
<body>
	<div class="container">
		<div class="success-icon <%=isSuccess ? "success" : "fail"%>">
			<%=isSuccess ? "✓" : "✖"%>
		</div>
		<h2><%=isSuccess ? bundle.getString("info.success") : bundle.getString("info.failure")%></h2>
		<p>
			<%=isSuccess ? bundle.getString("info.successMessage") : bundle.getString("info.failureMessage")%>
		</p>
		<a href="index.html" class="btn"><%=bundle.getString("filter.backToMap")%></a>
	</div>
</body>
</html>
