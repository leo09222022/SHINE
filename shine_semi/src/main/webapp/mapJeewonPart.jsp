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
}

.filter-link:hover {
	background-color: #3367d6;
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
</style>

<div class="header">
	<div style="display: flex; align-items: center;">
		<%-- 세션에서 필터링 상태 확인 --%>
		<c:if test="${sessionScope.isFiltered}">
			<div class="filter-badge">
				<span>필터 적용됨</span>
				<c:if test="${sessionScope.hasEmergencyBell eq 'Y'}">
					<span class="icon">🔔</span>
				</c:if>
				<c:if test="${sessionScope.hasCctv eq 'Y'}">
					<span class="icon">📹</span>
				</c:if>
				<c:if test="${sessionScope.hasDiaperTable eq 'Y'}">
					<span class="icon">👶</span>
				</c:if>
				<a href="ToiletFilteringServlet?resetFilters=true"
					class="clear-filters" title="필터 초기화">×</a>
			</div>
		</c:if>
	</div>

	<a href="toiletFiltering.do" class="filter-link">화장실 필터링</a>
</div>