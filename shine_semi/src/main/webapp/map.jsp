<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.emerlet.dao.UserToiletDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Locale, java.util.ResourceBundle"%>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null)
	lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<%
String currentLang = (String) session.getAttribute("lang");
if (currentLang == null)
	currentLang = "ko";
%>

<%
UserToiletDAO dao = new UserToiletDAO();
ArrayList<UserToiletVO> userToilets = dao.findApprovedToilets(); // status='approved'만 가져오는 메소드
request.setAttribute("userToilets", userToilets);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>내 근처 공중화장실</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/oldStyle.css" />

<script>
// 페이지 모달용 스크립트...킹쩔수 없음
  const popupCloseText = "<%=bundle.getString("popup.close")%>";
</script>

<script>
// 날짜 출력용 
window.lang = "<%=lang%>";

// 다국어 마커 팝업용 스크립트
  window.i18n = {
    guide: "<%=bundle.getString("popup.guide")%>",
    lastVerified: "<%=bundle.getString("popup.lastVerified")%>",
    report: "<%=bundle.getString("popup.report")%>",
    maleToilet: "<%=bundle.getString("popup.maleToilet")%>",
    maleDisabledToilet: "<%=bundle.getString("popup.maleDisabledToilet")%>",
    femaleToilet: "<%=bundle.getString("popup.femaleToilet")%>",
    femaleDisabledToilet: "<%=bundle.getString("popup.femaleDisabledToilet")%>",
    diaperTable: "<%=bundle.getString("popup.diaperTable")%>",
    diaperLocation: "<%=bundle.getString("popup.diaperLocation")%>",
    emergencyBell: "<%=bundle.getString("popup.emergencyBell")%>",
    emergencyBellStatus: "<%=bundle.getString("popup.emergencyBellStatus")%>",
    cctv: "<%=bundle.getString("popup.cctv")%>",
    lastVerified: "<%=bundle.getString("popup.lastVerified")%>",  
    confirmed: "<%=bundle.getString("popup.confirmed")%>",        
    review: "<%=bundle.getString("toilet.review")%>",        
    cleanliness: "<%=bundle.getString("toilet.cleanliness")%>",        
    safety: "<%=bundle.getString("toilet.safety")%>",        
    openTime: "<%=bundle.getString("toilet.openTime")%>",        
    unknown: "<%=bundle.getString("toilet.unknown")%>"        
  };
</script>



