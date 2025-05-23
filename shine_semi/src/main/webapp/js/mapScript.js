// 전역 변수 선언
let map;
let userLocation = null;
let userMarker = null;
window.markers = [];
window.userToiletMarkers = [];
window.currentInfoWindow = null;
let selectedMarker = null;
let selectedToiletID = "";
let userSelectedToiletID = "";

//날짜 출력용 텍스트
const lastVerifiedDate = new Date("2025-05-01");
const localizedDate = lastVerifiedDate.toLocaleDateString(window.lang || "ko", {
	year: "numeric",
	month: "long",
	day: "numeric"
});

// 모바일 메뉴
function toggleMobileMenu() {
	const menu = document.getElementById("mobileMenu");
	menu.classList.toggle("show");
}




// 랭귀지 설정 팝업 ( 모바일)
function changeLang(lang) {
	location.href = `setLang.jsp?lang=${lang}`;
}

function openLangPopup() {
	const popup = document.getElementById("langPopup");
	const body = popup.querySelector(".lang-popup-body");

	popup.style.display = "flex";
	body.style.animation = "slideUp 0.3s ease-out forwards";
}

function closeLangPopup() {
	const popup = document.getElementById("langPopup");
	const body = popup.querySelector(".lang-popup-body");

	// slideDown 애니메이션 후 display none
	body.style.animation = "slideDown 0.3s ease-in forwards";

	// 애니메이션 끝난 후 완전히 닫기
	setTimeout(() => {
		popup.style.display = "none";
	}, 300); // 애니메이션과 동일한 시간
}




// 서치박스용 함수
function filterToilets(keyword) {
	const list = window.toiletData.filter(
		(toilet) =>
			toilet.name.includes(keyword) || toilet.addressRoad.includes(keyword)
	);

	// 검색어 박스 초기화
	const resultsDiv = document.getElementById("searchResults");
	resultsDiv.innerHTML = "";

	// 검색 시 필터 닫기
	const filterOptions = document.getElementById("filterOptions");
	if (filterOptions && filterOptions.style.display === "block") {
		filterOptions.style.display = "none";
	}

	list.forEach((toilet) => {
		const div = document.createElement("div");
		div.className = "search-result-item";
		div.innerHTML = `
      <strong>${toilet.name}</strong><br>
      <small>${toilet.addressRoad}</small>
    `;
		div.onclick = () => {
			document.querySelector(".search-input").value = "";
			resultsDiv.innerHTML = "";

			centerMapToLocation(toilet.lat, toilet.lng);

			const markerObj = window.toiletMarkers.find(
				(obj) => obj.data.lat === toilet.lat && obj.data.lng === toilet.lng
			);

			if (markerObj) {
				map.setCenter({ lat: toilet.lat, lng: toilet.lng });
				map.setZoom(17);

				openCustomPopup(toilet);

				// 기존 코드
				/*		
				const infoWindow = new google.maps.InfoWindow({
				  content: `
					<div style="min-width:240px">
					  <h3>${toilet.name}</h3>
					  📍 도로명 주소: ${toilet.addressRoad}<br>
					  🏠 지번 주소: ${toilet.addressLot}<br>
					  ...
					</div>`,
				});
		
				if (window.currentInfoWindow) window.currentInfoWindow.close();
				infoWindow.open(map, markerObj.marker);
				window.currentInfoWindow = infoWindow;
				*/


			}
		};

		resultsDiv.appendChild(div);
	});
}

// 검색어 클릭 시 위치로 이동
function centerMapToLocation(lat, lng) {
	if (map && typeof map.setCenter === "function") {
		map.setCenter({ lat, lng });
		map.setZoom(17);
	} else {
		console.warn("지도 객체가 아직 준비되지 않았습니다.");
	}
}

// 세션언어 감지
if (!sessionStorage.getItem("langSet")) {
	const userLang = navigator.language || navigator.userLanguage;
	let lang = "en";
	if (userLang.startsWith("ko")) lang = "ko";
	else if (userLang.startsWith("ja")) lang = "ja";
	sessionStorage.setItem("langSet", "true");
	location.href = "setLang.jsp?lang=" + lang;
}

