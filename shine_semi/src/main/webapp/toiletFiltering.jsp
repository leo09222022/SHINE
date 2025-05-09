<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공중화장실 필터링</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	max-width: 500px;
	margin: 50px auto;
	padding: 20px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h2 {
	margin-top: 0;
	padding-bottom: 10px;
	border-bottom: 1px solid #eee;
	color: #333;
	font-size: 20px;
}

.info-message {
	background-color: #e8f0fe;
	padding: 15px;
	border-radius: 4px;
	margin: 15px 0;
	color: #1a73e8;
	text-align: center;
}

.filter-option {
	display: flex;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px solid #f0f0f0;
}

.filter-option:last-child {
	border-bottom: none;
}

.filter-option input[type="checkbox"] {
	margin-right: 15px;
	transform: scale(1.3);
}

.feature-icon {
	font-size: 24px;
	margin-right: 15px;
	width: 24px;
	text-align: center;
}

.btn {
	display: block;
	width: 100%;
	padding: 12px;
	margin: 10px 0;
	text-align: center;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	font-weight: 500;
	cursor: pointer;
	text-decoration: none;
}

.btn-primary {
	background-color: #4CAF50;
	color: white;
}

.btn-primary:hover {
	background-color: #45a049;
}

.btn-secondary {
	background-color: #4285F4;
	color: white;
}

.btn-secondary:hover {
	background-color: #3367d6;
}
</style>
</head>
<body>
	<div class="container">
		<h2>안전시설 필터 설정</h2>

		<div class="info-message">
			<c:choose>
				<c:when test="${fn:length(toilets) > 0}">
					<strong>${fn:length(toilets)}개</strong>의 화장실이 검색되었습니다.
        </c:when>
				<c:otherwise>
					<strong>0개</strong>의 화장실이 검색되었습니다.
        </c:otherwise>
			</c:choose>
		</div>

		<form id="filterForm" action="ToiletFilteringServlet" method="get">
			<div class="filter-option">
				<input type="checkbox" id="hasEmergencyBell" name="hasEmergencyBell"
					value="Y" <c:if test="${hasEmergencyBell eq 'Y'}">checked</c:if>>
				<span class="feature-icon">🔔</span> <label for="hasEmergencyBell">비상벨
					있음</label>
			</div>

			<div class="filter-option">
				<input type="checkbox" id="hasCctv" name="hasCctv" value="Y"
					<c:if test="${hasCctv eq 'Y'}">checked</c:if>> <span
					class="feature-icon">📹</span> <label for="hasCctv">CCTV
					설치됨</label>
			</div>

			<div class="filter-option">
				<input type="checkbox" id="hasDiaperTable" name="hasDiaperTable"
					value="Y" <c:if test="${hasDiaperTable eq 'Y'}">checked</c:if>>
				<span class="feature-icon">👶</span> <label for="hasDiaperTable">기저귀
					교환대 있음</label>
			</div>

			<input type="hidden" name="viewMap" value="true">
			<button type="submit" class="btn btn-primary">필터 적용 & 지도로
				돌아가기</button>
		</form>

		<a
			href="ToiletFilteringServlet?resetFilters=true&saveMapPosition=true&lat=${sessionScope.mapLat}&lng=${sessionScope.mapLng}&zoom=${sessionScope.mapZoom}"
			class="btn btn-secondary">필터 초기화</a>
	</div>
</body>
</html>