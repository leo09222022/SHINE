<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<h2>공중화장실 필터링</h2>

		<div class="filter-count">
			<c:choose>
				<c:when test="${fn:length(toilets) > 0}">
					<strong>${fn:length(toilets)}</strong>개의 화장실이 검색되었습니다.
        </c:when>
				<c:otherwise>
					<strong>0개</strong>의 화장실이 검색되었습니다.
        </c:otherwise>
			</c:choose>
		</div>

		<form id="filterForm" action="ToiletFilteringServlet" method="get">
			<!-- 남자화장실 -->
			<div class="filter-option">
				<div class="filter-icon-text">
					<img src="img/toggle_man.svg" /> <span>남자화장실</span>
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
					<img src="img/toggle_woman.svg" /> <span>여자화장실</span>
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
					<img src="img/toggle_baby.svg" /> <span>기저귀 교환대</span>
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
					<img src="img/toggle_dis.svg" /> <span>장애인 이용 가능</span>
				</div>
				<label class="switch"> <input type="checkbox"
					name="hasDisabledToilet"
					<c:if test="${hasDisabledToilet eq 'Y'}">checked</c:if> /> <span
					class="slider"></span>
				</label>
			</div>


			<input type="hidden" name="viewMap" value="true">
			<button type="submit">필터 적용 &amp; 지도로 돌아가기</button>
		</form>

		<a href="ToiletFilteringServlet?resetFilters=true" class="reset-link">필터
			초기화</a>
	</div>
</body>
</html>
