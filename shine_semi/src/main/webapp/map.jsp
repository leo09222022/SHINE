<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 근처 공중화장실</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

#map {
	width: 100%;
	height: 100vh;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	background: #f1f1f1;
	margin: 0;
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

.legend {
	position: absolute;
	bottom: 20px;
	right: 10px;
	background-color: white;
	padding: 10px;
	border-radius: 4px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	z-index: 1;
	max-width: 200px;
	font-size: 12px;
}

.legend-title {
	font-weight: bold;
	margin-bottom: 5px;
	font-size: 13px;
}

.legend-item {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
}

.legend-color {
	width: 12px;
	height: 12px;
	border-radius: 50%;
	margin-right: 8px;
}

.color-emergency {
	background-color: #FF5252;
}

.color-cctv {
	background-color: #4CAF50;
}

.color-diaper {
	background-color: #2196F3;
}

.color-default {
	background-color: #FF9800;
}

.color-user {
	background-color: #4285F4;
}
</style>
</head>
<body>

	<div class="header">
		<div style="display: flex; align-items: center;">
			<h2>EMERLET</h2>
	
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
	
		<a href="ToiletFilteringServlet" class="filter-link">화장실 필터링</a>
	</div>

	<div id="map"></div>

	<%-- 필터 적용된 경우에만 범례 표시 --%>
	<c:if test="${sessionScope.isFiltered}">
		<div class="legend">
			<div class="legend-title">마커 색상 설명</div>
			<div class="legend-item">
				<span class="legend-color color-emergency"></span> <span>비상벨
					있음</span>
			</div>
			<div class="legend-item">
				<span class="legend-color color-cctv"></span> <span>CCTV 있음</span>
			</div>
			<div class="legend-item">
				<span class="legend-color color-diaper"></span> <span>기저귀 교환대
					있음</span>
			</div>
			<div class="legend-item">
				<span class="legend-color color-default"></span> <span>일반 화장실</span>
			</div>
		</div>
	</c:if>

	<script>
  let map;

  function initMap() {
    const center = { lat: 37.5665, lng: 126.9780 };

    map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: center,
    });

    // 사용자 위치 마커
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const userLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        new google.maps.Marker({
          position: userLocation,
          map: map,
          title: "내 위치",
          icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 8,
            fillColor: "#4285F4",
            fillOpacity: 1,
            strokeColor: "#ffffff",
            strokeWeight: 2,
          }
        });
        map.setCenter(userLocation);
      });
    }

    // 세션에서 필터링된 화장실 데이터가 있는지 확인
    <c:choose>
      <c:when test="${not empty sessionScope.filteredToilets}">
        // 필터링된 화장실 데이터 사용
        var toilets = [
          <c:forEach var="toilet" items="${sessionScope.filteredToilets}" varStatus="status">
            {
              name: "${fn:escapeXml(toilet.name)}",
              lat: ${toilet.lat},
              lng: ${toilet.lng},
              addressRoad: "${fn:escapeXml(toilet.addressRoad)}",
              addressLot: "${fn:escapeXml(toilet.addressLot)}",
              maleToilet: ${toilet.maleToilet},
              maleUrinal: ${toilet.maleUrinal},
              maleDisabledToilet: ${toilet.maleDisabledToilet},
              maleDisabledUrinal: ${toilet.maleDisabledUrinal},
              femaleToilet: ${toilet.femaleToilet},
              femaleDisabledToilet: ${toilet.femaleDisabledToilet},
              phoneNumber: "${fn:escapeXml(toilet.phoneNumber)}",
              openTimeDetail: "${fn:escapeXml(toilet.openTimeDetail)}",
              hasEmergencyBell: ${toilet.hasEmergencyBell},
              emergencyBellLocation: "${fn:escapeXml(toilet.emergencyBellLocation)}",
              hasCctv: ${toilet.hasCctv},
              hasDiaperTable: ${toilet.hasDiaperTable},
              diaperTableLocation: "${fn:escapeXml(toilet.diaperTableLocation)}"
            }<c:if test="${!status.last}">,</c:if>
          </c:forEach>
        ];
      </c:when>
      <c:otherwise>
        // 일반 화장실 데이터 사용
        var toilets = [
          <c:forEach var="toilet" items="${toilets}" varStatus="status">
            {
              name: "${fn:escapeXml(toilet.name)}",
              lat: ${toilet.lat},
              lng: ${toilet.lng},
              addressRoad: "${fn:escapeXml(toilet.addressRoad)}",
              addressLot: "${fn:escapeXml(toilet.addressLot)}",
              maleToilet: ${toilet.maleToilet},
              maleUrinal: ${toilet.maleUrinal},
              maleDisabledToilet: ${toilet.maleDisabledToilet},
              maleDisabledUrinal: ${toilet.maleDisabledUrinal},
              femaleToilet: ${toilet.femaleToilet},
              femaleDisabledToilet: ${toilet.femaleDisabledToilet},
              phoneNumber: "${fn:escapeXml(toilet.phoneNumber)}",
              openTimeDetail: "${fn:escapeXml(toilet.openTimeDetail)}",
              hasEmergencyBell: ${toilet.hasEmergencyBell},
              emergencyBellLocation: "${fn:escapeXml(toilet.emergencyBellLocation)}",
              hasCctv: ${toilet.hasCctv},
              hasDiaperTable: ${toilet.hasDiaperTable},
              diaperTableLocation: "${fn:escapeXml(toilet.diaperTableLocation)}"
            }<c:if test="${!status.last}">,</c:if>
          </c:forEach>
        ];
      </c:otherwise>
    </c:choose>

    toilets.forEach(toilet => {
      if (toilet.lat !== 0 && toilet.lng !== 0) {
        // 필터링된 경우 컬러 코딩된 마커 사용
        let markerOptions = {
          position: { lat: toilet.lat, lng: toilet.lng },
          map: map,
          title: toilet.name
        };
        
        // 세션에 필터링 설정이 있는 경우에만 색상 변경
        <c:if test="${sessionScope.isFiltered}">
          // 마커 색상 결정 (우선순위: 비상벨 > CCTV > 기저귀교환대)
          let markerColor = "#FF9800"; // 기본 색상
          
          if (toilet.hasEmergencyBell === 1) {
            markerColor = "#FF5252"; // 비상벨 - 빨간색
          } else if (toilet.hasCctv === 1) {
            markerColor = "#4CAF50"; // CCTV - 초록색
          } else if (toilet.hasDiaperTable === 1) {
            markerColor = "#2196F3"; // 기저귀 교환대 - 파란색
          }
          
          markerOptions.icon = {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 8,
            fillColor: markerColor,
            fillOpacity: 0.9,
            strokeColor: "#ffffff",
            strokeWeight: 2
          };
        </c:if>
        
        const marker = new google.maps.Marker(markerOptions);

        const infoWindow = new google.maps.InfoWindow({
          content: `
            <h3>${toilet.name}</h3>
            📍 도로명 주소: ${toilet.addressRoad}<br>
            📍 지번 주소: ${toilet.addressLot}<br>
            🚹 남자 대변기: ${toilet.maleToilet}개<br>
            🚹 남자 소변기: ${toilet.maleUrinal}개<br>
            ♿ 장애인 남자 대변기: ${toilet.maleDisabledToilet}개<br>
            ♿ 장애인 남자 소변기: ${toilet.maleDisabledUrinal}개<br>
            🚺 여자 대변기: ${toilet.femaleToilet}개<br>
            ♿ 장애인 여자 대변기: ${toilet.femaleDisabledToilet}개<br>
            📞 전화번호: ${toilet.phoneNumber}<br>
            ⏰ 개방시간: ${toilet.openTimeDetail}<br>
            🆘 비상벨 설치: ${toilet.hasEmergencyBell == 1 ? 'O' : 'X'}<br>
            📍 비상벨 위치: ${toilet.emergencyBellLocation}<br>
            📹 CCTV: ${toilet.hasCctv == 1 ? 'O' : 'X'}<br>
            👶 기저귀 교환대: ${toilet.hasDiaperTable == 1 ? 'O' : 'X'}<br>
            📍 기저귀 교환대 위치: ${toilet.diaperTableLocation}
          `
        });

        marker.addListener("click", () => {
          infoWindow.open(map, marker);
        });
      }
    });
  }
</script>

<script async
  src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap">
</script>

</body>
</html>