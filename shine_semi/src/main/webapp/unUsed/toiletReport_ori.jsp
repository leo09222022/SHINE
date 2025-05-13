<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.emerlet.vo.ToiletVO" %>
<%@ page import="com.emerlet.dao.ToiletDAO" %>

<%
    int toiletID = Integer.parseInt(request.getParameter("toiletID"));
    ToiletDAO dao = new ToiletDAO();
    ToiletVO vo = dao.findByID(toiletID);
    request.setAttribute("vo", vo);

    // 숫자 기반 → Y/N/U로 변환
    String maleToiletValue = vo.getMaleToilet() > 0 ? "Y" : "N";
    String femaleToiletValue = vo.getFemaleToilet() > 0 ? "Y" : "N";
    String maleDisabledToiletValue = vo.getMaleDisabledToilet() > 0 ? "Y" : "N";
    String femaleDisabledToiletValue = vo.getFemaleDisabledToilet() > 0 ? "Y" : "N";
    String diaperValue = vo.getHasDiaperTable() > 0 ? "Y" : "N";
    String cctvValue = vo.getHasCctv() > 0 ? "Y" : "N";
    String bellValue = vo.getHasEmergencyBell() > 0 ? "Y" : "N";

    request.setAttribute("maleToiletValue", maleToiletValue);
    request.setAttribute("femaleToiletValue", femaleToiletValue);
    request.setAttribute("maleDisabledToiletValue", maleDisabledToiletValue);
    request.setAttribute("femaleDisabledToiletValue", femaleDisabledToiletValue);
    request.setAttribute("diaperValue", diaperValue);
    request.setAttribute("cctvValue", cctvValue);
    request.setAttribute("bellValue", bellValue);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>화장실 정보 신고</title>
</head>
<body>
  <h2>화장실 정보 신고</h2>

  <form action="toiletReportOK.jsp" method="post">
    <input type="hidden" name="toiletId" value="${vo.toiletId}">

    <p>화장실명: ${vo.name}</p>
    <p>주소: ${vo.addressRoad}</p>

    <p>남자화장실:
      <input type="radio" name="reportMaleToilet" value="Y" <c:if test="${maleToiletValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportMaleToilet" value="N" <c:if test="${maleToiletValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportMaleToilet" value="U" <c:if test="${maleToiletValue != 'Y' and maleToiletValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>여자화장실:
      <input type="radio" name="reportFemaleToilet" value="Y" <c:if test="${femaleToiletValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportFemaleToilet" value="N" <c:if test="${femaleToiletValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportFemaleToilet" value="U" <c:if test="${femaleToiletValue != 'Y' and femaleToiletValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>남자 장애인화장실:
      <input type="radio" name="reportMaleDisabledToilet" value="Y" <c:if test="${maleDisabledToiletValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportMaleDisabledToilet" value="N" <c:if test="${maleDisabledToiletValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportMaleDisabledToilet" value="U" <c:if test="${maleDisabledToiletValue != 'Y' and maleDisabledToiletValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>여자 장애인화장실:
      <input type="radio" name="reportFemaleDisabledToilet" value="Y" <c:if test="${femaleDisabledToiletValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportFemaleDisabledToilet" value="N" <c:if test="${femaleDisabledToiletValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportFemaleDisabledToilet" value="U" <c:if test="${femaleDisabledToiletValue != 'Y' and femaleDisabledToiletValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>기저귀 교환대:
      <input type="radio" name="reportHasDiaperTable" value="Y" <c:if test="${diaperValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportHasDiaperTable" value="N" <c:if test="${diaperValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportHasDiaperTable" value="U" <c:if test="${diaperValue != 'Y' and diaperValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>CCTV:
      <input type="radio" name="reportHasCctv" value="Y" <c:if test="${cctvValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportHasCctv" value="N" <c:if test="${cctvValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportHasCctv" value="U" <c:if test="${cctvValue != 'Y' and cctvValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>비상벨:
      <input type="radio" name="reportHasEmergencyBell" value="Y" <c:if test="${bellValue == 'Y'}">checked</c:if>> 있음
      <input type="radio" name="reportHasEmergencyBell" value="N" <c:if test="${bellValue == 'N'}">checked</c:if>> 없음
      <input type="radio" name="reportHasEmergencyBell" value="U" <c:if test="${bellValue != 'Y' and bellValue != 'N'}">checked</c:if>> 모름
    </p>

    <p>설명 (오류 내용 등):<br>
      <textarea name="reportDescription" rows="5" cols="50"></textarea>
    </p>

    <button type="submit">신고 제출</button>
  </form>
</body>
</html>
