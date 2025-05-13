<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.emerlet.db.ConnectionProvider"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<%
int toiletId = Integer.parseInt(request.getParameter("toiletId"));
  String cleanliness = request.getParameter("cleanliness");
  String safety = request.getParameter("safety");
  
  int result = 0;

  try {
  	Connection conn = ConnectionProvider.getConnection();
  	String sql = "INSERT INTO reviews (review_id, cleanliness, safety, created_at, user_toilet_id) VALUES ((SELECT NVL(MAX(review_id), 0) + 1 FROM reviews), ?, ?, SYSDATE, ?)";

  	PreparedStatement pstmt = conn.prepareStatement(sql);
  	pstmt.setString(1, cleanliness);
  	pstmt.setString(2, safety);
  	pstmt.setInt(3, toiletId);
  	
  	result = pstmt.executeUpdate();

	pstmt.close();
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>
	<%
String resultMessage = result > 0 
    ? bundle.getString("review.ok") 
    : bundle.getString("review.notOk");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=bundle.getString("review.result")%></title>
</head>
<body>
	<h2>📢 <%=bundle.getString("review.result")%></h2>
	<p><%= resultMessage %></p>
	<a href="Emerlet"><%=bundle.getString("filter.backToMap")%></a>
</body>
</html>

