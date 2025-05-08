<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    h2 {
      padding: 10px;
      background: #f1f1f1;
      margin: 0;
      font-size: 20px;
    }
  </style>
</head>
<body>

<h2>EMERLET</h2>
<div id="map"></div>

<script>
  let map;
  let userLocation = null;

  function initMap() {
    const center = { lat: 37.5665, lng: 126.9780 };

    map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: center,
    });

    // 사용자 현재 위치 마커 및 저장
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        userLocation = {
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

    const toilets = [
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

    toilets.forEach(toilet => {
      if (toilet.lat !== 0 && toilet.lng !== 0) {
        const marker = new google.maps.Marker({
          position: { lat: toilet.lat, lng: toilet.lng },
          map: map,
          title: toilet.name
        });

        marker.addListener("click", () => {
        	  const getInfoLine = (label, value) => {
        	    return value && value !== "null" ? label + ": " + value + "<br>" : "";
        	  };

        	  const getYesNo = (val) => val == 1 ? 'O' : 'X';

        	  const infoContent = '<div style="min-width:240px">' +
        	    '<h3>' + toilet.name + '</h3>' +
        	    getInfoLine("📍 도로명 주소", toilet.addressRoad) +
        	    getInfoLine("🏠 지번 주소", toilet.addressLot) +
        	    getInfoLine("🚹 남자 대변기", toilet.maleToilet) + getInfoLine("소변기", toilet.maleUrinal) +
        	    getInfoLine("♿ 남자 장애인 대변기", toilet.maleDisabledToilet) + getInfoLine("소변기", toilet.maleDisabledUrinal) +
        	    getInfoLine("🚺 여자 대변기", toilet.femaleToilet) +
        	    getInfoLine("♿ 여자 장애인 대변기", toilet.femaleDisabledToilet) +
        	    getInfoLine("📞 전화번호", toilet.phoneNumber) +
        	    getInfoLine("⏰ 개방시간", toilet.openTimeDetail) +
        	    '🆘 비상벨: ' + getYesNo(toilet.hasEmergencyBell) + '<br>' +
        	    getInfoLine("🔔 비상벨 위치", toilet.emergencyBellLocation) +
        	    '📹 CCTV: ' + getYesNo(toilet.hasCctv) + '<br>' +
        	    '👶 기저귀 교환대: ' + getYesNo(toilet.hasDiaperTable) + '<br>' +
        	    getInfoLine("🔸 기저귀 교환대 위치", toilet.diaperTableLocation) +
        	    '<br><button onclick="navigateTo(' + toilet.lat + ', ' + toilet.lng + ')">🚗 길찾기</button>' +
        	    '</div>';

        	  const infoWindow = new google.maps.InfoWindow({
        	    content: infoContent
        	  });

        	  infoWindow.open(map, marker);
        	});



      }
    });
  }

  function navigateTo(destLat, destLng) {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const userLat = position.coords.latitude;
        const userLng = position.coords.longitude;
        const url = `https://www.google.com/maps/dir/?api=1&origin=${userLat},${userLng}&destination=${destLat},${destLng}&travelmode=walking`;
        window.open(url, '_blank');
      });
    } else {
      alert("위치 정보를 사용할 수 없습니다.");
    }
  }
</script>

<script async
  src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap">
</script>

</body>
</html>
