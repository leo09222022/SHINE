<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>필터링</title>
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

/* 토글 스위치 스타일 */
.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 24px;
  margin-right: 15px;
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
  transition: .4s;
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
  transition: .4s;
  border-radius: 50%;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:checked + .slider:before {
  transform: translateX(26px);
}
</style>
</head>
<body>
	<div class="container">
		<h2>공중화장실 필터링</h2>

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
				<label class="switch">
                    <input type="checkbox" id="hasMaleToilet" name="hasMaleToilet"
                        value="Y" <c:if test="${hasMaleToilet eq 'Y'}">checked</c:if>>
                    <span class="slider"></span>
                </label>
				<span class="feature-icon">🚹</span> <label for="hasMaleToilet">남자화장실</label>
			</div>

			<div class="filter-option">
				<label class="switch">
                    <input type="checkbox" id="hasFemaleToilet" name="hasFemaleToilet"
                        value="Y" <c:if test="${hasFemaleToilet eq 'Y'}">checked</c:if>>
                    <span class="slider"></span>
                </label>
				<span class="feature-icon">🚺</span> <label for="hasFemaleToilet">여자화장실</label>
			</div>

			<div class="filter-option">
				<label class="switch">
                    <input type="checkbox" id="hasMaleDisabledToilet" name="hasMaleDisabledToilet"
                        value="Y" <c:if test="${hasMaleDisabledToilet eq 'Y'}">checked</c:if>>
                    <span class="slider"></span>
                </label>
				<span class="feature-icon">♿</span> <label for="hasMaleDisabledToilet">남성 장애인 화장실</label>
			</div>

			<div class="filter-option">
				<label class="switch">
                    <input type="checkbox" id="hasFemaleDisabledToilet" name="hasFemaleDisabledToilet"
                        value="Y" <c:if test="${hasFemaleDisabledToilet eq 'Y'}">checked</c:if>>
                    <span class="slider"></span>
                </label>
				<span class="feature-icon">♿</span> <label for="hasFemaleDisabledToilet">여성 장애인 화장실</label>
			</div>

			<div class="filter-option">
				<label class="switch">
                    <input type="checkbox" id="hasDiaperTable" name="hasDiaperTable"
                        value="Y" <c:if test="${hasDiaperTable eq 'Y'}">checked</c:if>>
                    <span class="slider"></span>
                </label>
				<span class="feature-icon">👶</span> <label for="hasDiaperTable">기저귀 교환대</label>
			</div>

			<input type="hidden" name="viewMap" value="true">
			<button type="submit" class="btn btn-primary">필터 적용 &amp; 지도로 돌아가기</button>
		</form>

		<a href="ToiletFilteringServlet?resetFilters=true"
			class="btn btn-secondary">필터 초기화</a>
	</div>
</body>
</html>