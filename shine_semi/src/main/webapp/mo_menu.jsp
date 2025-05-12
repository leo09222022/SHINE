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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/mo_style.css" />
</head>
<body>
	<!-- mobileMenu.html -->
	<!-- 상단 로고 및 닫기 버튼 -->
	<div class="menu-header">
		<img class="cursor" src="img/logo_row.svg"
			onclick="location.href='index.html'"> <img class="cursor"
			src="img/pop__close.svg" onclick="window.history.back()" />
	</div>

	<!-- 메뉴 항목 -->
	<div class="menu-items">
		<div class="menu-item" onclick="location.href='mo_about.jsp'">
			<span><%=bundle.getString("footer.about")%></span> <img
				src="img/menu_more.svg">
		</div>
		<div class="menu-item" onclick="location.href='mo_contact.jsp'">
			<span><%=bundle.getString("footer.contact")%></span> <img
				src="img/menu_more.svg">
		</div>
		<div class="menu-item" onclick="location.href='mo_support.jsp'">
			<span><%=bundle.getString("footer.support")%></span> <img
				src="img/menu_more.svg">
		</div>
		<div class="menu-item" onclick="location.href='toiletAdd.jsp'">
			<span><%=bundle.getString("menu.register")%></span> <img
				src="img/menu_more.svg">
		</div>
		<div class="menu-item" onclick="location.href='mo_tips.jsp'">
			<span><%=bundle.getString("menu.guide")%></span> <img
				src="img/menu_more.svg">
		</div>
	</div>
</body>
</html>