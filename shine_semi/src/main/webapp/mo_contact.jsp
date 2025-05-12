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
String email = "shine-emerlet@gmail.com";
String rawMessage = bundle.getString("contact.message");
String formattedMessage = MessageFormat.format(rawMessage, email);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us</title>
<link rel="stylesheet" href="css/mo_style.css" />
<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Pretendard', sans-serif;
    background-color: #FFFFFF;
    color: #1D1D1F;
}

.content-wrapper {
    display: flex;
    flex-direction: column;
}

.content-container {
    display: flex;
    flex-direction: column;
    padding: 20px;
    gap: 10px;
}

.content-title {
    font-size: 20px;
    font-weight: 500;
    color: #1D1D1F;
    margin-bottom: 10px;
}

.content-description {
	font-family: Pretendard;
    font-size: 16px;
    font-weight: normal;
    line-height: 150%;
    color: #1D1D1F;
}

.contact-email {
    text-decoration: underline;
    color: inherit;
    display: inline-block;
}
</style>
</head>
<body>
	<div class="menu-header">
		<img class="cursor" src="img/logo_row.svg"
			onclick="location.href='index.html'"> 
		<img class="cursor"
			src="img/pop__close.svg" onclick="location.href='index.html'" />
	</div>

	<div class="content-wrapper">
		<div class="content-container">
			<div class="content-title">Contact Us</div>
			<div class="content-description">
				If you have any problems updating the toilets, or wish to send us toilet 
				details or comments, please contact 
				<a href="mailto:shine-emerlet@gmail.com" class="contact-email">shine-emerlet@gmail.com</a>
			</div>
		</div>
	</div>
</body>
</html>