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

h2 {
	padding: 10px;
	background: #f1f1f1;
	margin: 0;
	font-size: 20px;
}

#centerToUserBtn {
	position: absolute;
	top: 60px;
	right: 10px;
	z-index: 5;
	padding: 5px 8px;
	font-size: 14px;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 4px;
	cursor: pointer;
	color: blue;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

#toiletInfoPanel {
	position: absolute;
	bottom: 30px;
	left: 50%;
	transform: translateX(-50%);
	background: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.2);
	z-index: 10;
	display: none;
	min-width: 280px;
}
</style>
</head>
<body>
	<jsp:include page="mapJeewonPart.jsp" />
	<h2>EMERLET</h2>
	<button id="centerToUserBtn" onclick="centerMapToUser()">📍 내 근처 화장실 찾기</button>
	<div id="map"></div>
	<div id="toiletInfoPanel"></div> <!-- 화장실 상세 정보 판넬을 위한 div -->
	<script>
		let map;
		let userLocation = null;
		let userMarker = null;
		let markers = [];

		function getCurrentUserLocation(callback) {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(
					(position) => {
						userLocation = {
							lat: position.coords.latitude,
							lng: position.coords.longitude
						};
						if (!userMarker) {
							userMarker = new google.maps.Marker({
								position: userLocation,
								map: map,
								title: "내 위치",
								icon: {
									path: google.maps.SymbolPath.CIRCLE,
									scale: 8,
									fillColor: "#4285F4",
									fillOpacity: 1,
									strokeColor: "#ffffff",
									strokeWeight: 2
								}
							});
						} else {
							userMarker.setPosition(userLocation);
						}
						if (callback) callback(userLocation);
					},
					() => alert("위치 정보를 불러올 수 없습니다.")
				);
			} else {
				alert("이 브라우저는 위치 정보를 지원하지 않습니다.");
			}
		}

		function centerMapToUser() {
			getCurrentUserLocation((loc) => {
				map.setCenter(loc);
				map.setZoom(17);
			});
		}

		function closeInfoPanel() {
			const panel = document.getElementById("toiletInfoPanel");
			panel.style.display = "none";
			markers.forEach(m => m.setOpacity(1));  // 모두 원상복구
		}


		function initMap() {
			const center = { lat: 37.5665, lng: 126.9780 };
			map = new google.maps.Map(document.getElementById("map"), {
				zoom: 14,
				center: center
			});
			getCurrentUserLocation(loc => map.setCenter(loc));

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
					markers.push(marker);
					marker.addListener("click", () => {
						map.panTo(marker.getPosition());
						map.panBy(0, -150);
						markers.forEach(m => {
							if (m !== marker) {
								m.setOpacity(0.3);  // 흐리게
							} else {
								m.setOpacity(1);    // 클릭한 마커는 선명하게
							}
						});

						marker.setMap(map);

						const getInfoLine = (label, value) => {
							return value && value !== "null" ? label + ": " + value + "<br>" : "";
						};
						const getCheckIcon = val => val === null || val === undefined ? "❓" : (parseInt(val) > 0 ? "✔" : "✖");
						const getYesNo = val => val == 1 ? '✔' : '✖';

						document.getElementById("toiletInfoPanel").innerHTML = '<div style="min-width:240px">' +
							'<div style="position:absolute; top:0; right:0;">' +
							'<button onclick="closeInfoPanel()" style="border:none; background:none; font-size:14px; cursor:pointer;">❌</button>' +
							'</div>' +
							'<h3>' + toilet.name + '</h3>' +
							getInfoLine("📍 도로명 주소", toilet.addressRoad) +
							getInfoLine("🏠 지번 주소", toilet.addressLot) +
							'🚹 남자 화장실: ' + getCheckIcon(toilet.maleToilet) + '<br>' +
							'♿ 남자 장애인 화장실: ' + getCheckIcon(toilet.maleDisabledToilet) + '<br>' +
							'🚺 여자 화장실: ' + getCheckIcon(toilet.femaleToilet) + '<br>' +
							'♿ 여자 장애인 화장실: ' + getCheckIcon(toilet.femaleDisabledToilet) + '<br>' +
							getInfoLine("📞 전화번호", toilet.phoneNumber) +
							getInfoLine("⏰ 개방시간", toilet.openTimeDetail) +
							'🆘 비상벨: ' + getYesNo(toilet.hasEmergencyBell) + '<br>' +
							getInfoLine("🔔 비상벨 위치", toilet.emergencyBellLocation) +
							'📹 CCTV: ' + getYesNo(toilet.hasCctv) + '<br>' +
							'👶 기저귀 교환대: ' + getYesNo(toilet.hasDiaperTable) + '<br>' +
							getInfoLine("🔸 기저귀 교환대 위치", toilet.diaperTableLocation) +
							'<a href="MapServlet?lat=' + toilet.lat + '&lng=' + toilet.lng + '" target="_blank"><button>🚗 길찾기</button></a>' +
							'</div>';
						document.getElementById("toiletInfoPanel").style.display = "block";
					});
				}
			});
		}
	</script>
	<script async src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap"></script>
</body>
</html>