// 필터링 함수
function applyFilter() {
	if (!window.toiletMarkers) return;

	const maleChecked = document.querySelector(
		'input[name="hasMaleToilet"]'
	).checked;
	const femaleChecked = document.querySelector(
		'input[name="hasFemaleToilet"]'
	).checked;
	const diaperChecked = document.querySelector(
		'input[name="hasDiaperTable"]'
	).checked;
	const disabledChecked = document.querySelector(
		'input[name="hasDisabledToilet"]'
	).checked;

	window.toiletMarkers.forEach((obj) => {
		const toilet = obj.data;
		const marker = obj.marker;

		const show =
			(!maleChecked || toilet.maleToilet > 0) &&
			(!femaleChecked || toilet.femaleToilet > 0) &&
			(!diaperChecked || toilet.hasDiaperTable > 0) &&
			(!disabledChecked ||
				toilet.maleDisabledToilet > 0 ||
				toilet.femaleDisabledToilet > 0);

		marker.setMap(show ? map : null); // 조건을 만족하면 지도에 표시, 아니면 제거
	});
}

// 페이지 진입시 초기 필터링
document.addEventListener("DOMContentLoaded", () => {
	// 필터 체크박스 변경 시 applyFilter 실행
	document
		.querySelectorAll('#filterOptions input[type="checkbox"]')
		.forEach((cb) => {
			cb.addEventListener("change", applyFilter);
		});

	// 페이지 진입 시 체크박스 상태 기반 초기 필터링도 가능
	applyFilter();
});

// 아이콘 텍스트 결정 함수
function getCheckIcon(val) {
	if (val === null || val === undefined || val === "") return "❓";

	if (typeof val === "string") {
		val = val.trim().toUpperCase();
		if (val === "Y") return "✔";
		if (val === "N") return "✖";
	}

	const num = parseInt(val);
	if (!isNaN(num)) {
		return num > 0 ? "✔" : "✖";
	}

	return "❓";
}





// 필터 토글
document.addEventListener("DOMContentLoaded", function() {
	const toggle = document.getElementById("filterToggle");
	const options = document.getElementById("filterOptions");

	options.style.display = "none";

	toggle.addEventListener("click", function() {
		const isVisible = options.style.display === "block";
		options.style.display = isVisible ? "none" : "block";
		
		// 🔽 검색창 초기화
			const searchInput = document.querySelector(".search-input");
			const resultsDiv = document.getElementById("searchResults");
			if (searchInput) {
				searchInput.value = "";
				searchInput.blur();  // 모바일 키보드 내려가게
			}
			if (resultsDiv) {
				resultsDiv.innerHTML = "";
			}
		
	});
});

function getCurrentUserLocation(callback) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        userLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        setUserMarker(userLocation);
        if (callback) callback(userLocation);
      },
      (error) => {
        if (!sessionStorage.getItem("locationDeniedOnce")) {
          sessionStorage.setItem("locationDeniedOnce", "true");
        }
        userLocation = { lat: 37.569701, lng: 126.984475 }; // 디폴트 위치
        setUserMarker(userLocation);
        if (callback) callback(userLocation);
      }
    );
  } else {
    // 브라우저가 지원하지 않는 경우도 포함
    if (!sessionStorage.getItem("locationDeniedOnce")) {
      sessionStorage.setItem("locationDeniedOnce", "true");
    }
    userLocation = { lat: 37.569701, lng: 126.984475 };
    setUserMarker(userLocation);
    if (callback) callback(userLocation);
  }
}


