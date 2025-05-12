<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.emerlet.vo.ToiletVO" %>
<%@ page import="com.emerlet.dao.ToiletDAO" %>

<%
    int toiletID = Integer.parseInt(request.getParameter("toiletID"));
    ToiletDAO dao = new ToiletDAO();
    ToiletVO vo = dao.findByID(toiletID);
    request.setAttribute("vo", vo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>화장실 정보 신고</title>
</head>
<body>
  <h2>화장실 정보 신고</h2>

  <form action="toiletReportOK.do" method="post">
    <!-- 신고 테이블에 insert할 정보들 -->
    <input type="hidden" name="toiletId" value="${vo.toiletId}">

    <p>화장실명: ${vo.name}</p>
    <p>주소: ${vo.addressRoad}</p>

    <p>남자화장실:
      <input type="radio" name="reportMaleToilet" value="Y"> 있음
      <input type="radio" name="reportMaleToilet" value="N"> 없음
      <input type="radio" name="reportMaleToilet" value="U" checked> 모름
    </p>

    <p>여자화장실:
      <input type="radio" name="reportFemaleToilet" value="Y"> 있음
      <input type="radio" name="reportFemaleToilet" value="N"> 없음
      <input type="radio" name="reportFemaleToilet" value="U" checked> 모름
    </p>

    <p>남자 장애인화장실:
      <input type="radio" name="reportMaleDisabledToilet" value="Y"> 있음
      <input type="radio" name="reportMaleDisabledToilet" value="N"> 없음
      <input type="radio" name="reportMaleDisabledToilet" value="U" checked> 모름
    </p>

    <p>여자 장애인화장실:
      <input type="radio" name="reportFemaleDisabledToilet" value="Y"> 있음
      <input type="radio" name="reportFemaleDisabledToilet" value="N"> 없음
      <input type="radio" name="reportFemaleDisabledToilet" value="U" checked> 모름
    </p>

    <p>기저귀 교환대:
      <input type="radio" name="reportHasDiaperTable" value="Y"> 있음
      <input type="radio" name="reportHasDiaperTable" value="N"> 없음
      <input type="radio" name="reportHasDiaperTable" value="U" checked> 모름
    </p>

    <p>CCTV:
      <input type="radio" name="reportHasCctv" value="Y"> 있음
      <input type="radio" name="reportHasCctv" value="N"> 없음
      <input type="radio" name="reportHasCctv" value="U" checked> 모름
    </p>

    <p>비상벨:
      <input type="radio" name="reportHasEmergencyBell" value="Y"> 있음
      <input type="radio" name="reportHasEmergencyBell" value="N"> 없음
      <input type="radio" name="reportHasEmergencyBell" value="U" checked> 모름
    </p>

    <p>설명 (오류 내용 등):<br>
      <textarea name="reportDescription" rows="5" cols="50"></textarea>
    </p>

    <p>
      사진 오류가 있는 경우 체크: <input type="checkbox" name="reportPhotoError" value="Y">
    </p>

    <button type="submit">신고 제출</button>
  </form>
</body>
</html>
