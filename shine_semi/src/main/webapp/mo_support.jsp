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
<title><%=bundle.getString("about.title")%></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css" />
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Pretendard';
	background-color: #FFFFFF;
	color: #1D1D1F;
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

@media ( min-width : 768px) {
	.menu-header {
		display: none;
	}
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
			<div class="page-title"><%=bundle.getString("support.title")%></div>

			<div class="text-content"><%=bundle.getString("support.description")%></div>

		</div>

		<div class="content-container">
			<div class="page-title"><%=bundle.getString("report.title")%></div>

			<div class="text-content"><%=bundle.getString("report.quotes1")%></div>

			<div class="text-content"><%=bundle.getString("report.quotes2")%></div>

			<div class="text-content"><%=bundle.getString("report.description")%></div>

			<div class="supports-btn" onclick="location.href='toiletAdd.jsp'"><%=bundle.getString("report.button")%></div>
		</div>

		<div class="content-container">
			<div class="page-title"><%=bundle.getString("donation.title")%></div>

			<div class="text-content"><%=bundle.getString("donation.description1")%></div>


			<div class="text-content"><%=bundle.getString("donation.description2")%></div>
			<div class="supports-btn"><%=bundle.getString("donation.button")%></div>
		</div>




	</div>
</body>
</html>