// userMarker 찍는 함수 분리
function setUserMarker(location) {
  if (!userMarker) {
    userMarker = new google.maps.Marker({
      position: location,
      map: map,
      title: "내 위치",
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        scale: 8,
        fillColor: "#4285F4",
        fillOpacity: 1,
        strokeColor: "#ffffff",
        strokeWeight: 2,
      },
    });
  } else {
    userMarker.setPosition(location);
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
	const center = { lat: 37.5665, lng: 126.978 };
	const urlParams = new URLSearchParams(window.location.search);
	const selectLat =
		urlParams.get("select_lat") || sessionStorage.getItem("selectedToiletLat");
	const selectLng =
		urlParams.get("select_lng") || sessionStorage.getItem("selectedToiletLng");

	let initialCenter = center;
	let initialZoom = 16;
	// 14에서 16으로 수정함

	// 선택 화장실이 있으면 중심과 줌 조정 원래 줌 레벨18에서 20으로 수정함 변경함 - SN
	if (selectLat && selectLng) {
		initialCenter = { lat: parseFloat(selectLat), lng: parseFloat(selectLng) };
		initialZoom = 20;
		sessionStorage.removeItem("selectedToiletLat");
		sessionStorage.removeItem("selectedToiletLng");
	}

	// 지도 생성
	map = new google.maps.Map(document.getElementById("map"), {
		zoom: initialZoom,
		center: initialCenter,
	});

	// 초기 위치가 없으면 사용자 위치로 이동
	if (!selectLat || !selectLng) {
	  getCurrentUserLocation((loc) => {
	    if (map && loc) map.setCenter(loc);
	  });
	}


	// 서버에서 전달받은 화장실 목록 JSTL 반복문으로 JS 배열로 변환???????????????
	const toilets = window.toiletData || [];
	const userToilets = window.userToiletData || [];
	window.toiletMarkers = [];
	window.userToiletMarkers = [];

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

	selectedMarker = null;

	// 마커 생성 및 클릭 이벤트 설정
	toilets.forEach((toilet) => {
		if (toilet.lat !== 0 && toilet.lng !== 0) {
			const marker = new google.maps.Marker({
				position: { lat: toilet.lat, lng: toilet.lng },
				map: map,
				title: toilet.name,
				icon: {
					url: "img/map-marker.svg",
					scaledSize: new google.maps.Size(40, 40),
					anchor: new google.maps.Point(20, 40),
				},
			});

			//
			// window.markers.push(marker);

			// 마커와 화장실 데이터를 함께 저장
			window.toiletMarkers.push({ marker, data: toilet });

			// 선택된 화장실이면 저장
			if (
				selectLat &&
				selectLng &&
				Math.abs(toilet.lat - parseFloat(selectLat)) < 0.000001 &&
				Math.abs(toilet.lng - parseFloat(selectLng)) < 0.000001
			) {
				selectedMarker = marker;
			}

			// 마커 클릭 시 InfoWindow 표시
			marker.addListener("click", () => {
				// id,name 파라메터로 전달
				console.log("선택된 화장실 NAME:", toilet.name);
				console.log("선택된 화장실 ID:", toilet.toiletId);
				console.log("선택된 화장실*:", toilet);

				// toilet.name 값을 다음 페이지에 쿼리 파라미터로 전달
				selectedToiletID = encodeURIComponent(toilet.toiletId);

				const lang = sessionStorage.getItem("lang") || navigator.language.slice(0, 2);
				// 마커 위치를 지도 중심으로 이동시키기
				map.setCenter(marker.getPosition());
				// 커스텀 팝업으로 변경
				//openCustomPopup(toilet);

				// 한국어일 경우 번역하지 않고 원본 데이터 사용
				if (lang !== "ko") {
					const ctx = window.location.pathname.split("/")[1]; // 
					fetch(`/${ctx}/translateOne?name=${encodeURIComponent(toilet.name)}&address=${encodeURIComponent(toilet.addressRoad)}&emergencyBellStatus=${encodeURIComponent(toilet.emergencyBellLocation)}&diaperLocation=${encodeURIComponent(toilet.diaperTableLocation)}&lang=${lang}`)
											.then(res => {
												if (!res.ok) throw new Error("번역 실패");
												return res.json();
											})
											.then(data => {
												toilet.translatedName = data.name;
												toilet.translatedAddress = data.address;
												toilet.translatedBell = data.emergencyBellLocation;
												toilet.translatedDiaper = data.diaperTableLocation;
												openCustomPopup(toilet);
											})

						.catch(err => {
							console.error("번역 실패", err);
							openCustomPopup(toilet); // 번역 실패시 원본으로 fallback
						});
				} else {
					// 한국어일 때는 번역 없이 바로 팝업을 열도록 처리
					openCustomPopup(toilet);
				}
				// 기존팝업 코드 아래
				/* 
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
					<!-- <a href="MapServlet?lat=${toilet.lat}&lng=${toilet.lng}" target="_blank"><button>🚗 길찾기</button></a> -->
					<button onclick="openKakaoPopUp()">🚶 길찾기</button>
					
		
				  </div>`;
		
						const infoWindow = new google.maps.InfoWindow({ content: infoContent });
						infoWindow.open(map, marker);
						window.currentInfoWindow = infoWindow;
						*/
			});
		}
	});

	userToilets.forEach((toilet) => {
		if (toilet.lat !== 0 && toilet.lng !== 0) {
			const canvas = document.createElement("canvas");
			canvas.width = 40;
			canvas.height = 40;
			const ctx = canvas.getContext("2d");

			// 배경 원
			ctx.beginPath();
			ctx.arc(20, 20, 18, 0, 2 * Math.PI);
			ctx.fillStyle = "#ff3b30"; // 빨간색
			ctx.fill();

			// 중앙 흰색 점
			ctx.beginPath();
			ctx.arc(20, 20, 5, 0, 2 * Math.PI);
			ctx.fillStyle = "white";
			ctx.fill();

			const marker = new google.maps.Marker({
				position: { lat: toilet.lat, lng: toilet.lng },
				map: map,
				title: toilet.name,
				icon: {
					url: "img/custom_map-marker.svg",
					scaledSize: new google.maps.Size(40, 40),
					anchor: new google.maps.Point(20, 40),
				},
			});
			window.userToiletMarkers.push({ marker, data: toilet });
			marker.addListener("click", () => {
				// usertoiletID 조회
				userSelectedToiletID = encodeURIComponent(toilet.userToiletId);

				console.log("유져 선택된 화장실 NAME:", toilet.name);
				console.log(toilet);

				const lang = sessionStorage.getItem("lang") || navigator.language.slice(0, 2);
				map.setCenter(marker.getPosition());
				if (lang !== "ko") {
					const ctx = window.location.pathname.split("/")[1];
					fetch(`/${ctx}/translateOne?name=${encodeURIComponent(toilet.name)}&address=${encodeURIComponent(toilet.addressRoad)}&emergencyBellLocation=${encodeURIComponent(toilet.emergencyBellLocation)}&diaperTableLocation=${encodeURIComponent(toilet.diaperTableLocation)}&lang=${lang}`)
											.then(res => res.json())
											.then(data => {
												toilet.translatedName = data.name;
												toilet.translatedAddress = data.address;
												toilet.translatedBell = data.emergencyBellLocation;
												toilet.translatedDiaper = data.diaperTableLocation;
												openCustomPopup(toilet);
											})

						.catch(err => {
							console.error("번역 실패", err);
							openCustomPopup(toilet);
						});
				} else {
					openCustomPopup(toilet);
				}
			});
		}
	});


	// 선택된 마커가 있으면 자동 클릭
	if (selectedMarker) {
		setTimeout(() => {
			google.maps.event.trigger(selectedMarker, "click");
		}, 500);
	}

	// 맵 초기화 완료 체크 >> 검색어 출력용
	window.mapReady = true;
}

