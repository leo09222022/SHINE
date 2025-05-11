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


<%-- mobile.jsp --%>
<div class="mobile-nav">

	<!-- 상단 -->
	<div>
		<!-- 메뉴바 -->
		<div class="mo-top">
			<img class="clickable" src="img/logo_row.svg"> <img
				class="clickable" src="img/mo_menu.svg" 
				onclick="location.href='mo_menu.html'" />


		</div>
		<!-- 검색바 -->
		<div class="mo-center-wrapper">
			<div class="search-box clickable"
				onclick="location.href='toiletSearch.do'">
				<img src="img/searchbar_marker.svg" /> <input type="text"
					class="search-input"
					placeholder="<%=bundle.getString("search.placeholder")%>"
					oninput="filterToilets(this.value)" readonly="readonly">
			</div>
		</div>

	</div>

	<!-- 하단 -->
	<div class="mo-center-wrapper">
		<div class="mobile-button-group">

			<!-- 랭귀지 설정 -->
			<div class="icon-button clickable" onclick="openLangPopup()">
				<img alt="" src="img/mo-lang.svg">
			</div>

			<!-- 필터 설정 -->
			<div class="text-button outline-button clickable"
				onclick="location.href='toiletFiltering.do'">
				<img alt="" src="img/mo-filter.svg">
				<div class="text"><%=bundle.getString("menu.filter")%></div>
			</div>

			<!-- 가까운 화장실 찾기 -->
			<div class="text-button filled-button clickable"
				onclick="centerMapToUser()">
				<div class="text"><%=bundle.getString("menu.nearby")%></div>
			</div>

		</div>

	</div>


	<!-- 랭귀시 설정 팝업 컴포넌트 -->
	<!--     <div onclick="closeLangPopup()" class="lang-close">닫기</div> -->
	<div id="langPopup" class="lang-popup clickable">
		<div class="lang-popup-body">
			<div class="lang-options">
				<button class="lang-pop-btn" onclick="changeLang('ko')">한국어</button>
				<button class="lang-pop-btn" onclick="changeLang('en')">English</button>
				<button class="lang-pop-btn" onclick="changeLang('ja')">日本語</button>
			</div>
		</div>
	</div>





</div>