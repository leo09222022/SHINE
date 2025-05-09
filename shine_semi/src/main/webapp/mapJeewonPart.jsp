<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

#map {
	width: 100%;
	height: calc(100vh - 50px);
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	background: #f1f1f1;
	height: 30px;
}

h2 {
	margin: 0;
	font-size: 20px;
}

.filter-link {
	background-color: #4285F4;
	color: white;
	text-decoration: none;
	padding: 8px 12px;
	border-radius: 4px;
	font-size: 14px;
	transition: background-color 0.3s;
	margin-left: 8px;
}

.filter-link:hover {
	background-color: #3367d6;
}

.add-toilet-link {
	background-color: #34A853;
	color: white;
	text-decoration: none;
	padding: 8px 12px;
	border-radius: 4px;
	font-size: 14px;
	transition: background-color 0.3s;
}

.add-toilet-link:hover {
	background-color: #2E8B57;
}

.filter-badge {
	display: inline-flex;
	align-items: center;
	background-color: #e8f0fe;
	padding: 5px 10px;
	border-radius: 20px;
	margin-left: 10px;
	font-size: 14px;
	color: #1a73e8;
}

.filter-badge .icon {
	margin-right: 5px;
}

.clear-filters {
	cursor: pointer;
	margin-left: 8px;
	color: #5f6368;
	font-size: 18px;
	text-decoration: none;
}

.clear-filters:hover {
	color: #d93025;
}

/* 검색 폼 스타일 */
.search-container {
    display: flex;
    align-items: center;
    margin-left: 15px;
    flex-grow: 1;
    max-width: 400px;
}

.search-form {
    display: flex;
    width: 100%;
}

.search-input {
    flex-grow: 1;
    padding: 6px 10px;
    border: 1px solid #ccc;
    border-radius: 4px 0 0 4px;
    font-size: 14px;
}

.search-button {
    background-color: #4285F4;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 0 4px 4px 0;
    cursor: pointer;
    font-size: 14px;
}

.search-button:hover {
    background-color: #3367d6;
}

.search-badge {
    display: inline-flex;
    align-items: center;
    background-color: #fde293;
    padding: 5px 10px;
    border-radius: 20px;
    margin-left: 10px;
    font-size: 14px;
    color: #5f6368;
}

.reset-search {
    cursor: pointer;
    margin-left: 8px;
    color: #5f6368;
    font-size: 18px;
    text-decoration: none;
}

.reset-search:hover {
    color: #d93025;
}

.actions-container {
    display: flex;
    align-items: center;
}
</style>

<div class="header">
	<div style="display: flex; align-items: center;">
		<%-- 세션에서 검색 상태 확인 --%>
		<c:if test="${sessionScope.isSearched}">
			<div class="search-badge">
				<span>"${sessionScope.searchKeyword}" 검색결과: ${fn:length(sessionScope.searchToilets)}개</span>
				<a href="ToiletSearchServlet" class="reset-search" title="검색 초기화">×</a>
			</div>
		</c:if>
		
		<%-- 세션에서 필터링 상태 확인 --%>
		<c:if test="${sessionScope.isFiltered}">
			<div class="filter-badge">
				<span>필터 적용됨</span>
				<c:if test="${sessionScope.hasMaleToilet eq 'Y'}">
					<span class="icon">🚹</span>
				</c:if>
				<c:if test="${sessionScope.hasFemaleToilet eq 'Y'}">
					<span class="icon">🚺</span>
				</c:if>
				<c:if test="${sessionScope.hasMaleDisabledToilet eq 'Y' || sessionScope.hasFemaleDisabledToilet eq 'Y'}">
					<span class="icon">♿</span>
				</c:if>
				<c:if test="${sessionScope.hasDiaperTable eq 'Y'}">
					<span class="icon">👶</span>
				</c:if>
				<a href="ToiletFilteringServlet?resetFilters=true"
					class="clear-filters" title="필터 초기화">×</a>
			</div>
		</c:if>
	</div>
	
	<!-- 검색 폼 -->
	<div class="search-container">
		<form class="search-form" action="toiletSearch" method="get">
			<input type="text" name="keyword" placeholder="주소로 검색 (예: 세종)" 
				class="search-input" value="${sessionScope.searchKeyword}">
			<button type="submit" class="search-button">검색</button>
		</form>
	</div>

	<!-- 버튼 컨테이너: 필터링 버튼과 화장실 등록 버튼 -->
	<div class="actions-container">
		<a href="toiletFiltering.do" class="filter-link">화장실 필터링</a>
		<a href="toiletAdd.do" class="add-toilet-link">화장실 등록</a>
	</div>
</div>