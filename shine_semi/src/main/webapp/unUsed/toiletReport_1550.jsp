<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="com.emerlet.vo.ToiletVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String toiletIDParam = request.getParameter("toiletID");
String userToiletIDParam = request.getParameter("userToiletID");

System.out.println("🔥 전달된 toiletIDParam = " + request.getParameter("toiletID"));
System.out.println("🔥 전달된 userToiletIDParam = " + request.getParameter("userToiletID"));

String toiletType = null;
int toiletRefId = -1;
String toiletName = null;
String toiletAddress = null;

String maleToiletValue = "U";
String femaleToiletValue = "U";
String maleDisabledToiletValue = "U";
String femaleDisabledToiletValue = "U";
String diaperValue = "U";
String cctvValue = "U";
String bellValue = "U";

if (toiletIDParam != null) {
	toiletRefId = Integer.parseInt(toiletIDParam);
	ToiletVO vo = new com.emerlet.dao.ToiletDAO().findByID(toiletRefId);
	toiletType = "public";
	toiletName = vo.getName();
	toiletAddress = vo.getAddressRoad();

	maleToiletValue = vo.getMaleToilet() > 0 ? "Y" : "N";
	femaleToiletValue = vo.getFemaleToilet() > 0 ? "Y" : "N";
	maleDisabledToiletValue = vo.getMaleDisabledToilet() > 0 ? "Y" : "N";
	femaleDisabledToiletValue = vo.getFemaleDisabledToilet() > 0 ? "Y" : "N";
	diaperValue = vo.getHasDiaperTable() > 0 ? "Y" : "N";
	cctvValue = vo.getHasCctv() > 0 ? "Y" : "N";
	bellValue = vo.getHasEmergencyBell() > 0 ? "Y" : "N";

} else if (userToiletIDParam != null) {
	toiletRefId = Integer.parseInt(userToiletIDParam);
	UserToiletVO vo = new com.emerlet.dao.UserToiletDAO().findByID(toiletRefId);
	toiletType = "user";
	toiletName = vo.getUserName();
	toiletAddress = vo.getUserRoadAddress();

	maleToiletValue = vo.getUserMaleToilet();
	femaleToiletValue = vo.getUserFemaleToilet();
	maleDisabledToiletValue = vo.getUserMaleDisabledToilet();
	femaleDisabledToiletValue = vo.getUserFemaleDisabledToilet();
	diaperValue = vo.getUserHasDiaperTable();
	cctvValue = vo.getUserHasCctv();
	bellValue = vo.getUserHasEmergencyBell();
} else {
	throw new Exception("화장실 ID가 전달되지 않았습니다.");
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>화장실 정보 신고</title>
</head>
<body>
	<h2>화장실 정보 신고</h2>

	<form action="toiletReportOK.jsp" method="post">
		<input type="hidden" name="toiletType" value="<%=toiletType%>">
		<input type="hidden" name="toiletRefId" value="<%=toiletRefId%>">

		<p>
			화장실명:
			<%=toiletName%></p>
		<p>
			주소:
			<%=toiletAddress%></p>

		<p>
			남자화장실: <input type="radio" name="reportMaleToilet" value="Y"
				<%="Y".equals(maleToiletValue) ? "checked" : ""%>> 있음 <input
				type="radio" name="reportMaleToilet" value="N"
				<%="N".equals(maleToiletValue) ? "checked" : ""%>> 없음 <input
				type="radio" name="reportMaleToilet" value="U"
				<%=!"Y".equals(maleToiletValue) && !"N".equals(maleToiletValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			여자화장실: <input type="radio" name="reportFemaleToilet" value="Y"
				<%="Y".equals(femaleToiletValue) ? "checked" : ""%>> 있음 <input
				type="radio" name="reportFemaleToilet" value="N"
				<%="N".equals(femaleToiletValue) ? "checked" : ""%>> 없음 <input
				type="radio" name="reportFemaleToilet" value="U"
				<%=!"Y".equals(femaleToiletValue) && !"N".equals(femaleToiletValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			남자 장애인화장실: <input type="radio" name="reportMaleDisabledToilet"
				value="Y"
				<%="Y".equals(maleDisabledToiletValue) ? "checked" : ""%>>
			있음 <input type="radio" name="reportMaleDisabledToilet" value="N"
				<%="N".equals(maleDisabledToiletValue) ? "checked" : ""%>>
			없음 <input type="radio" name="reportMaleDisabledToilet" value="U"
				<%=!"Y".equals(maleDisabledToiletValue) && !"N".equals(maleDisabledToiletValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			여자 장애인화장실: <input type="radio" name="reportFemaleDisabledToilet"
				value="Y"
				<%="Y".equals(femaleDisabledToiletValue) ? "checked" : ""%>>
			있음 <input type="radio" name="reportFemaleDisabledToilet" value="N"
				<%="N".equals(femaleDisabledToiletValue) ? "checked" : ""%>>
			없음 <input type="radio" name="reportFemaleDisabledToilet" value="U"
				<%=!"Y".equals(femaleDisabledToiletValue) && !"N".equals(femaleDisabledToiletValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			기저귀 교환대: <input type="radio" name="reportHasDiaperTable" value="Y"
				<%="Y".equals(diaperValue) ? "checked" : ""%>> 있음 <input
				type="radio" name="reportHasDiaperTable" value="N"
				<%="N".equals(diaperValue) ? "checked" : ""%>> 없음 <input
				type="radio" name="reportHasDiaperTable" value="U"
				<%=!"Y".equals(diaperValue) && !"N".equals(diaperValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			CCTV: <input type="radio" name="reportHasCctv" value="Y"
				<%="Y".equals(cctvValue) ? "checked" : ""%>> 있음 <input
				type="radio" name="reportHasCctv" value="N"
				<%="N".equals(cctvValue) ? "checked" : ""%>> 없음 <input
				type="radio" name="reportHasCctv" value="U"
				<%=!"Y".equals(cctvValue) && !"N".equals(cctvValue) ? "checked" : ""%>>
			모름
		</p>

		<p>
			비상벨: <input type="radio" name="reportHasEmergencyBell" value="Y"
				<%="Y".equals(bellValue) ? "checked" : ""%>> 있음 <input
				type="radio" name="reportHasEmergencyBell" value="N"
				<%="N".equals(bellValue) ? "checked" : ""%>> 없음 <input
				type="radio" name="reportHasEmergencyBell" value="U"
				<%=!"Y".equals(bellValue) && !"N".equals(bellValue) ? "checked" : ""%>>
			모름
		</p>


		<p>
			설명 (오류 내용 등):<br>
			<textarea name="reportDescription" rows="5" cols="50"></textarea>
		</p>

		<button type="submit">신고 제출</button>
	</form>
</body>
</html>
