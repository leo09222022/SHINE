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

.search-link {
    background-color: #FF9800;
    color: white;
    text-decoration: none;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 14px;
    transition: background-color 0.3s;
    margin-left: 8px;
}

.search-link:hover {
    background-color: #F57C00;
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

.actions-container {
    display: flex;
    align-items: center;
}
</style>

<div class="header">
	<div style="display: flex; align-items: center;">
		<%-- 필터링 상태 확인 --%>
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

	<!-- 버튼 컨테이너: 검색 버튼, 필터링 버튼, 화장실 등록 버튼 -->
	<div class="actions-container">
		<a href="toiletSearch.do" class="search-link">화장실 검색</a>
		<a href="toiletFiltering.do" class="filter-link">화장실 필터링</a>
		<a href="toiletAdd.do" class="add-toilet-link">화장실 등록</a>
	</div>
</div>

<script>
// 검색된 화장실 파라미터 처리
document.addEventListener("DOMContentLoaded", function() {
    // URL 파라미터에서 선택된 화장실 좌표 확인
    const urlParams = new URLSearchParams(window.location.search);
    const selectLat = urlParams.get('select_lat');
    const selectLng = urlParams.get('select_lng');
    
    if (selectLat && selectLng) {
        // 전역 변수에 선택된 좌표 저장 (map.jsp의 initMap에서 사용)
        window.selectedToiletLat = parseFloat(selectLat);
        window.selectedToiletLng = parseFloat(selectLng);
    }
});
</script>

<script>
// map.jsp에서 사용하기 위한 함수 추가
// 선택된 화장실이 있을 경우 해당 화장실로 지도 이동 및 정보창 표시
window.onload = function() {
    const selectLat = "${param.select_lat}";
    const selectLng = "${param.select_lng}";
    
    if (selectLat && selectLng) {
        const selectedLocation = {
            lat: parseFloat(selectLat),
            lng: parseFloat(selectLng)
        };
        
        // 선택된 위치로 지도 이동
        setTimeout(function() {
            if (window.map) {
                window.map.setCenter(selectedLocation);
                window.map.setZoom(18); // 더 가까이 줌인
                
                // 모든 마커를 확인하여 선택된 위치의 마커를 찾고 정보창 표시
                if (window.markers) {
                    for (let i = 0; i < window.markers.length; i++) {
                        const markerPosition = window.markers[i].getPosition();
                        if (Math.abs(markerPosition.lat() - selectedLocation.lat) < 0.000001 && 
                            Math.abs(markerPosition.lng() - selectedLocation.lng) < 0.000001) {
                            
                            // 마커 클릭 이벤트 트리거
                            google.maps.event.trigger(window.markers[i], 'click');
                            break;
                        }
                    }
                }
            }
        }, 1000); // 지도가 완전히 로드된 후에 실행되도록 지연
    }
};
</script>