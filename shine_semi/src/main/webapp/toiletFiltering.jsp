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
<%
String currentLang = (String) session.getAttribute("lang");
if (currentLang == null)
	currentLang = "ko";
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Emerlet</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Pretendard Font -->
<link
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
	rel="stylesheet" />

<style>
body {
	font-family: 'Pretendard', sans-serif;
	background-color: #F8F7F7;
	margin: 0;
	padding: 0;
	color: #1D1D1F;
}

.container {
	max-width: 480px;
	margin: 0 auto;
	padding: 24px 20px;
	background-color: white;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

h2 {
	font-size: 24px;
	text-align: center;
	color: #3A81FF;
	margin-bottom: 24px;
}

.filter-count {
	text-align: center;
	font-size: 16px;
	margin-bottom: 20px;
	color: #555;
}

form#filterForm>div {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 16px;
	font-size: 16px;
}

input[type="checkbox"] {
	width: 20px;
	height: 20px;
	accent-color: #3A81FF;
}

label {
	cursor: pointer;
}

button[type="submit"] {
	width: 100%;
	background-color: #3A81FF;
	color: white;
	border: none;
	padding: 12px;
	font-size: 16px;
	border-radius: 100px;
	font-weight: 600;
	margin-top: 20px;
	cursor: pointer;
}

button[type="submit"]:hover {
	background-color: #2b6edb;
}

a.reset-link {
	display: block;
	text-align: center;
	margin-top: 16px;
	color: #3A81FF;
	font-weight: bold;
	text-decoration: none;
}

a.reset-link:hover {
	text-decoration: underline;
}

.icon {
	font-size: 20px;
}

.filter-option {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	font-size: 16px;
	border-bottom: 1px solid #eee;
}

.filter-icon-text {
	display: flex;
	align-items: center;
	gap: 8px;
}

/* 토글 스위치 */
.switch {
	position: relative;
	display: inline-block;
	width: 40px;
	height: 24px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: 0.3s;
	border-radius: 24px;
}

.slider:before {
	position: absolute;
	content: "";
	height: 16px;
	width: 16px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: 0.3s;
	border-radius: 50%;
}

.switch input:checked+.slider {
	background-color: #3A81FF;
}

.switch input:checked+.slider:before {
	transform: translateX(16px);
}
</style>
</head>
<body>
	<div class="container">
		<h2><%=bundle.getString("menu.filter")%></h2>

		<div class="filter-count">
			<c:choose>
				<c:when test="${fn:length(toilets) > 0}">
					<strong>${fn:length(toilets)}</strong><%=bundle.getString("filter.result")%>
        </c:when>
				<c:otherwise>
					<strong>0</strong><%=bundle.getString("filter.result")%>
        </c:otherwise>
			</c:choose>
		</div>

		<form id="filterForm" action="ToiletFilteringServlet" method="get">
			<!-- 남자화장실 -->
			<div class="filter-option">
				<div class="filter-icon-text">
					<img src="img/toggle_man.svg" /> <span><%=bundle.getString("filter.male")%></span>
				</div>
				<label class="switch"> <input type="checkbox"
					name="hasMaleToilet"
					<c:if test="${hasMaleToilet eq 'Y'}">checked</c:if> /> <span
					class="slider"></span>
				</label>
			</div>

			<!-- 여자화장실 -->
			<div class="filter-option">
				<div class="filter-icon-text">
					<img src="img/toggle_woman.svg" /> <span><%=bundle.getString("filter.female")%></span>
				</div>
				<label class="switch"> <input type="checkbox"
					name="hasFemaleToilet"
					<c:if test="${hasFemaleToilet eq 'Y'}">checked</c:if> /> <span
					class="slider"></span>
				</label>
			</div>

			<!-- 기저귀 교환대 -->
			<div class="filter-option">
				<div class="filter-icon-text">
					<img src="img/toggle_baby.svg" /> <span><%=bundle.getString("filter.diaper")%></span>
				</div>
				<label class="switch"> <input type="checkbox"
					name="hasDiaperTable"
					<c:if test="${hasDiaperTable eq 'Y'}">checked</c:if> /> <span
					class="slider"></span>
				</label>
			</div>

			<!-- 장애인 화장실 -->
			<div class="filter-option">
				<div class="filter-icon-text">
					<img src="img/toggle_dis.svg" /> <span><%=bundle.getString("filter.disabled")%></span>
				</div>
				<label class="switch"> <input type="checkbox"
					name="hasDisabledToilet"
					<c:if test="${hasDisabledToilet eq 'Y'}">checked</c:if> /> <span
					class="slider"></span>
				</label>
			</div>


			<input type="hidden" name="viewMap" value="true">
			<button type="submit"><%=bundle.getString("filter.apply")%> &amp; <%=bundle.getString("filter.backToMap")%></button>
		</form>

		<a href="ToiletFilteringServlet?resetFilters=true" class="reset-link"><%=bundle.getString("menu.filter")%>
			<%=bundle.getString("filter.reset")%></a>
	</div>

	<!-- 랭귀지 관련 함수 -->
	<!-- onclick에 세션이벤트까지 같이 하는방식으로 수정해야되는데 귀찮으므로 일단 둠 -->
	<script>
function reloadGoogleMapScript(langCode) {
  const oldScript = document.querySelector('script[src*="maps.googleapis.com"]');
  if (oldScript) oldScript.remove();

  const newScript = document.createElement("script");
  newScript.src = `https://maps.googleapis.com/maps/api/js?key=<%=application.getAttribute("google_map_api")%>
		&callback=initMap&language=${langCode}`;
			newScript.async = true;
			document.head.appendChild(newScript);
		}
	</script>



	<!-- 구글맵이 외부 JS보다 나중에 호출되어야함 위치변경 금지 -->
	<!-- 랭귀지 관련 파라메터 추가함 -->
	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap&language=<%= lang %>"></script>


</body>
</html>
