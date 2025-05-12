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
/* 기존 mo_style.css 파일에서 없는 추가 스타일 */
.container {
    position: relative;
    width: 320px;
    height: 568px;
    margin: 0 auto;
    background: #F8F7F7;
}

.menu-header {
    width: 100%;
    height: 48px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 12px 20px;
    background: #FFFFFF;
    box-sizing: border-box;
    z-index: 0;
}

.emerlet-logo {
    width: 88.55px;
    height: 16px;
}

.menu-items {
    display: flex;
    flex-direction: column;
    padding: 20px 40px;
    gap: 20px;
    width: 320px;
    height: 520px;
    background: #FFFFFF;
    box-sizing: border-box;
    flex-grow: 1;
    align-self: stretch;
    z-index: 1;
}

.menu-item {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 0px;
    width: 240px;
    height: 24px;
    align-self: stretch;
    cursor: pointer;
}

.menu-item-content {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 6px;
}

.menu-icon {
    width: 24px;
    height: 24px;
}

.menu-more {
    width: 20px;
    height: 20px;
}

.menu-item span {
    font-family: Pretendard;
    font-size: 16px;
    font-weight: normal;
    line-height: normal;
    letter-spacing: 0em;
    color: #1D1D1F;
}
</style>
</head>
<body>
    <div class="container">
        <!-- 헤더 영역 -->
        <div class="menu-header">
            <img class="emerlet-logo cursor" src="img/logo_row.svg" alt="Emerlet" onclick="location.href='index.html'">
            <img class="close-icon cursor" src="img/pop__close.svg" onclick="window.history.back()">
        </div>

        <!-- 메뉴 항목 영역 -->
        <div class="menu-items">
            <!-- About 메뉴 -->
            <div class="menu-item" onclick="location.href='mo_about.jsp'">
                <div class="menu-item-content">
                    <img class="menu-icon" src="img/menu_plus.svg" alt="About">
                    <span><%=bundle.getString("footer.about")%></span>
                </div>
                <img class="menu-more" src="img/menu_more.svg" alt=">">
            </div>
            
            <!-- Contact 메뉴 -->
            <div class="menu-item" onclick="location.href='mo_contact.jsp'">
                <div class="menu-item-content">
                    <img class="menu-icon" src="img/menu_plus.svg" alt="Contact">
                    <span><%=bundle.getString("footer.contact")%></span>
                </div>
                <img class="menu-more" src="img/menu_more.svg" alt=">">
            </div>
            
            <!-- Support Us 메뉴 -->
            <div class="menu-item" onclick="location.href='mo_support.jsp'">
                <div class="menu-item-content">
                    <img class="menu-icon" src="img/menu_plus.svg" alt="Support">
                    <span><%=bundle.getString("footer.support")%></span>
                </div>
                <img class="menu-more" src="img/menu_more.svg" alt=">">
            </div>
            
            <!-- 화장실 등록 메뉴 -->
            <div class="menu-item" onclick="location.href='toiletAdd.jsp'">
                <div class="menu-item-content">
                    <img class="menu-icon" src="img/menu_plus.svg" alt="Register">
                    <span><%=bundle.getString("menu.register")%></span>
                </div>
                <img class="menu-more" src="img/menu_more.svg" alt=">">
            </div>
            
            <!-- Korean Toilet Guide 메뉴 -->
            <div class="menu-item" onclick="location.href='toiletGuide.html'">
                <div class="menu-item-content">
                    <img class="menu-icon" src="img/meny_guide.svg" alt="Guide">
                    <span><%=bundle.getString("menu.guide")%></span>
                </div>
                <img class="menu-more" src="img/menu_more.svg" alt=">">
            </div>
        </div>
    </div>
</body>
</html>