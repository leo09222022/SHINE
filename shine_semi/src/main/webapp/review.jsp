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


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title></title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/oldStyle.css" />

<script>
// 페이지 모달용 스크립트...킹쩔수 없음
  const popupCloseText = "<%=bundle.getString("popup.close")%>";
</script>

<script>
// 언어 출력용 
window.lang = "<%=lang%>";

// 다국어 마커 팝업용 스크립트
  window.i18n = {
    guide: "<%=bundle.getString("popup.guide")%>",
    lastVerified: "<%=bundle.getString("popup.lastVerified")%>",
    report: "<%=bundle.getString("popup.report")%>",
   
  };
</script>



</head>
<body>


	<script>
      // JSTL로 받아온 데이터를 JS에서 접근할 수 있게 window에 저장
      window.toiletData = [
        <c:forEach var="toilet" items="${toilets}" varStatus="status">
        {
        	cleanliness: "${fn:escapeXml(toilet.name)}",
        	safety: ${toilet.lat},
        	createdAt: ${toilet.lng},
      
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
      ];
    </script>

	<!-- 모달 컴포넌트 -->
	<div id="modalOverlay"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">
		<div id="modalBody"
			style="background: #fff; width: 90%; max-width: 800px; padding: 20px; border-radius: 8px; position: relative;">
			<button onclick="closeModal()" style="float: right;"
				class="popup-close-btn"><%=bundle.getString("popup.close")%></button>
		</div>
	</div>

	<!-- 마커용 팝업 컴포넌트 -->
	<div id="customInfoPopup">
		<div class="popup-dragbar" style="width: 48px; height: 8px; background: #ccc; border-radius: 4px; margin: 0 auto 12px auto; cursor: grab;"></div>
		<button onclick="closeCustomPopup()" style="float: right;"
			class="popup-close-btn">
			<%=bundle.getString("popup.close")%></button>
		<div id="popupContent">Loading...</div>
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


</html>
