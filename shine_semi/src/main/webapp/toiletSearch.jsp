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
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>화장실 검색</title>
<link rel="stylesheet" href="css/mo_style.css" />
<style>
body {
    font-family: 'Pretendard', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f7f7;
}

.menu-header {
    width: 100%;
    height: 48px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 12px 20px;
    background: #FFFFFF;
    box-sizing: border-box;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
    min-height: calc(100vh - 48px);
    display: flex;
    flex-direction: column;
}

h2 {
    margin-top: 0;
    padding-bottom: 10px;
    color: #1D1D1F;
    font-size: 20px;
    font-weight: 500;
}

.search-form-container {
    position: relative;
    margin-bottom: 20px;
}

.search-input {
    width: 100%;
    padding: 12px 40px 12px 12px;
    border: 1px solid #CECECE;
    border-radius: 100px;
    font-size: 16px;
    font-family: 'Pretendard', sans-serif;
    box-sizing: border-box;
}

.search-button {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    cursor: pointer;
}

.search-button img {
    width: 24px;
    height: 24px;
}

/* 자동완성 스타일 */
.autocomplete-container {
    position: relative;
    width: 100%;
}

.autocomplete-items {
    position: absolute;
    border: 1px solid #d4d4d4;
    border-top: none;
    z-index: 99;
    top: 100%;
    left: 0;
    right: 0;
    max-height: 400px;
    overflow-y: auto;
    background-color: white;
    border-radius: 0 0 12px 12px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    display: none;
}

.autocomplete-item {
    padding: 12px 15px;
    cursor: pointer;
    border-bottom: 1px solid #f1f1f1;
}

.autocomplete-item:last-child {
    border-bottom: none;
}

.autocomplete-item:hover {
    background-color: #f8f9fa;
}

.autocomplete-active {
    background-color: #3A81FF !important;
    color: white !important;
}

.autocomplete-active .highlight {
    color: white !important;
}

.highlight {
    font-weight: bold;
    color: #3A81FF;
}

.back-link {
    display: inline-block;
    margin-top: auto;
    padding: 12px 0;
    background-color: #3A81FF;
    color: white;
    text-decoration: none;
    border-radius: 100px;
    font-weight: 500;
    text-align: center;
    font-size: 16px;
    width: 100%;
    box-sizing: border-box;
}

.back-link:hover {
    background-color: #2a6cd4;
}

/* 메인 페이지 스타일과 유사한 모양 */
.search-item {
    display: flex;
    flex-direction: column;
    padding: 12px 16px;
}

.place-name {
    font-size: 16px;
    font-weight: 500;
    color: #000;
    margin-bottom: 4px;
}

.place-address {
    font-size: 14px;
    color: #666;
}

.no-results {
    text-align: center;
    padding: 20px;
    margin-top: 20px;
    font-size: 16px;
    color: #666;
}
</style>
</head>
<body>
    <div class="menu-header">
        <img class="cursor" src="img/logo_row.svg" onclick="location.href='index.html'">
        <img class="cursor" src="img/pop__close.svg" onclick="location.href='map'" />
    </div>

    <div class="container">
        <h2>화장실 검색</h2>
        
        <div class="search-form-container">
            <div class="autocomplete-container">
                <input type="text" id="searchInput" name="keyword" 
                       placeholder="주소 또는 지역명을 입력하세요" 
                       class="search-input" value="<c:out value="${param.keyword}"/>" autocomplete="off">
                <button type="button" id="searchButton" class="search-button" onclick="submitSearch()">
                    <img src="img/searchbar_marker.svg" alt="검색">
                </button>
                <div id="autocompleteItems" class="autocomplete-items"></div>
            </div>
        </div>
        
        <c:if test="${empty searchResults && not empty param.keyword}">
            <div class="no-results">
                검색 결과가 없습니다. 다른 키워드로 검색해보세요.
            </div>
        </c:if>
        
        <a href="map" class="back-link">지도로 돌아가기</a>
    </div>
    
    <!-- 화장실 데이터 전역으로 전달 -->
    <script>
        // 전역 변수로 화장실 데이터 설정
        window.searchKeyword = "<c:out value="${param.keyword}"/>";
        
        // 화장실 데이터 배열 초기화
        window.allToilets = [];
        window.searchResults = [];
        
        // 검색 결과 데이터 로드
        <c:if test="${not empty searchResults}">
            window.searchResults = [
                <c:forEach var="toilet" items="${searchResults}" varStatus="status">
                {
                    name: "<c:out value="${toilet.name}"/>",
                    address: "<c:out value="${toilet.addressRoad}"/>",
                    lat: ${toilet.lat},
                    lng: ${toilet.lng}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];
        </c:if>
        
        // 전체 화장실 데이터 로드
        <c:if test="${not empty toilets}">
            window.allToilets = [
                <c:forEach var="toilet" items="${toilets}" varStatus="status">
                {
                    name: "<c:out value="${toilet.name}"/>",
                    address: "<c:out value="${toilet.addressRoad}"/>",
                    lat: ${toilet.lat},
                    lng: ${toilet.lng}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];
        </c:if>
    </script>
    
    <!-- 자동완성 기능을 위한 JavaScript 파일 -->
    <script src="js/search.js"></script>
</body>
</html>