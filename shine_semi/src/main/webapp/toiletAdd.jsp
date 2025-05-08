<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공중화장실 추가 요청</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f5f5f5;
}

h2 {
	padding: 10px 0;
	color: #333;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"], textarea {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
}

.radio-group {
	margin-bottom: 10px;
}

.radio-options {
	display: flex;
	gap: 15px;
	margin-top: 5px;
}

.radio-option {
	display: flex;
	align-items: center;
}

.radio-option label {
	font-weight: normal;
	margin-left: 5px;
	margin-bottom: 0;
}

.map-container {
	height: 300px;
	margin-bottom: 20px;
}

.btn {
	padding: 10px 15px;
	background-color: #4285F4;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.btn:hover {
	background-color: #3367d6;
}

.error-message {
	color: red;
	margin-bottom: 10px;
}

.note {
	color: #666;
	font-size: 14px;
	margin-top: 5px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>공중화장실 추가 요청</h2>

		<c:if test="${not empty errorMessage}">
			<div class="error-message">${errorMessage}</div>
		</c:if>

		<div class="map-container" id="map"></div>

		<form action="toiletAddOK.do" method="post">
			<div class="form-group">
				<label for="userName">등록자 이름 *</label> <input type="text"
					id="userName" name="userName" required>
			</div>

			<div class="form-group">
				<label for="userRoadAddress">화장실 도로명주소 (맵 터치시 자동입력)*</label> <input
					type="text" id="userRoadAddress" name="userRoadAddress" required>
			</div>

			<div class="form-group">
				<label>화장실 정보</label>

				<div class="radio-group">
					<label>남성용 화장실</label>
					<div class="radio-options">
						<div class="radio-option">
							<input type="radio" id="userMaleToiletY" name="userMaleToilet"
								value="Y"> <label for="userMaleToiletY">있음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userMaleToiletN" name="userMaleToilet"
								value="N"> <label for="userMaleToiletN">없음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userMaleToiletU" name="userMaleToilet"
								value="U" checked> <label for="userMaleToiletU">모름</label>
						</div>
					</div>
				</div>

				<div class="radio-group">
					<label>여성용 화장실</label>
					<div class="radio-options">
						<div class="radio-option">
							<input type="radio" id="userFemaleToiletY"
								name="userFemaleToilet" value="Y"> <label
								for="userFemaleToiletY">있음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userFemaleToiletN"
								name="userFemaleToilet" value="N"> <label
								for="userFemaleToiletN">없음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userFemaleToiletU"
								name="userFemaleToilet" value="U" checked> <label
								for="userFemaleToiletU">모름</label>
						</div>
					</div>
				</div>

				<div class="radio-group">
					<label>장애인 화장실</label>
					<div class="radio-options">
						<div class="radio-option">
							<input type="radio" id="userDisabledToiletY"
								name="userDisabledToilet" value="Y"> <label
								for="userDisabledToiletY">있음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userDisabledToiletN"
								name="userDisabledToilet" value="N"> <label
								for="userDisabledToiletN">없음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userDisabledToiletU"
								name="userDisabledToilet" value="U" checked> <label
								for="userDisabledToiletU">모름</label>
						</div>
					</div>
				</div>

				<div class="radio-group">
					<label>기저귀 교환대</label>
					<div class="radio-options">
						<div class="radio-option">
							<input type="radio" id="userHasDiaperTableY"
								name="userHasDiaperTable" value="Y"> <label
								for="userHasDiaperTableY">있음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userHasDiaperTableN"
								name="userHasDiaperTable" value="N"> <label
								for="userHasDiaperTableN">없음</label>
						</div>
						<div class="radio-option">
							<input type="radio" id="userHasDiaperTableU"
								name="userHasDiaperTable" value="U" checked> <label
								for="userHasDiaperTableU">모름</label>
						</div>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label for="userDescription">상세설명 (개방시간, 특이사항 등)</label>
				<textarea id="userDescription" name="userDescription" rows="4"></textarea>
			</div>

			<!-- Hidden fields for coordinates -->
			<input type="hidden" id="userLat" name="userLat"> <input
				type="hidden" id="userLng" name="userLng">

			<div class="form-group">
				<button type="submit" class="btn">등록 요청하기</button>
			</div>
		</form>
	</div>

	<script>
        let map;
        let marker;
        let userLocationFound = false;
        
        function initMap() {
            // 초기 지도 중심 좌표 (서울시청)
            const defaultCenter = { lat: 37.5665, lng: 126.9780 };
            
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 15,
                center: defaultCenter,
            });
            
            // 사용자 현재 위치 가져오기
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const userLocation = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                        };
                         
                        // 지도 중심 이동
                        map.setCenter(userLocation);
                         
                        // 최초 마커 설정
                        placeMarker(userLocation);
                         
                        // 사용자 위치의 주소 자동 입력
                        getAddressFromLatLng(userLocation);
                         
                        userLocationFound = true;
                    },
                    (error) => {
                        console.log("Geolocation error: ", error);
                        // 위치를 가져오지 못한 경우 기본 위치에 마커 설정
                        placeMarker(defaultCenter);
                    }
                );
            } else {
                placeMarker(defaultCenter);
            }
            
            // 지도 클릭 이벤트 리스너
            map.addListener("click", (event) => {
                placeMarker(event.latLng);
                getAddressFromLatLng(event.latLng);
            });
        }
        
        function placeMarker(location) {
            // 기존 마커 제거
            if (marker) {
                marker.setMap(null);
            }
            
            // 새 마커 생성
            marker = new google.maps.Marker({
                position: location,
                map: map,
                draggable: true,
                animation: google.maps.Animation.DROP
            });
            
            // 마커의 위치 정보를 hidden 필드에 저장
            document.getElementById("userLat").value = location.lat();
            document.getElementById("userLng").value = location.lng();
            
            // 마커 드래그 이벤트 리스너
            marker.addListener("dragend", () => {
                const position = marker.getPosition();
                document.getElementById("userLat").value = position.lat();
                document.getElementById("userLng").value = position.lng();
                getAddressFromLatLng(position);
            });
        }
        
        // 위도/경도로 주소 검색
        function getAddressFromLatLng(latLng) {
            const geocoder = new google.maps.Geocoder();
            geocoder.geocode({ location: latLng }, (results, status) => {
                if (status === "OK" && results[0]) {
                    // 도로명 주소 찾기
                    for (let i = 0; i < results.length; i++) {
                        if (results[i].types.includes('route')) {
                            document.getElementById("userRoadAddress").value = results[i].formatted_address;
                            return;
                        }
                    }
                    
                    // 도로명 주소가 없으면 첫 번째 결과 사용
                    document.getElementById("userRoadAddress").value = results[0].formatted_address;
                }
            });
        }
    </script>

	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap">
    </script>
</body>
</html>