<%@page import="com.emerlet.dao.ToiletDAO"%>
<%@page import="com.emerlet.vo.ToiletVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<%
    int userToiletId = Integer.parseInt(request.getParameter("toiletID"));
	ToiletDAO dao = new ToiletDAO();
	ToiletVO vo = dao.findByID(userToiletId);
	request.setAttribute("vo", vo);
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Emerlet</title>
<script>
// 제출 버튼 활성화 검사 함수
function checkSelection() {
  const cleanliness = document.querySelector('input[name="cleanliness"]:checked');
  const safety = document.querySelector('input[name="safety"]:checked');
  const submitBtn = document.getElementById('submitBtn');

  // 두 항목이 모두 선택되었을 때만 버튼 활성화
  if (cleanliness && safety) {
    submitBtn.disabled = false;
  } else {
    submitBtn.disabled = true;
  }
}

// 페이지 로딩 시 검사 + 이벤트 연결
window.onload = function() {
  const radios = document.querySelectorAll('input[type="radio"]');
  radios.forEach(radio => {
    radio.addEventListener('change', checkSelection);
  });
  checkSelection(); // 초기 상태 검사
};
</script>
</head>
<body>
	<h2><%=bundle.getString("toilet.review")%></h2>
	<form action="insertReviewUserToiletOK.jsp" method="post">
		<input type="hidden" name="userToiletId" value="${vo.userToiletId}">
		<p><%=bundle.getString("toilet.cleanliness")%>:</p>
		<%
		for (int i = 1; i <= 5; i++) {
		%>
		<label><input type="radio" name="cleanliness" value="<%=i%>"><%=i%></label>
		<%
		}
		%>

		<p><%=bundle.getString("toilet.safety")%>:</p>
		<%
		for (int i = 1; i <= 5; i++) {
		%>
		<label><input type="radio" name="safety" value="<%=i%>"><%=i%></label>
		<%
		}
		%>
		<br>
		<button id="submitBtn" type="submit" disabled><%=bundle.getString("review.submit")%></button>
	</form>
</body>
</html>