/*
function openCustomPopup(toilet) {
	// 화장실 신고 통합용
	let reportButtonHTML = "";
	// 화장실 신고 통합용 버튼
	if (toilet.toiletId !== undefined) {
		// 퍼블릭 화장실
		reportButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='toiletReport.jsp?toiletID=${toilet.toiletId}'">${window.i18n.report}</div>`;
	} else if (toilet.userToiletId !== undefined) {
		// 유저 등록 화장실
		reportButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='toiletReport.jsp?userToiletID=${toilet.userToiletId}'">${window.i18n.report}</div>`;
	}
	
	let reviewButtonHTML = "";
		// 화장실 리뷰 등록 통합용 버튼
		if (toilet.toiletId !== undefined) {
			// 퍼블릭 화장실
			reviewButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='insertReview.jsp?toiletID=${toilet.toiletId}'">${window.i18n.insert}</div>`;
		} else if (toilet.userToiletId !== undefined) {
			// 유저 등록 화장실
			reviewButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='insertReviewUserToilet.jsp?userToiletID=${toilet.userToiletId}'">${window.i18n.insert}</div>`;
		}


	const popup = document.getElementById("customInfoPopup");
	const content = document.getElementById("popupContent");

	if (!popup || !content) return;

	const lastVerifiedDate = new Date("2025-05-01");
	const localizedDate = lastVerifiedDate.toLocaleDateString(window.lang || "ko", {
		year: "numeric",
		month: "long",
		day: "numeric"
	});
	const verifiedMessage = window.i18n.lastVerified.replace("{0}", localizedDate);


	popup.style.display = "block";

	if (window.innerWidth <= 768) {
		content.innerHTML = `
      <div style="display:flex; flex-direction: column; gap: 16px;">
        <div>
          <div style="font-size: 18px; font-weight: 600;">${toilet.translatedName || toilet.name}</div>
          <div style="font-size: 14px;">${window.i18n.cleanliness} ⭐ ${toilet.cleanliness} &nbsp; ${window.i18n.safety} ⭐ ${toilet.safety}</div>
          <div style="font-size: 14px;">${toilet.translatedAddress || toilet.addressRoad}</div>
		  ${window.i18n.openTime} : ${toilet.openTimeDetail ? toilet.openTimeDetail : window.i18n.unknown}
        </div>

        <button onclick="openKakaoPopUp()" style="background: #3a81ff; color: white; border: none; border-radius: 8px; padding: 10px 0; font-size: 16px; display: flex; gap: 8px; align-items: center; justify-content: center; text-align: center;">
          <img src="img/pop_directions.svg" alt=""><span>${window.i18n.guide}</span>
        </button>

        ${renderFacilityRow("maleToilet", "img/pop_man.svg", toilet.maleToilet)}
        ${renderFacilityRow("maleDisabledToilet", "img/pop__accessible.svg", toilet.maleDisabledToilet)}
        ${renderFacilityRow("femaleToilet", "img/pop_woman.svg", toilet.femaleToilet)}
        ${renderFacilityRow("femaleDisabledToilet", "img/pop__accessible.svg", toilet.femaleDisabledToilet)}
        ${renderFacilityRow("diaperTable", "img/pop_baby.svg", toilet.hasDiaperTable)}
        <div style="font-size: 12px;">${window.i18n.diaperLocation} : ${toilet.diaperTableLocation}</div>
        ${renderFacilityRow("emergencyBell", "img/pop_bell.svg", toilet.hasEmergencyBell)}
        <div style="font-size: 12px;">${window.i18n.emergencyBellStatus} : ${toilet.emergencyBellLocation}</div>
        ${renderFacilityRow("cctv", "img/pop_cctv.svg", toilet.hasCctv)}
		
		<div style="display: flex; flex-direction:column; gap: 4px; align-items: center">
		<div style="font-size: 14px; color: #919191">${verifiedMessage}</div>
			${reportButtonHTML}
			${reviewButtonHTML}
		</div>
      </div>
    `;
	}
	else {
		content.innerHTML = `
	    <div style="padding: 20px; background: white; border-radius: 4px; flex-direction: column; justify-content: flex-start; align-items: flex-end; display: inline-flex;">
	      <div style="display: flex; gap: 40px">
	        <div style="width: 280px; display: flex; flex-direction: column; gap: 20px">
	          <div style="display: flex; flex-direction: column; gap: 8px">
	            <div style="font-size: 24px; font-weight: 600">${toilet.translatedName || toilet.name}</div>
				<div style="font-size: 14px;">${window.i18n.cleanliness} ⭐ ${toilet.cleanliness} &nbsp; ${window.i18n.safety} ⭐ ${toilet.safety}</div>
	            <div style="font-size: 14px">${toilet.translatedAddress || toilet.addressRoad}</div>
				${window.i18n.openTime} : ${toilet.openTimeDetail ? toilet.openTimeDetail : window.i18n.unknown}
	          </div>
	          <div onclick="openKakaoPopUp()" style="cursor: pointer; background: #3a81ff; color: white; padding: 8px; border-radius: 4px; display: flex; gap: 8px; align-items: center; justify-content: center; text-align: center;">
	             <img src="img/pop_directions.svg" alt=""><span>${window.i18n.guide}</span>
	          </div>
	 	  
	          <div style="display: flex; flex-direction:column; gap: 4px;">
			  <div style="font-size: 14px; color: #919191">${verifiedMessage}</div>
	            ${reportButtonHTML}
				${reviewButtonHTML}
	          </div>
	
	        </div>

	 	<div style="width: 280px; display: flex; flex-direction: column; gap: 8px">
	 	  ${renderFacilityRow("maleToilet", "img/pop_man.svg", toilet.maleToilet)}
	 	  ${renderFacilityRow("maleDisabledToilet", "img/pop__accessible.svg", toilet.maleDisabledToilet)}
	 	  ${renderFacilityRow("femaleToilet", "img/pop_woman.svg", toilet.femaleToilet)}
	 	  ${renderFacilityRow("femaleDisabledToilet", "img/pop__accessible.svg", toilet.femaleDisabledToilet)}
	 	  ${renderFacilityRow("diaperTable", "img/pop_baby.svg", toilet.hasDiaperTable)}
	 	  <div style="font-size: 12px;">${window.i18n.diaperLocation} : ${toilet.diaperTableLocation}</div>
	 	  ${renderFacilityRow("emergencyBell", "img/pop_bell.svg", toilet.hasEmergencyBell)}
	 	  <div style="font-size: 12px;">${window.i18n.emergencyBellStatus} : ${toilet.emergencyBellLocation}</div>
	 	  ${renderFacilityRow("cctv", "img/pop_cctv.svg", toilet.hasCctv)}
	 	</div>
	      </div>
	    </div>
	  `;
	}

}
*/
function openCustomPopup(toilet) {
	const isUser = toilet.userToiletId !== undefined;
	const idParam = isUser ? toilet.userToiletId : toilet.toiletId;
	const url = "getReview.jsp?toiletId=" + idParam + "&isUser=" + (isUser ? "Y" : "N");

	fetch(url)
		.then(res => res.json())
		.then(data => {
			toilet.cleanliness = data.cleanliness || 0;
			toilet.safety = data.safety || 0;
			renderPopupContent(toilet); // ⬅️ 렌더링은 여기서!
		})
		.catch(err => {
			console.warn("평점 정보 조회 실패:", err);
			toilet.cleanliness = 0;
			toilet.safety = 0;
			renderPopupContent(toilet); // fallback으로도 호출
		});
}


