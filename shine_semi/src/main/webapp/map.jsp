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
</style>
</head>
<body>
	<!-- [지원] 작업 파트 include -->
	<jsp:include page="mapJeewonPart.jsp" />
	<h2>EMERLET</h2>
	<button id="centerToUserBtn" onclick="centerMapToUser()">📍 내
		근처 화장실 찾기</button>
	<div id="map"></div>

	<script>
	// 전역 변수 선언
	let map;
	let userLocation = null;
	let userMarker = null;
	window.markers = [];
	window.currentInfoWindow = null;

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

	// 현재 사용자 위치 구하는 함수 
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

	// [내 근처 화장실] 검색 기능의 내 위치에 줌인하는 함수 
	function centerMapToUser() {
		getCurrentUserLocation((loc) => {
			map.setCenter(loc);
			map.setZoom(17);
		});
	}

	// 맵 이니셜라이징 함수 
	function initMap() {
		const center = { lat: 37.5665, lng: 126.9780 };
    
		// URL 파라미터나 세션 스토리지에서 선택된 화장실 좌표 확인
		const urlParams = new URLSearchParams(window.location.search);
		const selectLat = urlParams.get('select_lat') || sessionStorage.getItem('selectedToiletLat');
		const selectLng = urlParams.get('select_lng') || sessionStorage.getItem('selectedToiletLng');
		
		// 선택된 화장실 좌표가 있으면 지도 중심 설정
		let initialCenter = center;
		let initialZoom = 14;
		
		if (selectLat && selectLng) {
			initialCenter = { 
				lat: parseFloat(selectLat), 
				lng: parseFloat(selectLng) 
			};
			initialZoom = 18;
			
			// 세션 스토리지 초기화 (한 번 사용한 후 삭제)
			sessionStorage.removeItem('selectedToiletLat');
			sessionStorage.removeItem('selectedToiletLng');
		}
		
		map = new google.maps.Map(document.getElementById("map"), {
			zoom: initialZoom,
			center: initialCenter
		});
		
		// 사용자 현재 위치 가져오기 (선택된 화장실 좌표가 없는 경우에만)
		if (!selectLat || !selectLng) {
			getCurrentUserLocation((loc) => {
				map.setCenter(loc);
			});
		}

		// 화장실 배열 만들기 (모든 상세 정보 추가) 
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

		// 마커 클릭 이벤트 등록 후 선택된 화장실 마커 찾기
		let selectedMarker = null;
		
		// 화장실을 맵에 마커로 표시
		toilets.forEach(toilet => {
			if (toilet.lat !== 0 && toilet.lng !== 0) {
				const marker = new google.maps.Marker({
					position: { lat: toilet.lat, lng: toilet.lng },
					map: map,
					title: toilet.name
				});
				
				// 마커 배열에 추가
				window.markers.push(marker);
				
				// 선택된 화장실 마커 확인
				if (selectLat && selectLng && 
					Math.abs(toilet.lat - parseFloat(selectLat)) < 0.000001 && 
					Math.abs(toilet.lng - parseFloat(selectLng)) < 0.000001) {
					selectedMarker = marker;
				}
				
				marker.addListener("click", () => {
					// 이미 열려있는 정보창이 있으면 닫기
					if (window.currentInfoWindow) {
						window.currentInfoWindow.close();
					}
					
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
						'<a href="MapServlet?lat=' + toilet.lat + '&lng=' + toilet.lng + '" target="_blank"><button>🚗 길찾기</button></a>' +
						'</div>';

					const infoWindow = new google.maps.InfoWindow({
						content: infoContent
					});
					
					infoWindow.open(map, marker);
					window.currentInfoWindow = infoWindow;
				});
			}
		});
		
		// 선택된 마커 클릭 이벤트 트리거 (마커 생성 후)
		if (selectedMarker) {
			setTimeout(() => {
				google.maps.event.trigger(selectedMarker, 'click');
			}, 500);
		}
	}
	</script>

	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap">
	</script>

</body>
</html>
