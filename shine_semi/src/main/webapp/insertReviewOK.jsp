<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int result = (int) request.getAttribute("result");
%>
<h2>리뷰 등록 결과</h2>
<% if (result > 0) { %>
    <p>리뷰가 성공적으로 등록되었습니다.</p>
<% } else { %>
    <p>리뷰 등록에 실패했습니다.</p>
<% } %>
<a href="findReview.do?toiletId=<%= request.getParameter("toiletId") %>&userToiletId=<%= request.getParameter("userToiletId") %>">리뷰 목록 보기</a>

</body>
</html>