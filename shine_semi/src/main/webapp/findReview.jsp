<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.emerlet.vo.ReviewVO" %>
<%
    List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("reviews");

    double avgClean = 0;
    double avgSafe = 0;

    if (list != null && !list.isEmpty()) {
        int sumClean = 0;
        int sumSafe = 0;
        for (ReviewVO review : list) {
            sumClean += review.getCleanliness();
            sumSafe += review.getSafety();
        }
        avgClean = sumClean * 1.0 / list.size();
        avgSafe = sumSafe * 1.0 / list.size();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Emerlet</title>
</head>
<body>
<h2>리뷰 목록</h2>
<% if (list == null || list.isEmpty()) { %>
    <p>등록된 리뷰가 없습니다.</p>
<% } else { %>
    <p>평균 청결도: <%= String.format("%.1f", avgClean) %></p>
    <p>평균 안전도: <%= String.format("%.1f", avgSafe) %></p>
<!-- 
    <table border="1">
        <tr>
            <th>청결도</th>
            <th>안전도</th>
            <th>작성일시</th>
        </tr>
        <% for (ReviewVO review : list) { %>
        <tr>
            <td><%= review.getCleanliness() %></td>
            <td><%= review.getSafety() %></td>
            <td><%= review.getCreatedAt() %></td>
        </tr>
        <% } %>
    </table>
    
     -->
<% } %>
</body>
</html>