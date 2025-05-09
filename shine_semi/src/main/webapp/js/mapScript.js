// 전역 변수 선언
let map;
let userLocation = null;
let userMarker = null;
window.markers = [];
window.currentInfoWindow = null;


// 필터링 함수
function applyFilter() {
	if (!window.toiletMarkers) return;	
	
  const maleChecked = document.querySelector('input[name="hasMaleToilet"]').checked;
  const femaleChecked = document.querySelector('input[name="hasFemaleToilet"]').checked;
  const diaperChecked = document.querySelector('input[name="hasDiaperTable"]').checked;
  const disabledChecked = document.querySelector('input[name="hasDisabledToilet"]').checked;

  window.toiletMarkers.forEach(obj => {
    const toilet = obj.data;
    const marker = obj.marker;

    const show =
      (!maleChecked || toilet.maleToilet > 0) &&
      (!femaleChecked || toilet.femaleToilet > 0) &&
      (!diaperChecked || toilet.hasDiaperTable > 0) &&
      (!disabledChecked || (toilet.maleDisabledToilet > 0 || toilet.femaleDisabledToilet > 0));

    marker.setMap(show ? map : null); // 조건을 만족하면 지도에 표시, 아니면 제거
  });
}

// 페이지 진입시 초기 필터링
document.addEventListener('DOMContentLoaded', () => {
  // 필터 체크박스 변경 시 applyFilter 실행
  document.querySelectorAll('#filterOptions input[type="checkbox"]').forEach(cb => {
    cb.addEventListener('change', applyFilter);
  });

  // 페이지 진입 시 체크박스 상태 기반 초기 필터링도 가능
  applyFilter();
});




// 아이콘 텍스트 결정 함수
function getCheckIcon(val) {
	if (val === null || val === undefined) return "❓";
	const num = parseInt(val);
	return isNaN(num) ? "❓" : (num > 0 ? "✔" : "✖");
}


// 필터 토글
document.addEventListener('DOMContentLoaded', function() {
	const toggle = document.getElementById('filterToggle');
	const options = document.getElementById('filterOptions');

	toggle.addEventListener('click', function() {
		const isVisible = options.style.display === 'block';
		options.style.display = isVisible ? 'none' : 'block';
	});
});


// 페이지 로딩 시 위치 권한 확인
document.addEventListener("DOMContentLoaded", () => {
	if (navigator.geolocation) {
		navigator.permissions.query({ name: "geolocation" }).then((result) => {
			if (result.state === "prompt") {
				navigator.geolocation.getCurrentPosition(
					() => console.log("위치 권한 허용됨"),
					(error) => console.warn("위치 접근 실패", error.message)
				);
			} else if (result.state === "denied") {
				alert("위치 권한이 차단되어 있습니다.\n브라우저 설정에서 허용해주세요.");
			}
		});
	}
});

// 사용자 현재 위치 가져오기 함수
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

// 내 위치로 지도를 이동
function centerMapToUser() {
	getCurrentUserLocation((loc) => {
		map.setCenter(loc);
		map.setZoom(17);
	});
}