function renderPopupContent(toilet) {
	// 화장실 신고 통합용
	let reportButtonHTML = "";
	// 화장실 신고 통합용 버튼
	if (toilet.toiletId !== undefined) {
		// 퍼블릭 화장실
		reportButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='toiletReport.jsp?toiletID=${toilet.toiletId}'">${window.i18n.report}</div>`;
	} else if (toilet.userToiletId !== undefined) {
		// 유저 등록 화장실
		reportButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='toiletReport.jsp?userToiletID=${toilet.userToiletId}'">${window.i18n.report}</div>`;
	}

	let reviewButtonHTML = "";
			// 화장실 리뷰 등록 통합용 버튼
			if (toilet.toiletId !== undefined) {
				// 퍼블릭 화장실
				reviewButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='insertReview.jsp?toiletID=${toilet.toiletId}'">${window.i18n.review}</div>`;
			} else if (toilet.userToiletId !== undefined) {
				// 유저 등록 화장실
				reviewButtonHTML = `<div style="color: #3a81ff; font-size: 14px; cursor: pointer;" onclick="location.href='insertReviewUserToilet.jsp?userToiletID=${toilet.userToiletId}'">${window.i18n.review}</div>`;
			}
			
			
	const popup = document.getElementById("customInfoPopup");
	const content = document.getElementById("popupContent");
	if (!popup || !content) return;

	const lastVerifiedDate = new Date("2025-05-01");
	const localizedDate = lastVerifiedDate.toLocaleDateString(window.lang || "ko", {
		year: "numeric",
		month: "long",
		day: "numeric"
	});
	const verifiedMessage = window.i18n.lastVerified.replace("{0}", localizedDate);

	popup.style.display = "block";

	// 모바일
	if (window.innerWidth <= 768) {
		content.innerHTML = `
		  <div style="display:flex; flex-direction: column; gap: 16px;">
			<div>
			  <div style="font-size: 18px; font-weight: 600;">${toilet.translatedName || toilet.name}</div>
			  <div style="font-size: 14px;">
			    ${window.i18n.cleanliness} ⭐ ${(toilet.cleanliness / 10).toFixed(1)} &nbsp;
			    ${window.i18n.safety} ⭐ ${(toilet.safety / 10).toFixed(1)}
			  </div>
			  <div style="font-size: 14px;">${toilet.translatedAddress || toilet.addressRoad}</div>
			  ${window.i18n.openTime} : ${toilet.openTimeDetail ? toilet.openTimeDetail : window.i18n.unknown}
			</div>

			<button onclick="openKakaoPopUp()" style="background: #3a81ff; color: white; border: none; border-radius: 8px; padding: 10px 0; font-size: 16px; display: flex; gap: 8px; align-items: center; justify-content: center;">
			  <img src="img/pop_directions.svg" alt=""><span>${window.i18n.guide}</span>
			</button>

			${renderFacilityRow("maleToilet", "img/pop_man.svg", toilet.maleToilet)}
			${renderFacilityRow("maleDisabledToilet", "img/pop__accessible.svg", toilet.maleDisabledToilet)}
			${renderFacilityRow("femaleToilet", "img/pop_woman.svg", toilet.femaleToilet)}
			${renderFacilityRow("femaleDisabledToilet", "img/pop__accessible.svg", toilet.femaleDisabledToilet)}
			${renderFacilityRow("diaperTable", "img/pop_baby.svg", toilet.hasDiaperTable)}
			<div style="font-size: 12px;">${window.i18n.diaperLocation} : ${toilet.translatedDiaper || toilet.diaperTableLocation}</div>
			${renderFacilityRow("emergencyBell", "img/pop_bell.svg", toilet.hasEmergencyBell)}
			<div style="font-size: 12px;">${window.i18n.emergencyBellStatus} :  ${toilet.translatedBell || toilet.emergencyBellLocation}</div>
			${renderFacilityRow("cctv", "img/pop_cctv.svg", toilet.hasCctv)}

			<div style="display: flex; flex-direction:column; gap: 4px; align-items: center">
			  <div style="font-size: 14px; color: #919191">${verifiedMessage}</div>
			  ${reportButtonHTML}
			  ${reviewButtonHTML}
		  </div>
		`;
	}
	else {
		// PC 뷰용 템플릿
		content.innerHTML = `
		  <div style="padding: 20px; background: white; border-radius: 4px; flex-direction: column; justify-content: flex-start; align-items: flex-end; display: inline-flex;">
			<div style="display: flex; gap: 40px">
			  <div style="width: 280px; display: flex; flex-direction: column; gap: 20px">
				<div style="display: flex; flex-direction: column; gap: 8px">
				  <div style="font-size: 24px; font-weight: 600">${toilet.translatedName || toilet.name}</div>
				  <div style="font-size: 14px;">
				  	${window.i18n.cleanliness} ⭐ ${(toilet.cleanliness / 10).toFixed(1)} &nbsp;
				  	${window.i18n.safety} ⭐ ${(toilet.safety / 10).toFixed(1)}
				  </div>
				  <div style="font-size: 14px">${toilet.translatedAddress || toilet.addressRoad}</div>
				  ${window.i18n.openTime} : ${toilet.openTimeDetail ? toilet.openTimeDetail : window.i18n.unknown}
				</div>
				<div onclick="openKakaoPopUp()" style="cursor: pointer; background: #3a81ff; color: white; padding: 8px; border-radius: 4px; display: flex; gap: 8px; align-items: center;">
				  <img src="img/pop_directions.svg" alt=""><span>${window.i18n.guide}</span>
				</div>

				<div style="display: flex; flex-direction:column; gap: 4px;">
				  <div style="font-size: 14px; color: #919191">${verifiedMessage}</div>
				  ${reportButtonHTML}
				   ${reviewButtonHTML}
				</div>
			  </div>

			  <div style="width: 280px; display: flex; flex-direction: column; gap: 8px">
				${renderFacilityRow("maleToilet", "img/pop_man.svg", toilet.maleToilet)}
				${renderFacilityRow("maleDisabledToilet", "img/pop__accessible.svg", toilet.maleDisabledToilet)}
				${renderFacilityRow("femaleToilet", "img/pop_woman.svg", toilet.femaleToilet)}
				${renderFacilityRow("femaleDisabledToilet", "img/pop__accessible.svg", toilet.femaleDisabledToilet)}
				${renderFacilityRow("diaperTable", "img/pop_baby.svg", toilet.hasDiaperTable)}
				<div style="font-size: 12px;">${window.i18n.diaperLocation} : ${toilet.translatedDiaper || toilet.diaperTableLocation}</div>
				${renderFacilityRow("emergencyBell", "img/pop_bell.svg", toilet.hasEmergencyBell)}
				<div style="font-size: 12px;">${window.i18n.emergencyBellStatus} :  ${toilet.translatedBell || toilet.emergencyBellLocation}</div>
				${renderFacilityRow("cctv", "img/pop_cctv.svg", toilet.hasCctv)}
			  </div>
			</div>
		  </div>
		`;
	}
}


