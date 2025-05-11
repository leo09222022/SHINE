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
				class="clickable" src="img/mo_menu.svg">

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
			<div class="icon-button clickable">
				<img alt="" src="img/mo-lang.svg">
			</div>
			<div class="text-button outline-button clickable"
				onclick="location.href='toiletFiltering.do'">
				<img alt="" src="img/mo-filter.svg">
				<div class="text"><%=bundle.getString("menu.filter")%></div>
			</div>
			<div class="text-button filled-button clickable"
				onclick="centerMapToUser()">
				<div class="text"><%=bundle.getString("menu.nearby")%></div>
			</div>

		</div>

	</div>


</div>