// 지도 초기화
function initMap() {
	const center = { lat: 37.5665, lng: 126.9780 };
	const urlParams = new URLSearchParams(window.location.search);
	const selectLat = urlParams.get('select_lat') || sessionStorage.getItem('selectedToiletLat');
	const selectLng = urlParams.get('select_lng') || sessionStorage.getItem('selectedToiletLng');

	let initialCenter = center;
	let initialZoom = 14;

	// 선택 화장실이 있으면 중심과 줌 조정???????
	if (selectLat && selectLng) {
		initialCenter = { lat: parseFloat(selectLat), lng: parseFloat(selectLng) };
		initialZoom = 18;
		sessionStorage.removeItem('selectedToiletLat');
		sessionStorage.removeItem('selectedToiletLng');
	}


	// 지도 생성
	map = new google.maps.Map(document.getElementById("map"), {
		zoom: initialZoom,
		center: initialCenter
	});


	// 초기 위치가 없으면 사용자 위치로 이동
	if (!selectLat || !selectLng) {
		getCurrentUserLocation((loc) => map.setCenter(loc));
	}


	// 서버에서 전달받은 화장실 목록 JSTL 반복문으로 JS 배열로 변환???????????????
	const toilets = window.toiletData || []; // 외부에서 삽입된 변수??
	window.toiletMarkers = [];


	// SN 
	// 서버에서 전달받은 화장실 목록 JSTL 반복문으로 JS 배열로 변환
	/*
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
		*/


	let selectedMarker = null;

	// 마커 생성 및 클릭 이벤트 설정
	toilets.forEach(toilet => {
		if (toilet.lat !== 0 && toilet.lng !== 0) {
			const marker = new google.maps.Marker({
				position: { lat: toilet.lat, lng: toilet.lng },
				map: map,
				title: toilet.name
			});
			
			// 
			// window.markers.push(marker);
			
			// 마커와 화장실 데이터를 함께 저장
			window.toiletMarkers.push({ marker, data: toilet });


			// 선택된 화장실이면 저장
			if (selectLat && selectLng &&
				Math.abs(toilet.lat - parseFloat(selectLat)) < 0.000001 &&
				Math.abs(toilet.lng - parseFloat(selectLng)) < 0.000001) {
				selectedMarker = marker;
			}


			// 마커 클릭 시 InfoWindow 표시
			marker.addListener("click", () => {
				if (window.currentInfoWindow) window.currentInfoWindow.close();

				const infoContent = `
          <div style="min-width:240px">
            <h3>${toilet.name}</h3>
            📍 도로명 주소: ${toilet.addressRoad}<br>
            🏠 지번 주소: ${toilet.addressLot}<br>
            🚹 남자 화장실: ${getCheckIcon(toilet.maleToilet)}<br>
            ♿ 남자 장애인 화장실: ${getCheckIcon(toilet.maleDisabledToilet)}<br>
            🚺 여자 화장실: ${getCheckIcon(toilet.femaleToilet)}<br>
            ♿ 여자 장애인 화장실: ${getCheckIcon(toilet.femaleDisabledToilet)}<br>
            📞 전화번호: ${toilet.phoneNumber}<br>
            ⏰ 개방시간: ${toilet.openTimeDetail}<br>
            🆘 비상벨: ${getCheckIcon(toilet.hasEmergencyBell)}<br>
            🔔 비상벨 위치: ${toilet.emergencyBellLocation}<br>
            📹 CCTV: ${getCheckIcon(toilet.hasCctv)}<br>
            👶 기저귀 교환대: ${getCheckIcon(toilet.hasDiaperTable)}<br>
            🔸 기저귀 교환대 위치: ${toilet.diaperTableLocation}<br>
            <a href="MapServlet?lat=${toilet.lat}&lng=${toilet.lng}" target="_blank"><button>🚗 길찾기</button></a>
          </div>`;

				const infoWindow = new google.maps.InfoWindow({ content: infoContent });
				infoWindow.open(map, marker);
				window.currentInfoWindow = infoWindow;
			});
		}
	});


	// 선택된 마커가 있으면 자동 클릭
	if (selectedMarker) {
		setTimeout(() => {
			google.maps.event.trigger(selectedMarker, 'click');
		}, 500);
	}
}


// initMap 전역으로 선언
window.initMap = initMap;


// 모달팝업용 JS
window.openModalWithPage =function openModalWithPage(url) {
  const overlay = document.getElementById("modalOverlay");
  const body = document.getElementById("modalBody");

  overlay.style.display = "flex";
  body.innerHTML = "로딩 중...";

  fetch(url)
    .then(res => res.text())
    .then(html => {
      body.innerHTML = html + `<button onclick="closeModal()" style="position:absolute;top:10px;right:10px;">✖</button>`;
    })
    .catch(() => {
      body.innerHTML = "<p>페이지를 불러올 수 없습니다.</p>";
    });
}

function closeModal() {
  document.getElementById("modalOverlay").style.display = "none";
}