function renderFacilityRow(labelKey, iconPath, value) {
	let iconStatus = "img/pop_question.svg";
	const label = window.i18n[labelKey];

	if (value === null || value === undefined || value === "") {
		iconStatus = "img/pop_question.svg";
	} else if (typeof value === "string") {
		const val = value.trim().toUpperCase();
		if (val === "Y") iconStatus = "img/pop__check.svg";
		else if (val === "N") iconStatus = "img/pop__close.svg";
	} else {
		const num = parseInt(value);
		if (!isNaN(num)) {
			iconStatus = num > 0 ? "img/pop__check.svg" : "img/pop__close.svg";
		}
	}

	return `
    <div style="display: flex; justify-content: space-between; align-items: center;">
      <div style="display: flex; align-items: center; gap: 6px">
        <img src="${iconPath}" alt="" style="width: 20px; height: 20px" />
        <span style="font-size: 14px;">${label}</span>
      </div>
      <div style="width: 24px; height: 24px;">
        <img src="${iconStatus}" alt="${label} 상태" style="width: 100%; height: 100%;" />
      </div>
    </div>
  `;
}






// 선택된 마커가 있으면 자동 클릭
if (selectedMarker) {
	setTimeout(() => {
		google.maps.event.trigger(selectedMarker, "click");
	}, 500);
}

