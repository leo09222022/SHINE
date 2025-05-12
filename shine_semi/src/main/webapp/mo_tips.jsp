<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Locale, java.util.ResourceBundle" %>
<%
String lang = (String) session.getAttribute("lang");
if (lang == null) lang = "ko";
Locale locale = new Locale(lang);
ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Korean Toilet Guide</title>
  <link rel="stylesheet" href="css/mo_style.css" />
  <style>
    .tip-section { padding: 16px; border-bottom: 1px solid #eee; }
    .tip-toggle { font-size: 16px; font-weight: 500; cursor: pointer; display: flex; justify-content: space-between; align-items: center; }
    .tip-content { display: none; margin-top: 10px; font-size: 14px; background: #f7f8fc; padding: 12px; border-radius: 6px; line-height: 1.5; }
    .tip-section.open .tip-content { display: block; }
    .sign-title { font-weight: 600; margin-top: 10px; margin-bottom: 6px; }
    .sign-button { background-color: #111; color: white; padding: 10px; border: none; border-radius: 4px; font-size: 14px; width: 100%; margin-bottom: 6px; }
  </style>
</head>
<body>
<div class="menu-header">
  <img class="cursor" src="img/logo_row.svg" onclick="location.href='index.html'">
  <img class="cursor" src="img/pop__close.svg" onclick="location.href='index.html'" />
</div>
<div class="content-wrapper">
  <div class="content-title">Korean Toilet Guide</div>
  <div class="content-container">
    <% for (int i = 1; i <= 10; i++) { %>
      <div class="tip-section">
        <div class="tip-toggle" onclick="this.parentElement.classList.toggle('open')">
          <span>&#x25BC; <%= bundle.getString("tip." + i) %></span>
        </div>
        <div class="tip-content">
          <p><%= bundle.getString("tip." + i + "Toggle") %></p>
          <%-- 표시판 예시 버튼 추가 --%>
          <c:choose>
            <c:when test="<%= i == 1 %>">
              <div class="sign-title"><%= bundle.getString("sign.example") %></div>
              <button class="sign-button"><%= bundle.getString("tip.firstSign1") %></button>
              <button class="sign-button"><%= bundle.getString("tip.firstSign2") %></button>
            </c:when>
            <c:when test="<%= i == 2 %>">
              <button class="sign-button"><%= bundle.getString("tip.secondSign") %></button>
            </c:when>
            <c:when test="<%= i == 3 %>">
              <button class="sign-button"><%= bundle.getString("tip.thirdSign") %></button>
            </c:when>
            <c:when test="<%= i == 4 %>">
              <button class="sign-button"><%= bundle.getString("tip.fourthSign") %></button>
            </c:when>
            <c:when test="<%= i == 5 %>">
              <button class="sign-button"><%= bundle.getString("tip.fifthSign") %></button>
            </c:when>
            <c:when test="<%= i == 6 %>">
              <button class="sign-button"><%= bundle.getString("tip.sixthSign") %></button>
            </c:when>
            <c:when test="<%= i == 7 %>">
              <button class="sign-button"><%= bundle.getString("tip.seventhSign") %></button>
            </c:when>
            <c:when test="<%= i == 9 %>">
              <button class="sign-button"><%= bundle.getString("tip.ninthSign") %></button>
            </c:when>
          </c:choose>
        </div>
      </div>
    <% } %>
  </div>
</div>
</body>
</html>