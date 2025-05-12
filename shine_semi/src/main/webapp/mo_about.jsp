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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mo_style.css" />
<style>
.content-container {
	position: static;
	left: 20px;
	top: 20px;
	width: 280px;
	height: 29px;
	opacity: 1;
	font-family: Pretendard;
	font-size: 20px;
	font-weight: normal;
	line-height: normal;
	letter-spacing: 0em;
	/* Text_main */
	color: #1D1D1F;
	z-index: 0;
}

.page-title {
	position: static;
	left: 20px;
	top: 20px;
	width: 280px;
	height: 29px;
	opacity: 1;
	font-family: Pretendard;
	font-size: 20px;
	font-weight: normal;
	line-height: normal;
	letter-spacing: 0em;
	/* Text_main */
	color: #1D1D1F;
	z-index: 0;
}

.section-title { 
	position: static;
	left: 0px;
	top: 946px;
	width: 320px;
	height: 437px;
	opacity: 1;
	/* Smart layout */
	display: flex;
	flex-direction: column;
	padding: 20px;
	gap: 8px;
	align-self: stretch;
	z-index: 3;
}

.text-content {
	position: static;
	left: 20px;
	top: 57px;
	width: 280px;
	height: 336px;
	opacity: 1;
	font-family: Pretendard;
	font-size: 16px;
	font-weight: normal;
	line-height: 150%;
	letter-spacing: 0em;
	/* Text_main */
	color: #1D1D1F;
	z-index: 1;
}

.feature-list {
	position: static;
	left: 20px;
	top: 57px;
	width: 280px;
	height: 360px;
	opacity: 1;
	font-family: Pretendard;
	font-size: 16px;
	font-weight: normal;
	line-height: 150%;
	letter-spacing: 0em;
	/* Text_main */
	color: #1D1D1F;
	z-index: 1;
}

.feature-item {
	margin-bottom: 8px;
	display: flex;
	align-items: flex-start;
}

.feature-item:before {
	content: "•";
	margin-right: 8px;
}

.contact-section {
	margin-top: 32px;
	border-top: 1px solid #EEEEEE;
	padding-top: 16px;
}

.contact-email {
	color: #3A81FF;
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="menu-header">
		<img class="cursor" src="img/logo_row.svg"
			onclick="location.href='index.html'"> <img class="cursor"
			src="img/pop__close.svg" onclick="location.href='index.html'" />
	</div>

	<div class="content-wrapper">
		<div class="content-container">
			<div class="page-title">이멀렛 소개</div>

			<div class="text-content">하루 중 누구나 한 번쯤은 공중화장실을 이용해야 할 순간이
				찾아옵니다. 특히 여행 중이거나 낯선 장소에 있을 때, 공중화장실의 위치를 빠르게 찾는 일은 더욱 중요해집니다.</div>

			<div class="text-content">이멀렛(Emerlet)은 공공장소에서 화장실을 찾는 모든 사람들을
				위한 스마트 지도 기반 화장실 안내 서비스입니다. 누구나 빠르고 쉽게 근처의 공중화장실을 검색하고, 편의시설 정보와 리뷰,
				사진, 이용 팁 등을 확인할 수 있도록 설계되었습니다.</div>

			<div class="text-content">이멀렛은 다양한 화장실 찾기를 넘어, 누구에게나 열려 있는
				플랫폼이고 접근성 높은 화장실 정보 플랫폼을 지향합니다.</div>

			<div class="section-title">주요 기능 및 서비스</div>

			<div class="text-content">위치 기반 화장실 검색: 현재 위치를 기준으로 주변의 공중화장실을
				쉽게 찾아 지도를 통해 확인할 수 있습니다.</div>

			<div class="text-content">화장실 정보 열람 및 리뷰: 이용자들이 직접 남긴 리뷰와 별점,
				사진을 통해 화장실의 상태와 청결도, 접근성에 대한 여부를 미리 확인할 수 있습니다.</div>

			<div class="text-content">화장실 제보 및 추천 요청: 사용자가 직접 화장실 정보를 등록하거나
				잘못된 정보를 수정 요청할 수 있습니다.</div>

			<div class="text-content">다국어 지원: 한국어, 영어, 일본어를 지원하여 외국인 관광객도
				불편 없이 이용할 수 있습니다.</div>

			<div class="text-content">필터/옵션 고급 사용 기능: 화장가기용 화장실 외에도 화장실 검색
				및 정보 열람이 가능하며, 등록 시에는 더 많은 기능을 누릴 수 있습니다.</div>

			<div class="section-title">공공화장실의 정의</div>

			<div class="text-content">이멀렛이 제공하는 정보는 다음과 같은 공공 접근이 가능한 화장실을
				기준으로 합니다:</div>

			<div class="feature-list">
				<div class="feature-item">지자체가 관리하는 공공화장실</div>
				<div class="feature-item">지하철역, 기차역, 버스터미널, 공항, 휴게소 등 교통시설 내
					화장실</div>
				<div class="feature-item">시장, 도서관, 병원, 박물관, 체육센터 등 공공기관 화장실</div>
				<div class="feature-item">쇼핑몰, 대형마트 등 누구나 이용 가능한 민간시설 화장실</div>
				<div class="feature-item">지자체와 협약된 개방 화장실(매장 등)</div>
			</div>

			<div class="text-content">단, 일부 고객만 이용 가능한 제한적 화장실(예: 매장 내 고객
				전용 화장실)은 가급적 제외하고 있으며, 유의미한 정보일 경우 예외적으로 안내할 수 있습니다.</div>

			<div class="section-title">사용자 참여</div>

			<div class="text-content">여러분의 참여가 이멀렛을 더욱 정확하고 풍부한 정보 플랫폼으로
				만듭니다. 새로운 화장실을 제보하거나 잘못된 정보를 발견하셨다면 언제든지 등록 또는 수정 요청해 주세요.</div>

			<div class="contact-section">
				<div class="text-content">
					<strong>Contact Us</strong><br> If you have any problems
					updating the toilets, or wish to send us toilet details or
					comments, please contact <a href="mailto:shine-emerlet@gmail.com"
						class="contact-email">shine-emerlet@gmail.com</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>