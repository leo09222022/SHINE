<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 
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

  function initMap() {
    const center = { lat: 37.5665, lng: 126.9780 };

    map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: center,
    });

    // 화장실 데이터
    const toilets = [
      <c:forEach var="toilet" items="${toilets}" varStatus="status">
        {
          name: "${toilet.name}",
          lat: ${toilet.lat},
          lng: ${toilet.lng},
          address_road: "${toilet.address_road}",
          address_lot: "${toilet.address_lot}",
          male_toilet: ${toilet.male_toilet},
          male_urinal: ${toilet.male_urinal},
          male_disabled_toilet: ${toilet.male_disabled_toilet},
          male_disabled_urinal: ${toilet.male_disabled_urinal},
          female_toilet: ${toilet.female_toilet},
          female_disabled_toilet: ${toilet.female_disabled_toilet},
          phone_number: "${toilet.phone_number}",
          open_time_detail: "${toilet.open_time_detail}",
          has_emergency_bell: ${toilet.has_emergency_bell},
          emergency_bell_location: "${toilet.emergency_bell_location}",
          has_cctv: ${toilet.has_cctv},
          has_diaper_table: ${toilet.has_diaper_table},
          diaper_table_location: "${toilet.diaper_table_location}"
        }<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];

    console.log("Toilets:", toilets);

    toilets.forEach(toilet => {
      if (toilet.lat !== 0 && toilet.lng !== 0) {
        const marker = new google.maps.Marker({
          position: { lat: toilet.lat, lng: toilet.lng },
          map: map,
          title: toilet.name
        });

        const infoWindow = new google.maps.InfoWindow({
          content: `
            <h3>${toilet.name}</h3>
            📍 도로명 주소: ${toilet.address_road}<br>
            📍 지번 주소: ${toilet.address_lot}<br>
            🚹 남자 대변기: ${toilet.male_toilet}개<br>
            🚹 남자 소변기: ${toilet.male_urinal}개<br>
            ♿ 장애인 남자 대변기: ${toilet.male_disabled_toilet}개<br>
            ♿ 장애인 남자 소변기: ${toilet.male_disabled_urinal}개<br>
            🚺 여자 대변기: ${toilet.female_toilet}개<br>
            ♿ 장애인 여자 대변기: ${toilet.female_disabled_toilet}개<br>
            📞 전화번호: ${toilet.phone_number}<br>
            ⏰ 개방시간: ${toilet.open_time_detail}<br>
            🆘 비상벨 설치: ${toilet.has_emergency_bell ? 'O' : 'X'}<br>
            📍 비상벨 위치: ${toilet.emergency_bell_location}<br>
            📹 CCTV: ${toilet.has_cctv ? 'O' : 'X'}<br>
            👶 기저귀 교환대: ${toilet.has_diaper_table ? 'O' : 'X'}<br>
            📍 기저귀 교환대 위치: ${toilet.diaper_table_location}
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

