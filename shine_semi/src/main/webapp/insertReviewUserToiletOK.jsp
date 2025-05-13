<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.emerlet.db.ConnectionProvider"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null) lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

int userToiletId = Integer.parseInt(request.getParameter("userToiletId"));
String cleanliness = request.getParameter("cleanliness");
String safety = request.getParameter("safety");

int result = 0;
try {
	Connection conn = ConnectionProvider.getConnection();
	String sql = "INSERT INTO reviews (review_id, cleanliness, safety, created_at, user_toilet_id) VALUES ((SELECT NVL(MAX(review_id), 0) + 1 FROM reviews), ?, ?, SYSDATE, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, cleanliness);
	pstmt.setString(2, safety);
	pstmt.setInt(3, userToiletId);
	result = pstmt.executeUpdate();
	pstmt.close();
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}

String resultMessage = result > 0 
    ? bundle.getString("review.ok") 
    : bundle.getString("review.notOk");

boolean isSuccess = result > 0;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=bundle.getString("review.result")%></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css">
<style>
body {
	font-family: 'Pretendard', sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f5f5f5;
}

.container {
	max-width: 600px;
	margin: 80px auto;
	background-color: white;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
}

h2 {
	color: #3A81FF;
	font-size: 24px;
	margin-bottom: 20px;
}

p {
	font-size: 16px;
	color: #1D1D1F;
	margin-bottom: 30px;
}

.result-icon {
	font-size: 48px;
	margin-bottom: 16px;
	color: <%= isSuccess ? "#4CAF50" : "#E53935" %>;
}

.btn {
	display: inline-block;
	padding: 10px 24px;
	background-color: #4285F4;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	font-size: 16px;
}

.btn:hover {
	background-color: #3367d6;
}
</style>
</head>
<body>
	<div class="container">
		<div class="result-icon"><%= isSuccess ? "✓" : "✖" %></div>
		<h2><%=bundle.getString("review.result")%></h2>
		<p><%= resultMessage %></p>
		<a href="Emerlet" class="btn"><%=bundle.getString("filter.backToMap")%></a>
	</div>
</body>
</html>