// initMap 전역으로 선언
window.initMap = initMap;

// 모달팝업용 JS
window.openModalWithPage = function openModalWithPage(url) {
	const overlay = document.getElementById("modalOverlay");
	const body = document.getElementById("modalBody");

	overlay.style.display = "flex";
	body.innerHTML = "로딩 중...";

	fetch(url)
		.then((res) => res.text())
		.then((html) => {
			body.innerHTML =
				html +
				`<button onclick="closeModal()" class="popup-close-btn" style="position:absolute;top:10px;right:10px;">${popupCloseText}</button>`;
		})
		.catch(() => {
			body.innerHTML = "<p>페이지를 불러올 수 없습니다.</p>";
		});
};


// 페이지모달 닫기 인가
function closeModal() {
	document.getElementById("modalOverlay").style.display = "none";
}

// 커스텀 팝업 닫기
function closeCustomPopup() {
	const popup = document.getElementById("customInfoPopup");
	if (popup) {
		popup.style.display = "none";
	} else {
		console.warn("❗ customInfoPopup 요소를 찾을 수 없습니다.");
	}
}


// 동적으로 팝업 스크립트 로딩
(function loadPopupScriptIfNeeded() {
	if (!window.openKakaoPopUp) {
		const script = document.createElement("script");
		script.src = "js/kakaoMapPopUp.js";
		script.onload = () => console.log("kakaoMapPopUp.js loaded"); // 디버깅용
		document.head.appendChild(script);
	}
})();

