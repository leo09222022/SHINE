<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String lang = request.getParameter("lang");
  if (lang != null) {
    session.setAttribute("lang", lang); // 서버 세션 설정은 유지
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>언어 설정</title>
  <script>
    //  클라이언트에 sessionStorage.lang 설정
    const lang = "<%= lang %>";
    sessionStorage.setItem("lang", lang);

    // JS로 페이지 이동
    location.href = "Emerlet";
  </script>