<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>화장실 검색</title>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

.container {
    max-width: 800px;
    margin: 20px auto;
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
}

.search-form {
    display: flex;
    margin-bottom: 20px;
}

.search-input {
    flex-grow: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px 0 0 4px;
    font-size: 16px;
}

.search-button {
    padding: 10px 20px;
    background-color: #FF9800;
    color: white;
    border: none;
    border-radius: 0 4px 4px 0;
    cursor: pointer;
    font-size: 16px;
}

.search-button:hover {
    background-color: #F57C00;
}

.result-stats {
    margin-bottom: 15px;
    color: #666;
}

.result-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.result-item {
    padding: 15px;
    border-bottom: 1px solid #eee;
    transition: background-color 0.2s;
    cursor: pointer;
}

.result-item:hover {
    background-color: #f9f9f9;
}

.result-item:last-child {
    border-bottom: none;
}

.result-name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
}

.result-address {
    color: #666;
}

.highlight {
    font-weight: bold;
    color: #1a73e8;
}

.no-results {
    padding: 20px;
    text-align: center;
    color: #777;
}

.back-link {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #f1f1f1;
    color: #333;
    text-decoration: none;
    border-radius: 4px;
}

.back-link:hover {
    background-color: #e0e0e0;
}
</style>
</head>
<body>
    <div class="container">
        <h2>화장실 검색</h2>
        
        <form action="toiletSearch.do" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="주소 또는 지역명을 입력하세요 (예: 세종대로, 강남구)" 
                   class="search-input" value="${param.keyword}">
            <button type="submit" class="search-button">검색</button>
        </form>
        
        <c:if test="${not empty param.keyword}">
            <div class="result-stats">
                <c:choose>
                    <c:when test="${fn:length(searchResults) > 0}">
                        "${param.keyword}" 검색 결과: ${fn:length(searchResults)}개의 화장실이 발견되었습니다.
                    </c:when>
                    <c:otherwise>
                        "${param.keyword}" 검색 결과가 없습니다.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${fn:length(searchResults) > 0}">
            <ul class="result-list">
                <c:forEach var="toilet" items="${searchResults}">
                    <li class="result-item" onclick="goToMap(${toilet.lat}, ${toilet.lng})">
                        <div class="result-name">${toilet.name}</div>
                        <div class="result-address">
						    <c:set var="address" value="${toilet.addressRoad}" />
						    <c:set var="keyword" value="${param.keyword}" />
						                            
						    <c:choose>
						        <c:when test="${fn:contains(fn:toLowerCase(address), fn:toLowerCase(keyword))}">
						            <c:set var="lowerAddress" value="${fn:toLowerCase(address)}" />
						            <c:set var="lowerKeyword" value="${fn:toLowerCase(keyword)}" />
						            <c:set var="startIndex" value="${fn:indexOf(lowerAddress, lowerKeyword)}" />
						            <c:set var="endIndex" value="${startIndex + fn:length(keyword)}" />
						                        
						            ${fn:substring(address, 0, startIndex)}<span class="highlight">${fn:substring(address, startIndex, endIndex)}</span>${fn:substring(address, endIndex, fn:length(address))}
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
        
        <c:if test="${not empty param.keyword && fn:length(searchResults) == 0}">
            <div class="no-results">
                검색 결과가 없습니다. 다른 키워드로 검색해보세요.
            </div>
        </c:if>
        
        <a href="map" class="back-link">지도로 돌아가기</a>
    </div>
    
    <script>
	    function goToMap(lat, lng) {
	        sessionStorage.setItem('selectedToiletLat', lat);
	        sessionStorage.setItem('selectedToiletLng', lng);
	        window.location.href = "map";
	    }
	</script>
</body>
</html>