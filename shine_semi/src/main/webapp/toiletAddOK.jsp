<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>화장실 등록 요청 완료</title>
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
		<h2>화장실 등록 요청 완료</h2>

		<p>${message}</p>

		<a href="index.html" class="btn">지도로 돌아가기</a>
	</div>
</body>
</html>