</head>
<body>
	<div class="main-container">
		<!-- 모바일 UI -->
		<jsp:include page="map_mo.jsp" />




		<!-- PC사이드바 영역 -->
		<aside class="sidebar">
			<!-- 로고 영역 -->
			<div class="sidebar-logo">
				<img src="img/top_logo.svg" alt="logo" />
			</div>

			<!-- 서치바 영역 -->
			<div class="sidebar-content">
				<div class="search-box">
					<img src="img/searchbar_marker.svg" /> <input type="text"
						class="search-input"
						placeholder="<%=bundle.getString("search.placeholder")%>"
						oninput="filterToilets(this.value)">
				</div>
				<!-- 검색 결과 -->
				<div class="search-results" id="searchResults">
					<!-- JS로 검색 결과 리스트가 들어올 영역 -->
				</div>
			</div>

			<!-- 메뉴 영역 -->
			<nav class="menu-list">
				<!-- 필터 메뉴 -->
				<div class="menu-item" id="filterToggle">
					<img src="img/menu_filter.svg" alt="필터 아이콘" /> <span
						class="menu-text"><%=bundle.getString("menu.filter")%></span> <img
						src="img/menu_more.svg" alt="화살표" />
				</div>

				<!-- 토글될 필터 목록 -->

				<div id="filterOptions">
					<!-- 남자화장실 -->
					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_man.svg" /> <span><%=bundle.getString("filter.male")%></span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasMaleToilet" /> <span class="slider"></span>
						</label>
					</div>

					<!-- 여자화장실 -->
					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_woman.svg" /> <span><%=bundle.getString("filter.female")%></span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasFemaleToilet" /> <span class="slider"></span>
						</label>
					</div>

					<!-- 기저귀 교환대 -->
					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_baby.svg" /> <span><%=bundle.getString("filter.diaper")%></span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasDiaperTable" /> <span class="slider"></span>
						</label>
					</div>

					<!-- 장애인 이용 가능 -->
					<div class="filter-option">
						<div class="filter-icon-text">
							<img src="img/toggle_dis.svg" /> <span><%=bundle.getString("filter.disabled")%></span>
						</div>
						<label class="switch"> <input type="checkbox"
							name="hasDisabledToilet" /> <span class="slider"></span>
						</label>
					</div>
				</div>

				<!-- 화장실 등록 메뉴 아이템 -->
				<a href="toiletAdd.jsp" class="menu-item"> <img
					src="img/menu_plus.svg" /> <span class="menu-text"><%=bundle.getString("menu.register")%></span>
					<img src="img/menu_more.svg" />
				</a>

				<!-- 가까운 화장실 찾기 메뉴 아이템 -->
				<div class="menu-item" onclick="centerMapToUser()">
					<img src="img/meny_map.svg" /> <span class="menu-text"><%=bundle.getString("menu.nearby")%></span>
					<img src="img/menu_more.svg" />
				</div>

				<!-- Korean Toilet Guide 메뉴 아이템 -->
				<div class="menu-item" onclick="openModalWithPage('mo_tips.jsp')">
					<img src="img/meny_guide.svg" /> <span class="menu-text"><%=bundle.getString("menu.guide")%></span>
					<img src="img/menu_more.svg" />
				</div>
			</nav>

			<!-- 푸터 영역 -->
			<footer class="side_footer">
				<div>
					<div class="lang-selector">
						<a href="setLang.jsp?lang=ko"
							onclick="reloadGoogleMapScript('ko')"
							class="lang-btn <%="ko".equals(currentLang) ? "active" : ""%>">한국어</a>
						<a href="setLang.jsp?lang=en"
							onclick="reloadGoogleMapScript('en')"
							class="lang-btn <%="en".equals(currentLang) ? "active" : ""%>">English</a>
						<a href="setLang.jsp?lang=ja"
							onclick="reloadGoogleMapScript('ja')"
							class="lang-btn <%="ja".equals(currentLang) ? "active" : ""%>">日本語</a>
					</div>
				</div>


				<div class="about-section">
					<div class="cursor-pointer"
						onclick="openModalWithPage('mo_about.jsp')"><%=bundle.getString("footer.about")%></div>
					<div class="cursor-pointer"
						onclick="openModalWithPage('mo_contact.jsp')"><%=bundle.getString("footer.contact")%></div>
					<div class="cursor-pointer"
						onclick="openModalWithPage('mo_support.jsp')"><%=bundle.getString("footer.support")%></div>
				</div>

			</footer>
		</aside>

		<!-- 메인 영역 -->
		<main class="main-content">
			<div id="map"></div>
		</main>
	</div>

	<script>
      // JSTL로 받아온 데이터를 JS에서 접근할 수 있게 window에 저장
      window.toiletData = [
        <c:forEach var="toilet" items="${toilets}" varStatus="status">
        {
	        // 클릭시 toiletID 추가
        	toiletId: ${toilet.toiletId},
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
      
     
      window.userToiletData = [
    	  <c:forEach var="toilet" items="${userToilets}" varStatus="loop">
    	  {           
    		// 클릭시 toiletID 추가
          	
    	    name: "${fn:escapeXml(toilet.userName)}",
    	    lat: ${toilet.userLat},
    	    lng: ${toilet.userLng},
    	    addressRoad: "${fn:escapeXml(toilet.userRoadAddress)}",
    	    maleToilet: "${toilet.userMaleToilet}",
    	    femaleToilet: "${toilet.userFemaleToilet}",
    	    maleDisabledToilet: "${toilet.userMaleDisabledToilet}",
    	    femaleDisabledToilet: "${toilet.userFemaleDisabledToilet}",
    	    hasDiaperTable: "${toilet.userHasDiaperTable}",
    	    hasEmergencyBell: "${toilet.userHasEmergencyBell}",
    	    hasCctv: "${toilet.userHasCctv}",
    	    description: "${fn:escapeXml(toilet.userDescription)}"
    	  }<c:if test="${!loop.last}">,</c:if>
    	  </c:forEach>
    	];


    	  console.log("✅ userToiletData = ", window.userToiletData);

    </script>

	<!-- 모달 컴포넌트 -->
	<div id="modalOverlay"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">
		<div id="modalBody"
			style="background: #fff; width: 90%; max-width: 800px; min-width: 769px; padding: 20px; border-radius: 8px; position: relative;">
			<button onclick="closeModal()" style="float: right;"
				class="popup-close-btn"><%=bundle.getString("popup.close")%></button>
		</div>
	</div>

	<!-- 마커용 팝업 컴포넌트 -->
	<!-- <div class="popup-dragbar" style="width: 48px; height: 8px; background: #ccc; border-radius: 4px; margin: 0 auto 12px auto; cursor: grab;"></div> -->
	<div id="customInfoPopup">
		<div style="display: flex; flex-direction: column;">
			<button onclick="closeCustomPopup()"
				class="popup-close-btn mo-close-btn">
				<%=bundle.getString("popup.close")%></button>
			<div id="popupContent">Loading...</div>
		</div>

	</div>

	<!-- JS 파일 연결 -->
	<script src="js/mapScript.js"></script>


	<!-- 랭귀지 관련 함수 -->
	<!-- onclick에 세션이벤트까지 같이 하는방식으로 수정해야되는데 귀찮으므로 일단 둠 -->
	<script>
function reloadGoogleMapScript(langCode) {
  const oldScript = document.querySelector('script[src*="maps.googleapis.com"]');
  if (oldScript) oldScript.remove();

  const newScript = document.createElement("script");
  newScript.src = `https://maps.googleapis.com/maps/api/js?key=<%=application.getAttribute("google_map_api")%>&callback=initMap&language=${langCode}`;
  newScript.async = true;
  document.head.appendChild(newScript);
}
</script>



	<!-- 구글맵이 외부 JS보다 나중에 호출되어야함 위치변경 금지 -->
	<!-- 랭귀지 관련 파라메터 추가함 -->
	<script async
		src="https://maps.googleapis.com/maps/api/js?key=${applicationScope.google_map_api}&callback=initMap&language=<%= lang %>"></script>



</body>
</html>
