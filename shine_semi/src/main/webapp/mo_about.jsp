<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>

<%@ page import="java.text.MessageFormat"%>

<%
String email = "emerlet@gmail.com";
String rawMessage = bundle.getString("contact.message");
String formattedMessage = MessageFormat.format(rawMessage, email);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=bundle.getString("about.title")%></title>
<link rel="stylesheet" href="css/mo_style.css" />
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Pretendard';
	background-color: #FFFFFF;
	color: #1D1D1F;
}

.menu-header {
	position: fixed; /* 고정 위치 설정 */
	top: 0; /* 화면 상단에 배치 */
	left: 0; /* 화면 왼쪽에 배치 */
	width: 100%; /* 전체 너비 차지 */
	height: 48px; /* 기존 높이 유지 */
	background-color: white; /* 배경색 설정 */
	z-index: 1000; /* 다른 요소 위에 표시 */
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	padding: 12px 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
}

.content-wrapper {
	display: flex;
	flex-direction: column;
	margin-top: 72px; /* 헤더 높이 + 여유 공간 */
}

.content-container {
	display: flex;
	flex-direction: column;
	padding: 20px;
	gap: 8px;
}

.page-title {
	font-size: 20px;
	font-weight: normal;
	color: #1D1D1F;
	margin-bottom: 8px;
}

.text-content {
	font-size: 16px;
	font-weight: normal;
	line-height: 150%;
	color: #1D1D1F;
	margin-bottom: 8px;
}

.feature-list {
	font-size: 16px;
	font-weight: normal;
	line-height: 150%;
	color: #1D1D1F;
}

.feature-item {
	margin-bottom: 8px;
	display: flex;
	align-items: flex-start;
}

.feature-item:before {
	content: "•";
	margin-right: 8px;
}

.contact-email {
	text-decoration: underline;
	color: inherit;
}

.content-title {
	font-size: 20px;
	font-weight: 500;
	color: #1D1D1F;
	width: 100%;
}

.content-description {
	font-size: 16px;
	font-family: Pretendard;
	font-weight: 400;
	line-height: 24px;
	color: #1D1D1F;
}
</style>
</head>
<body>
	<div class="menu-header">
		<img class="cursor" src="img/logo_row.svg"
			onclick="location.href='index.html'"> <img class="cursor"
			src="img/pop__close.svg" onclick="location.href='index.html'" />
	</div>

	<div class="content-wrapper">
		<div class="content-container">
			<div class="page-title"><%=bundle.getString("about.title")%></div>

			<div class="text-content"><%=bundle.getString("about.intro1")%></div>

			<div class="text-content"><%=bundle.getString("about.intro2")%></div>

			<div class="text-content"><%=bundle.getString("about.intro3")%></div>
		</div>

		<div class="content-container">
			<div class="page-title"><%=bundle.getString("about.features.title")%></div>

			<div class="text-content"><%=bundle.getString("about.features.location")%></div>

			<div class="text-content"><%=bundle.getString("about.features.review")%></div>

			<div class="text-content"><%=bundle.getString("about.features.registration")%></div>

			<div class="text-content"><%=bundle.getString("about.features.multilingual")%></div>

			<div class="text-content"><%=bundle.getString("about.features.filter")%></div>
		</div>

		<div class="content-container">
			<div class="page-title"><%=bundle.getString("about.definition.title")%></div>

			<div class="text-content"><%=bundle.getString("about.definition.desc")%></div>

			<div class="feature-list">
				<div class="feature-item"><%=bundle.getString("about.definition.item1")%></div>
				<div class="feature-item"><%=bundle.getString("about.definition.item2")%></div>
				<div class="feature-item"><%=bundle.getString("about.definition.item3")%></div>
				<div class="feature-item"><%=bundle.getString("about.definition.item4")%></div>
				<div class="feature-item"><%=bundle.getString("about.definition.item5")%></div>
			</div>

			<div class="text-content"><%=bundle.getString("about.definition.note")%></div>
		</div>

		<div class="content-container">
			<div class="page-title"><%=bundle.getString("about.participation.title")%></div>

			<div class="text-content"><%=bundle.getString("about.participation.desc")%></div>
		</div>

		<div class="content-container">
			<div class="content-title"><%=bundle.getString("footer.contact")%></div>
			<div class="content-description">
				<%=formattedMessage%>
			</div>
		</div>
	</div>
</body>
</html>