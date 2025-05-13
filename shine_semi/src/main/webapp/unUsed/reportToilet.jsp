<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.emerlet.dao.ToiletDAO" %>
<%@ page import="com.emerlet.dao.UserToiletDAO" %>
<%@ page import="com.emerlet.vo.ToiletVO" %>
<%@ page import="com.emerlet.vo.UserToiletVO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String type = request.getParameter("type"); // "public" or "user"
    int refId = Integer.parseInt(request.getParameter("id"));
    String name = "", address = "";
    String male = "U", female = "U", maleDisabled = "U", femaleDisabled = "U", diaper = "U", cctv = "U", bell = "U";

    if ("public".equals(type)) {
        ToiletVO vo = new ToiletDAO().findByID(refId);
        name = vo.getName();
        address = vo.getAddressRoad();
        male = vo.getMaleToilet() > 0 ? "Y" : "N";
        female = vo.getFemaleToilet() > 0 ? "Y" : "N";
        maleDisabled = vo.getMaleDisabledToilet() > 0 ? "Y" : "N";
        femaleDisabled = vo.getFemaleDisabledToilet() > 0 ? "Y" : "N";
        diaper = vo.getHasDiaperTable() > 0 ? "Y" : "N";
        cctv = vo.getHasCctv() > 0 ? "Y" : "N";
        bell = vo.getHasEmergencyBell() > 0 ? "Y" : "N";
    } else {
        UserToiletVO vo = new UserToiletDAO().findByID(refId);
        name = vo.getUserName();
        address = vo.getUserRoadAddress();
        male = vo.getUserMaleToilet();
        female = vo.getUserFemaleToilet();
        maleDisabled = vo.getUserMaleDisabledToilet();
        femaleDisabled = vo.getUserFemaleDisabledToilet();
        diaper = vo.getUserHasDiaperTable();
        cctv = vo.getUserHasCctv();
        bell = vo.getUserHasEmergencyBell();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>화장실 정보 신고</title>
</head>
<body>
  <h2>화장실 정보 신고</h2>

  <form action="reportToiletOK.jsp" method="post">
    <input type="hidden" name="toiletType" value="<%= type %>" />
    <input type="hidden" name="toiletRefId" value="<%= refId %>" />

    <p>화장실명: <%= name %></p>
    <p>주소: <%= address %></p>

    <p>남자화장실:
      <input type="radio" name="reportMaleToilet" value="Y" <%= "Y".equals(male) ? "checked" : "" %>> 있음
      <input type="radio" name="reportMaleToilet" value="N" <%= "N".equals(male) ? "checked" : "" %>> 없음
      <input type="radio" name="reportMaleToilet" value="U" <%= (!"Y".equals(male) && !"N".equals(male)) ? "checked" : "" %>> 모름
    </p>

    <p>여자화장실:
      <input type="radio" name="reportFemaleToilet" value="Y" <%= "Y".equals(female) ? "checked" : "" %>> 있음
      <input type="radio" name="reportFemaleToilet" value="N" <%= "N".equals(female) ? "checked" : "" %>> 없음
      <input type="radio" name="reportFemaleToilet" value="U" <%= (!"Y".equals(female) && !"N".equals(female)) ? "checked" : "" %>> 모름
    </p>

    <p>남자 장애인화장실:
      <input type="radio" name="reportMaleDisabledToilet" value="Y" <%= "Y".equals(maleDisabled) ? "checked" : "" %>> 있음
      <input type="radio" name="reportMaleDisabledToilet" value="N" <%= "N".equals(maleDisabled) ? "checked" : "" %>> 없음
      <input type="radio" name="reportMaleDisabledToilet" value="U" <%= (!"Y".equals(maleDisabled) && !"N".equals(maleDisabled)) ? "checked" : "" %>> 모름
    </p>

    <p>여자 장애인화장실:
      <input type="radio" name="reportFemaleDisabledToilet" value="Y" <%= "Y".equals(femaleDisabled) ? "checked" : "" %>> 있음
      <input type="radio" name="reportFemaleDisabledToilet" value="N" <%= "N".equals(femaleDisabled) ? "checked" : "" %>> 없음
      <input type="radio" name="reportFemaleDisabledToilet" value="U" <%= (!"Y".equals(femaleDisabled) && !"N".equals(femaleDisabled)) ? "checked" : "" %>> 모름
    </p>

    <p>기저귀 교환대:
      <input type="radio" name="reportHasDiaperTable" value="Y" <%= "Y".equals(diaper) ? "checked" : "" %>> 있음
      <input type="radio" name="reportHasDiaperTable" value="N" <%= "N".equals(diaper) ? "checked" : "" %>> 없음
      <input type="radio" name="reportHasDiaperTable" value="U" <%= (!"Y".equals(diaper) && !"N".equals(diaper)) ? "checked" : "" %>> 모름
    </p>

    <p>CCTV:
      <input type="radio" name="reportHasCctv" value="Y" <%= "Y".equals(cctv) ? "checked" : "" %>> 있음
      <input type="radio" name="reportHasCctv" value="N" <%= "N".equals(cctv) ? "checked" : "" %>> 없음
      <input type="radio" name="reportHasCctv" value="U" <%= (!"Y".equals(cctv) && !"N".equals(cctv)) ? "checked" : "" %>> 모름
    </p>

    <p>비상벨:
      <input type="radio" name="reportHasEmergencyBell" value="Y" <%= "Y".equals(bell) ? "checked" : "" %>> 있음
      <input type="radio" name="reportHasEmergencyBell" value="N" <%= "N".equals(bell) ? "checked" : "" %>> 없음
      <input type="radio" name="reportHasEmergencyBell" value="U" <%= (!"Y".equals(bell) && !"N".equals(bell)) ? "checked" : "" %>> 모름
    </p>

    <p>설명 (오류 내용 등):<br>
      <textarea name="reportDescription" rows="5" cols="50"></textarea>
    </p>

    <button type="submit">신고 제출</button>
  </form>
</body>
</html>
