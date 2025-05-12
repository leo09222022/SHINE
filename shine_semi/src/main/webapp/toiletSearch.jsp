<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>화장실 검색</title>
<link rel="stylesheet" href="css/style.css" />
<link
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
	rel="stylesheet" />
<style>
.search-container {
	width: 100%;
	padding: 20px;
	background: white;
}

h2 {
	color: #3A81FF;
	margin-bottom: 24px;
	font-size: 24px;
	font-weight: 600;
}

form {
	display: flex;
	gap: 10px;
	margin-bottom: 20px;
	justify-content: center;
}

input[type="text"] {
	width: 90%;
	padding: 10px 14px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 16px;
}

button[type="submit"] {
	flex-shrink: 0; /* 버튼이 줄어들지 않게 고정 */
	padding: 10px 16px;
	background-color: #3A81FF;
	color: white;
	border: none;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

.result-message {
	margin-bottom: 16px;
	font-size: 16px;
}

ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

li {
	background: #f1f4ff;
	padding: 14px;
	margin-bottom: 10px;
	border-radius: 8px;
	cursor: pointer;
}

li:hover {
	background: #dbe7ff;
}

li span {
	background: yellow;
	font-weight: 600;
}

a {
	display: inline-block;
	margin-top: 20px;
	color: #3A81FF;
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="search-container">
		<h2><%=bundle.getString("search.title")%></h2>

		<form action="toiletSearch.do" method="get"
			style="display: flex; justify-content: center;">
			<input type="text" name="keyword"
				placeholder="<%=bundle.getString("search.placeholder")%>"
				value="${param.keyword}" />
			<button type="submit"><%=bundle.getString("search.button")%></button>
		</form>

		<c:if test="${not empty param.keyword}">
			<div class="result-message">
				<c:choose>
					<c:when test="${fn:length(searchResults) > 0}">
						<fmt:message key="search.result.found">
							<fmt:param value="${param.keyword}" />
							<fmt:param value="${fn:length(searchResults)}" />
						</fmt:message>
					</c:when>

					<c:otherwise>
						<fmt:message key="search.result.empty">
							<fmt:param value="${param.keyword}" />
						</fmt:message>
					</c:otherwise>

				</c:choose>
			</div>
		</c:if>

		<a href="map"
			style="display: block; text-align: center; margin: 20px; color: #3A81FF; font-weight: bold; text-decoration: none;">
			<%=bundle.getString("search.backToMap")%>
		</a>


		<c:if test="${fn:length(searchResults) > 0}">
			<ul>
				<c:forEach var="toilet" items="${searchResults}">
					<li onclick="goToMap(${toilet.lat}, ${toilet.lng})">
						<div>
							<strong>${toilet.name}</strong>
						</div>
						<div>
							<c:set var="address" value="${toilet.addressRoad}" />
							<c:set var="keyword" value="${param.keyword}" />
							<c:choose>
								<c:when
									test="${fn:contains(fn:toLowerCase(address), fn:toLowerCase(keyword))}">
									<c:set var="lowerAddress" value="${fn:toLowerCase(address)}" />
									<c:set var="lowerKeyword" value="${fn:toLowerCase(keyword)}" />
									<c:set var="startIndex"
										value="${fn:indexOf(lowerAddress, lowerKeyword)}" />
									<c:set var="endIndex"
										value="${startIndex + fn:length(keyword)}" />
                  ${fn:substring(address, 0, startIndex)}<span>${fn:substring(address, startIndex, endIndex)}</span>${fn:substring(address, endIndex, fn:length(address))}
                </c:when>
								<c:otherwise>
                  ${address}
                </c:otherwise>
							</c:choose>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:if>

		<c:if
			test="${not empty param.keyword && fn:length(searchResults) == 0}">
			<div class="result-message"><%=bundle.getString("search.result.none")%></div>
		</c:if>


	</div>

	<script>
    function goToMap(lat, lng) {
      sessionStorage.setItem("selectedToiletLat", lat);
      sessionStorage.setItem("selectedToiletLng", lng);
      window.location.href = "map";
    }
  </script>
</body>
</html>
