<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="com.emerlet.vo.ToiletVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>

<%
String toiletIDParam = request.getParameter("toiletID");
String userToiletIDParam = request.getParameter("userToiletID");

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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Emerlet</title>
<link rel="stylesheet" href="css/mo_style.css">
<style>
.container {
	max-width: 800px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
}

label {
	font-family: Pretendard;
	font-size: 16px;
	font-weight: 500;
	color: #1D1D1F;
}

.radio-options {
	display: flex;
	gap: 20px;
	margin-top: 6px;
}

.radio-option {
	display: flex;
	align-items: center;
}

.radio-option label {
	margin-left: 5px;
}

textarea {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-family: Pretendard;
}

.btn {
	width: 100%;
	height: 40px;
	background-color: #3A81FF;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
}

.btn:hover {
	background-color: #2a65c8;
}
</style>
</head>
<body>
	<div class="container">
	
	<div style="display:flex; flex-direction: row-reverse; gap:4px; cursor:pointer;" onclick="location.href='index.html'">
	<div style="display:flex; justify-content:center; aligns-item:center;"><%=bundle.getString("filter.backToMap")%></div>
	<img src="img/back_page.svg"/>
	</div>
	
		<div class="sn-title"><%=bundle.getString("info.updateRequest")%></div>

		<hr style="margin-bottom: 20px">

		<form action="toiletReportOK.jsp" method="post">
			<input type="hidden" name="toiletType" value="<%=toiletType%>">
			<input type="hidden" name="toiletRefId" value="<%=toiletRefId%>">

			<div class="form-group">
				<label><%=bundle.getString("add.name")%></label>
				<div><%=toiletName%></div>
			</div>

			<div class="form-group">
				<label><%=bundle.getString("info.address")%></label>
				<div><%=toiletAddress%></div>
			</div>
			<hr style="margin-bottom: 20px">
			<%
			String[][] fields = { { "reportMaleToilet", bundle.getString("popup.maleToilet"), maleToiletValue },
					{ "reportFemaleToilet", bundle.getString("popup.femaleToilet"), femaleToiletValue },
					{ "reportMaleDisabledToilet", bundle.getString("popup.maleDisabledToilet"), maleDisabledToiletValue },
					{ "reportFemaleDisabledToilet", bundle.getString("popup.femaleDisabledToilet"), femaleDisabledToiletValue },
					{ "reportHasDiaperTable", bundle.getString("popup.diaperTable"), diaperValue }, { "reportHasCctv", bundle.getString("popup.cctv"), cctvValue },
					{ "reportHasEmergencyBell", bundle.getString("popup.emergencyBell"), bellValue } };

			for (String[] field : fields) {
			%>
			<div class="form-group">
				<label><%=field[1]%></label>
				<div class="radio-options">
					<div class="radio-option">
						<input type="radio" name="<%=field[0]%>" value="Y"
							<%="Y".equals(field[2]) ? "checked" : ""%>> <label><%=bundle.getString("add.yes")%></label>
					</div>
					<div class="radio-option">
						<input type="radio" name="<%=field[0]%>" value="N"
							<%="N".equals(field[2]) ? "checked" : ""%>> <label><%=bundle.getString("add.no")%></label>
					</div>
					<div class="radio-option">
						<input type="radio" name="<%=field[0]%>" value="U"
							<%=!"Y".equals(field[2]) && !"N".equals(field[2]) ? "checked" : ""%>>
						<label><%=bundle.getString("add.idk")%></label>
					</div>
				</div>
			</div>
			<%
			}
			%>

			<div class="form-group">
				<label><%=bundle.getString("info.description")%></label>
				<textarea name="reportDescription" rows="5"></textarea>
			</div>

			<div class="form-group">
				<button type="submit" class="btn"><%=bundle.getString("review.submit")%></button>
			</div>
		</form>
	</div>
</body>
</html>