// 팝업 스크롤바로 내릴 시 모바일 화면에서 아래로 사라지게 하는 함수 
(function enablePopupSwipeClose() {
	const popup = document.getElementById("customInfoPopup");
	let startY = 0;
	let isDragging = false;

	popup.addEventListener("touchstart", (e) => {
		const y = e.touches[0].clientY;
		const bar = popup.querySelector(".popup-dragbar");
		const barRect = bar.getBoundingClientRect();

		if (y >= barRect.top - 20 && y <= barRect.bottom + 20) {
			isDragging = true;
			startY = y;
		}
	});


	popup.addEventListener("touchmove", (e) => {
		if (!isDragging) return;
		const deltaY = e.touches[0].clientY - startY;

		// 80px 이상 아래로 스와이프 시 팝업 닫기
		if (deltaY > 80) {
			popup.style.transition = "transform 0.3s ease-out, opacity 0.3s ease-out";
			popup.style.transform = "translateY(100%)";
			popup.style.opacity = "0";

			setTimeout(() => {
				popup.style.display = "none";
				popup.style.transform = ""; // 초기화
				popup.style.opacity = "";
				popup.style.transition = "";
			}, 300);

			isDragging = false;
		}
	});
	popup.addEventListener("touchend", () => {
		isDragging = false;
	});
})();