<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null) lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

String messageCode = (String) request.getAttribute("message"); // 예: "1"

String msgText = "";
	if ("1".equals(messageCode)) {
		msgText = bundle.getString("add.success");
	} else if ("2".equals(messageCode)) {
		msgText = bundle.getString("add.error");
	} else if ("3".equals(messageCode)) {
		msgText = bundle.getString("add.systemError");
	} else if ("4".equals(messageCode)) {
		msgText = bundle.getString("add.locationError");
	} else {
		msgText = bundle.getString("add.error");
	}
	request.setAttribute("msgText", msgText);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Emerlet</title>
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
}

.success-icon {
	color: #4CAF50;
	font-size: 48px;
	margin-bottom: 20px;
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
		<div class="success-icon">✓</div>
		<h2><%=bundle.getString("add.complete")%></h2>

		<p>${msgText}</p>

		<a href="index.html" class="btn"><%=bundle.getString("filter.backToMap")%></a>
	</div>
</body>
</html>