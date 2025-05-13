<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="com.emerlet.dao.UserToiletDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>

<%
String lang = (String) session.getAttribute("lang");
if (lang == null) lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

int toiletID = Integer.parseInt(request.getParameter("userToiletID"));
UserToiletDAO dao = new UserToiletDAO();
UserToiletVO vo = dao.findByID(toiletID);
request.setAttribute("vo", vo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Emerlet</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css">
<style>
.container {
	max-width: 800px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	border-radius: 5px;
}

h2 {
	color: #3A81FF;
	font-size: 24px;
	text-align: center;
	margin-bottom: 24px;
}

p {
	margin: 8px 0;
	color: #1D1D1F;
	font-size: 16px;
}

strong {
	font-size: 18px;
}

.form-group {
	margin-top: 20px;
}

.rating {
	display: flex;
	flex-direction: row-reverse;
	gap: 4px;
	margin-top: 6px;
}

.rating input {
	display: none;
}

.rating label {
	cursor: pointer;
	width: 24px;
	height: 24px;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cpath d='M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z' fill='%23e0e0e0'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: center;
	background-size: contain;
}

.rating input:checked ~ label,
.rating label:hover,
.rating input:checked+label:hover,
.rating input:checked ~ label:hover {
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cpath d='M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z' fill='%23f5bc00'/%3E%3C/svg%3E");
}

.sub-tit {
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 6px;
}

button {
	width: 100%;
	padding: 12px;
	background-color: #4285F4;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	margin-top: 24px;
	cursor: pointer;
}

button:disabled {
	background-color: #bbb;
	cursor: not-allowed;
}

button:hover:enabled {
	background-color: #3367d6;
}
</style>
<script>
function checkSelection() {
  const cleanliness = document.querySelector('input[name="cleanliness"]:checked');
  const safety = document.querySelector('input[name="safety"]:checked');
  const submitBtn = document.getElementById('submitBtn');
  submitBtn.disabled = !(cleanliness && safety);
}

window.onload = function() {
  document.querySelectorAll('input[type="radio"]').forEach(radio => {
    radio.addEventListener('change', checkSelection);
  });
  checkSelection();
};
</script>
</head>
<body>
<div class="container">
			<div style="display:flex; flex-direction: row-reverse; gap:4px; cursor:pointer;" onclick="location.href='index.html'">
	<img src="img/back_page.svg"/>
	<div style="display:flex; justify-content:center; aligns-item:center;">돌아가기</div>
	</div>

	<div class="sn-title"><%=bundle.getString("toilet.review")%></div>

	<p><strong><%=vo.getUserName()%></strong></p>
	<p><%=vo.getUserRoadAddress()%></p>

	<form action="insertReviewUserToiletOK.jsp" method="post">
		<input type="hidden" name="userToiletId" value="${vo.userToiletId}">

		<div class="form-group">
			<label class="sub-tit"><%=bundle.getString("toilet.cleanliness")%></label>
			<div class="rating">
				<input type="radio" id="cleanliness5" name="cleanliness" value="5">
				<label for="cleanliness5" title="5점"></label>
				<input type="radio" id="cleanliness4" name="cleanliness" value="4">
				<label for="cleanliness4" title="4점"></label>
				<input type="radio" id="cleanliness3" name="cleanliness" value="3">
				<label for="cleanliness3" title="3점"></label>
				<input type="radio" id="cleanliness2" name="cleanliness" value="2">
				<label for="cleanliness2" title="2점"></label>
				<input type="radio" id="cleanliness1" name="cleanliness" value="1">
				<label for="cleanliness1" title="1점"></label>
			</div>
		</div>

		<div class="form-group">
			<label class="sub-tit"><%=bundle.getString("toilet.safety")%></label>
			<div class="rating">
				<input type="radio" id="safety5" name="safety" value="5">
				<label for="safety5" title="5점"></label>
				<input type="radio" id="safety4" name="safety" value="4">
				<label for="safety4" title="4점"></label>
				<input type="radio" id="safety3" name="safety" value="3">
				<label for="safety3" title="3점"></label>
				<input type="radio" id="safety2" name="safety" value="2">
				<label for="safety2" title="2점"></label>
				<input type="radio" id="safety1" name="safety" value="1">
				<label for="safety1" title="1점"></label>
			</div>
		</div>

		<button id="submitBtn" type="submit" disabled>
			<%=bundle.getString("review.submit")%>
		</button>
	</form>
</div>
</body>
</html>
