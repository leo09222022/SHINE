<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 근처 공중화장실</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/oldStyle.css">

</head>
<body>
	<div class="main-container">
		<!-- 사이드바 영역 -->
		<aside class="sidebar">

			<!-- 로고 영역 -->
			<div class="sidebar-logo">
				<img src="img/top_logo.svg" alt="logo">
			</div>


			<!-- 서치바 영역 -->
			<div class="sidebar-content">
				<div class="search-box">
					<img src="img/searchbar_marker.svg"> <input type="text"
						class="search-input" placeholder="검색할 지역을 입력해주세요">
				</div>
			</div>


			<!-- 메뉴 영역 -->
			<nav class="menu-list">

				<!-- 필터 메뉴 -->
				<div class="menu-item" id="filterToggle">
					<img src="img/menu_filter.svg" alt="필터 아이콘"> <span
						class="menu-text">필터</span> <img src="img/menu_more.svg" alt="화살표">
				</div>

				<!-- 토글될 필터 목록 -->
				<div class="filter-options" id="filterOptions"
					style="display: none;">
					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_man.svg"> <span> 남자화장실</span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasMaleToilet"> <span class="slider"></span>
						</label>
					</div>

					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_woman.svg"> <span>여자화장실</span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasFemaleToilet"> <span class="slider"></span>
						</label>
					</div>

					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_baby.svg"> <span>기저귀 교환대</span>
						</div>


						<label class="switch"> <input type="checkbox"
							name="hasDiaperTable"> <span class="slider"></span>
						</label>
					</div>

					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_dis.svg"> <span>장애인 이용 가능</span>
						</div>

						<label class="switch"> <input type="checkbox"
							name="hasDisabledToilet"> <span class="slider"></span>
						</label>
					</div>
				</div>

				<!-- 화장실 등록 메뉴 아이템 -->
				<a href="toiletAdd.do" class="menu-item"> <img
					src="img/menu_plus.svg"> <span class="menu-text">화장실
						등록</span> <img src="img/menu_more.svg">
				</a>

				<!-- 가까운 화장실 찾기 메뉴 아이템 -->
				<div class="menu-item" onclick="centerMapToUser()">
					<img src="img/meny_map.svg"> <span class="menu-text">가까운
						화장실 찾기</span> <img src="img/menu_more.svg">
				</div>

				<!-- Korean Toilet Guide 메뉴 아이템 -->
				<div class="menu-item" onclick="openModalWithPage('toiletGuide.html')">
					<img src="img/meny_guide.svg"> <span class="menu-text">Korean
						Toilet Guide</span> <img src="img/menu_more.svg">
				</div>
			</nav>

			<!-- 푸터 영역 -->
			<footer class="sidebar-footer">
				<div>About</div>
				<div>Contact</div>
				<div>Support Us</div>
			</footer>
		</aside>

		<!-- 메인 영역 -->
		<main class="main-content">
			<div id="map"></div>
		</main>


	</div>


	<!-- [지원] 작업 파트 include -->
	<jsp:include page="mapJeewonPart.jsp" />
	<h2>EMERLET</h2>
	<button id="centerToUserBtn" onclick="centerMapToUser()">📍 내
		근처 화장실 찾기</button>



	<script>
  // JSTL로 받아온 데이터를 JS에서 접근할 수 있게 window에 저장
  window.toiletData = [
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
	</script>

	<!-- 모달 컴포넌트 -->
	<div id="modalOverlay"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">

		<div id="modalBody"
			style="background: #fff; width: 90%; max-width: 800px; padding: 20px; border-radius: 8px; position: relative;">
			<button onclick="closeModal()"
				style="position: absolute; top: 10px; right: 10px;">✖</button>
		</div>
	</div>

	<!-- JS 파일 연결 -->
	<script src="js/mapScript.js"></script>
	
	<!-- 구글맵이 외부 JS보다 나중에 호출되어야함 위치변경 금지 -->
	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap"></script>
</body>
</html>
