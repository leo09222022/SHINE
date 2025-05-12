<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String toiletId = request.getParameter("toiletId");
    String userToiletId = request.getParameter("userToiletId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>리뷰 작성</h2>
<form action="insertReviewOK.jsp" method="post">
    <!-- <input type="hidden" name="toiletId" value="<%= toiletId != null ? toiletId : "" %>"> -->
    <input type="hidden" name="userToiletId" value="<%= userToiletId != null ? userToiletId : "" %>">
	<input type="hidden" name="toiletId" value="<%= request.getParameter("toiletId") %>">
    <p>청결도:</p>
    <% for (int i = 1; i <= 5; i++) { %>
        <label><input type="radio" name="cleanliness" value="<%=i%>"><%=i%></label>
    <% } %>

    <p>안전도:</p>
    <% for (int i = 1; i <= 5; i++) { %>
        <label><input type="radio" name="safety" value="<%=i%>"><%=i%></label>
    <% } %>

    <button type="submit">리뷰 등록</button>
</form>
<script>
document.querySelector("form").addEventListener("submit", function(e) {
    const cleanliness = document.querySelector("input[name='cleanliness']:checked");
    const safety = document.querySelector("input[name='safety']:checked");
    console.log("cleanliness:", cleanliness?.value);
    console.log("safety:", safety?.value);
});
</script>
</body>
</html>