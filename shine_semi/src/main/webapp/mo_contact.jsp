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
<title>Emerlet</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/mo_style.css" />
<style type="text/css">
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
			<div class="sn-title"><%=bundle.getString("footer.contact")%></div>
			<div>
				<div>
					<%=formattedMessage%>
				</div>



			</div>
		</div>
	</div>
</html>