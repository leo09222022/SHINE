<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Emerlet</title>
<link rel="stylesheet" href="css/mo_style.css" />
<style>
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
	font-family: Pretendard;
	font-size: 16px;
	font-weight: normal;
	line-height: 150%;
	letter-spacing: 0em;
	/* Text_main */
	color: #1D1D1F;
}

input[type="text"], textarea {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
}

.radio-group {
	margin-bottom: 20px;
}

.radio-options {
	display: flex;
	gap: 20px;
	margin-top: 5px;
}

.radio-option {
	display: flex;
	align-items: center;
}

.radio-option label {
	font-family: Pretendard;
	font-size: 16px;
	font-weight: normal;
	line-height: normal;
	letter-spacing: 0em;
	color: #1D1D1F;
	margin-left: 5px;
	margin-bottom: 0;
}

.map-container {
	height: 300px;
	margin-bottom: 20px;
}

.btn {
	width: 100%;
	height: 36px;
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

.rating {
	display: flex;
	flex-direction: row-reverse;
	gap: 4px;
	margin: 10px 0;
}

.rating input {
	display: none;
}

.sub-tit {
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 8px;
}

.rating label {
	cursor: pointer;
	width: 24px;
	height: 24px;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cpath d='M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z' fill='%23e0e0e0'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: center;
	background-size: contain;
}

.rating input:checked ~ label, .rating label:hover, .rating input:checked+label:hover,
	.rating input:checked ~ label:hover {
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cpath d='M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z' fill='%23f5bc00'/%3E%3C/svg%3E");
}
</style>
</head>
<body>
	<div class="container">
	
	<div style="display:flex; flex-direction: row-reverse; gap:4px; cursor:pointer;" onclick="location.href='index.html'">
	<div style="display:flex; justify-content:center; aligns-item:center;">돌아가기</div>
	<img src="img/back_page.svg"/>
	</div>
	
		<div class="sn-title"><%=bundle.getString("menu.register")%></div>

		<c:if test="${not empty errorMessage}">
			<div class="error-message">${errorMessage}</div>
		</c:if>

		<div class="map-container" id="map"></div>

		<form action="toiletAddOK.do" method="post">
			<div class="form-group">
				<label for="userName" class="sub-tit"> 1. <%=bundle.getString("add.name")%>
					*
				</label> <input type="text" id="userName" name="userName" required>
			</div>

			<div class="form-group">
				<label for="userRoadAddress" class="sub-tit"> 2. <%=bundle.getString("add.address")%>
					*
				</label> <input type="text" id="userRoadAddress" name="userRoadAddress"
					required>
			</div>

			<div class="form-group">
				<label class="sub-tit"> 3. <%=bundle.getString("add.detail")%>
				</label>

				<div>

					<div class="radio-group">
						<label><%=bundle.getString("popup.maleToilet")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userMaleToiletY" name="userMaleToilet"
									value="Y"> <label for="userMaleToiletY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userMaleToiletN" name="userMaleToilet"
									value="N"> <label for="userMaleToiletN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userMaleToiletU" name="userMaleToilet"
									value="U" checked> <label for="userMaleToiletU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>

					<div class="radio-group">
						<label><%=bundle.getString("popup.femaleToilet")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userFemaleToiletY"
									name="userFemaleToilet" value="Y"> <label
									for="userFemaleToiletY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userFemaleToiletN"
									name="userFemaleToilet" value="N"> <label
									for="userFemaleToiletN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userFemaleToiletU"
									name="userFemaleToilet" value="U" checked> <label
									for="userFemaleToiletU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>

					<div class="radio-group">
						<label><%=bundle.getString("popup.maleDisabledToilet")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userMaleDisabledToiletY"
									name="userMaleDisabledToilet" value="Y"> <label
									for="userMaleDisabledToiletY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userMaleDisabledToiletN"
									name="userMaleDisabledToilet" value="N"> <label
									for="userMaleDisabledToiletN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userMaleDisabledToiletU"
									name="userMaleDisabledToilet" value="U" checked> <label
									for="userMaleDisabledToiletU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>

					<!-- 여자 장애인 화장실 -->
					<div class="radio-group">
						<label><%=bundle.getString("popup.femaleDisabledToilet")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userFemaleDisabledToiletY"
									name="userFemaleDisabledToilet" value="Y"> <label
									for="userFemaleDisabledToiletY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userFemaleDisabledToiletN"
									name="userFemaleDisabledToilet" value="N"> <label
									for="userFemaleDisabledToiletN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userFemaleDisabledToiletU"
									name="userFemaleDisabledToilet" value="U" checked> <label
									for="userFemaleDisabledToiletU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>

					<div class="radio-group">
						<label><%=bundle.getString("popup.diaperTable")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userHasDiaperTableY"
									name="userHasDiaperTable" value="Y"> <label
									for="userHasDiaperTableY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasDiaperTableN"
									name="userHasDiaperTable" value="N"> <label
									for="userHasDiaperTableN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasDiaperTableU"
									name="userHasDiaperTable" value="U" checked> <label
									for="userHasDiaperTableU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>
					
					<!-- 비상벨 -->
					<div class="radio-group">
						<label><%=bundle.getString("popup.emergencyBell")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userHasEmergencyBellY"
									name="userHasEmergencyBell" value="Y"> <label
									for="userHasEmergencyBellY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasEmergencyBellN"
									name="userHasEmergencyBell" value="N"> <label
									for="userHasEmergencyBellN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasEmergencyBellU"
									name="userHasEmergencyBell" value="U" checked> <label
									for="userHasEmergencyBellU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>

					<!-- CCTV -->
					<div class="radio-group">
						<label><%=bundle.getString("popup.cctv")%>?</label>
						<div class="radio-options">
							<div class="radio-option">
								<input type="radio" id="userHasCctvY" name="userHasCctv"
									value="Y"> <label for="userHasCctvY"><%=bundle.getString("add.yes")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasCctvN" name="userHasCctv"
									value="N"> <label for="userHasCctvN"><%=bundle.getString("add.no")%></label>
							</div>
							<div class="radio-option">
								<input type="radio" id="userHasCctvU" name="userHasCctv"
									value="U" checked> <label for="userHasCctvU"><%=bundle.getString("add.idk")%></label>
							</div>
						</div>
					</div>
				</div>


			</div>
			
			<div class="form-group">
				<label class="sub-tit">4. <%=bundle.getString("add.additionalInfo")%></label>

				<div style="display: flex; flex-direction: row; gap: 20px;">
					<div>
						<label><%=bundle.getString("toilet.cleanliness")%></label>
						<div class="rating">
							<input type="radio" id="cleanliness5" name="cleanliness"
								value="5"> <label for="cleanliness5" title="5점"></label>
							<input type="radio" id="cleanliness4" name="cleanliness"
								value="4"> <label for="cleanliness4" title="4점"></label>
							<input type="radio" id="cleanliness3" name="cleanliness"
								value="3" checked> <label for="cleanliness3" title="3점"></label>
							<input type="radio" id="cleanliness2" name="cleanliness"
								value="2"> <label for="cleanliness2" title="2점"></label>
							<input type="radio" id="cleanliness1" name="cleanliness"
								value="1"> <label for="cleanliness1" title="1점"></label>
						</div>
					</div>

					<div>
						<label><%=bundle.getString("toilet.safety")%></label>
						<div class="rating">
							<input type="radio" id="safety5" name="safety" value="5">
							<label for="safety5" title="5점"></label> <input type="radio"
								id="safety4" name="safety" value="4"> <label
								for="safety4" title="4점"></label> <input type="radio"
								id="safety3" name="safety" value="3" checked> <label
								for="safety3" title="3점"></label> <input type="radio"
								id="safety2" name="safety" value="2"> <label
								for="safety2" title="2점"></label> <input type="radio"
								id="safety1" name="safety" value="1"> <label
								for="safety1" title="1점"></label>
						</div>
					</div>
				</div>
				
				<div class="form-group">

					<label for="userDescription" class="sub-tit">5. <%=bundle.getString("add.comment")%></label>
					<textarea id="userDescription" name="userDescription" rows="4"
						placeholder="<%=bundle.getString("add.placeholder")%>"></textarea>
				</div>

				<!-- Hidden fields for coordinates -->
				<input type="hidden" id="userLat" name="userLat"> <input
					type="hidden" id="userLng" name="userLng">

				<div>
					<button type="submit" class="btn"><%=bundle.getString("report.button")%></button>
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

        // 별점 시스템 초기화 (페이지 로드 시)
        document.addEventListener('DOMContentLoaded', function() {
            // 청결도 별점
            const cleanlinessRating = document.querySelectorAll('input[name="cleanliness"]');
            // 안전성 별점
            const safetyRating = document.querySelectorAll('input[name="safety"]');
            // 접근성 별점
            const accessibilityRating = document.querySelectorAll('input[name="accessibility"]');
            // 비품 별점
            const suppliesRating = document.querySelectorAll('input[name="supplies"]');
            
            // 기본값 설정 (3점으로 설정)
            document.getElementById('cleanliness3').checked = true;
            document.getElementById('safety3').checked = true;
            document.getElementById('accessibility3').checked = true;
            document.getElementById('supplies3').checked = true;
        });
    </script>

	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap">
    </script>
</body>
</html>