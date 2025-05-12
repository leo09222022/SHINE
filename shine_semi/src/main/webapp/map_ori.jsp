<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Emerlet</title>
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
</style>
</head>
<body>
	<!-- [지원] 작업 파트 include -->
	<jsp:include page="mapJeewonPart.jsp" />
	<h2>EMERLET</h2>
	<button id="centerToUserBtn" onclick="centerMapToUser()">📍 내 근처 화장실 찾기</button>
	<div id="map"></div>

	<script>
	let map;
	let userLocation = null;
	let userMarker = null;
	window.markers = [];
	window.currentInfoWindow = null;

	function getCheckIcon(val) {
		if (val === null || val === undefined) return "❓";
		const num = parseInt(val);
		return isNaN(num) ? "❓" : (num > 0 ? "✔" : "✖");
	}

	document.addEventListener("DOMContentLoaded", () => {
		if (navigator.geolocation) {
			navigator.permissions.query({ name: "geolocation" }).then((result) => {
				if (result.state === "prompt") {
					navigator.geolocation.getCurrentPosition(
						(position) => {
							console.log("위치 권한 허용됨");
						},
						(error) => {
							console.warn("위치 접근 실패", error.message);
						}
					);
				} else if (result.state === "denied") {
					alert("위치 권한이 차단되어 있습니다.\n브라우저 설정에서 허용해주세요.");
				}
			});
		}
	});

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

	function initMap() {
		const center = { lat: 37.5665, lng: 126.9780 };
		const urlParams = new URLSearchParams(window.location.search);
		const selectLat = urlParams.get('select_lat') || sessionStorage.getItem('selectedToiletLat');
		const selectLng = urlParams.get('select_lng') || sessionStorage.getItem('selectedToiletLng');
		let initialCenter = center;
		let initialZoom = 14;

		if (selectLat && selectLng) {
			initialCenter = { lat: parseFloat(selectLat), lng: parseFloat(selectLng) };
			initialZoom = 18;
			sessionStorage.removeItem('selectedToiletLat');
			sessionStorage.removeItem('selectedToiletLng');
		}

		map = new google.maps.Map(document.getElementById("map"), {
			zoom: initialZoom,
			center: initialCenter
		});

		if (!selectLat || !selectLng) {
			getCurrentUserLocation((loc) => map.setCenter(loc));
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
				maleDisabledToilet: ${toilet.maleDisabledToilet},
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

		let selectedMarker = null;
		toilets.forEach(toilet => {
			if (toilet.lat !== 0 && toilet.lng !== 0) {
				const marker = new google.maps.Marker({
					position: { lat: toilet.lat, lng: toilet.lng },
					map: map,
					title: toilet.name
				});
				window.markers.push(marker);

				if (selectLat && selectLng &&
					Math.abs(toilet.lat - parseFloat(selectLat)) < 0.000001 &&
					Math.abs(toilet.lng - parseFloat(selectLng)) < 0.000001) {
					selectedMarker = marker;
				}

				marker.addListener("click", () => {
					if (window.currentInfoWindow) window.currentInfoWindow.close();
					
					const infoContent = '<div style="min-width:240px">' +
						'<h3>' + toilet.name + '</h3>' +
						'📍 도로명 주소: ' + toilet.addressRoad + '<br>' +
						'🏠 지번 주소: ' + toilet.addressLot + '<br>' +
						'🚹 남자 화장실: ' + getCheckIcon(toilet.maleToilet) + '<br>' +
						'♿ 남자 장애인 화장실: ' + getCheckIcon(toilet.maleDisabledToilet) + '<br>' +
						'🚺 여자 화장실: ' + getCheckIcon(toilet.femaleToilet) + '<br>' +
						'♿ 여자 장애인 화장실: ' + getCheckIcon(toilet.femaleDisabledToilet) + '<br>' +
						'📞 전화번호: ' + toilet.phoneNumber + '<br>' +
						'⏰ 개방시간: ' + toilet.openTimeDetail + '<br>' +
						'🆘 비상벨: ' + getCheckIcon(toilet.hasEmergencyBell) + '<br>' +
						'🔔 비상벨 위치: ' + toilet.emergencyBellLocation + '<br>' +
						'📹 CCTV: ' + getCheckIcon(toilet.hasCctv) + '<br>' +
						'👶 기저귀 교환대: ' + getCheckIcon(toilet.hasDiaperTable) + '<br>' +
						'🔸 기저귀 교환대 위치: ' + toilet.diaperTableLocation + '<br>' +
						'<a href="MapServlet?lat=' + toilet.lat + '&lng=' + toilet.lng + '" target="_blank"><button>🚗 길찾기</button></a>' +
						'</div>';

					const infoWindow = new google.maps.InfoWindow({ content: infoContent });
					infoWindow.open(map, marker);
					window.currentInfoWindow = infoWindow;
				});
			}
		});

		if (selectedMarker) {
			setTimeout(() => {
				google.maps.event.trigger(selectedMarker, 'click');
			}, 500);
		}
	}
	</script>

	<script async src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap"></script>
</body>
</html>
