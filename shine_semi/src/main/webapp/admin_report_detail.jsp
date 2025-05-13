<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Àý°­ 내용 상세 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
  body {
    font-family: 'Pretendard', sans-serif;
    background-color: #f9f9f9;
    padding: 40px;
    line-height: 1.6;
  }
  .container {
    background: #fff;
    padding: 32px;
    max-width: 700px;
    margin: auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  .label {
    font-weight: 600;
    color: #3A81FF;
    margin-top: 24px;
    display: block;
  }
  .value {
    margin-top: 4px;
    margin-bottom: 16px;
    color: #333;
  }
  .btnState {
    padding: 10px 20px;
    margin: 8px 6px 0 0;
    background-color: #3A81FF;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
  }
  .btnState:hover {
    background-color: #2a63cc;
  }
  .status-label {
    font-weight: bold;
    color: #555;
    margin-top: 24px;
  }
  a {
    color: #3A81FF;
    text-decoration: none;
    font-size: 14px;
  }
  a:hover {
    text-decoration: underline;
  }
</style>
<script>
$(function(){
  $(".btnState").click(function(){
    let status = $(this).attr("status");
    let id = $("#id").val();
    let toilet_id = ${vo1.reportId};
    let male_toilet = $("#male_toilet").html();
    let female_toilet = $("#female_toilet").html();
    let disabled_toilet = $("#disabled_toilet").html();
    let has_diaper_table = $("#has_diaper_table").html();
    let description = $("#description").html();
    let photo_url = $("#photo_url").html();

    let queryString = 
      "male_toilet=" + male_toilet +
      "&female_toilet=" + female_toilet +
      "&disabled_toilet=" + disabled_toilet +
      "&has_diaper_table=" + has_diaper_table +
      "&description=" + description +
      "&photo_url=" + photo_url;

    location.href = "UpdateReportStatus?id=" + id + "&toilet_id=" + toilet_id + "&status=" + status + "&" + queryString;
  });
});
</script>
</head>
<body>
  <div class="container">
    <a href="admin.jsp">← 목록으로</a>
    <div class="label">화장실명</div>
    <div class="value">${vo2.userName}</div>

    <div class="label">도로명주소</div>
    <div class="value">${vo2.userRoadAddress}</div>

    <div class="label">수정 전</div>
    <div class="value">
      남자화장실: ${vo2.userMaleToilet}<br>
      여자화장실: ${vo2.userFemaleToilet}<br>
      장애인화장실: ${vo2.userDisabledToilet}<br>
      기저기교통대: ${vo2.userHasDiaperTable}<br>
      코멘트: ${vo2.userDescription}
    </div>

    <div class="label">수정 후</div>
    <div class="value">
      남자화장실: <span id="male_toilet">${empty vo1.reportMaleToilet ? vo2.userMaleToilet : vo1.reportMaleToilet}</span><br>
      여자화장실: <span id="female_toilet">${empty vo1.reportFemaleToilet ? vo2.userFemaleToilet : vo1.reportFemaleToilet}</span><br>
      장애인화장실: <span id="disabled_toilet">${empty vo1.reportDisabledToilet ? vo2.userDisabledToilet : vo1.reportDisabledToilet}</span><br>
      기저기교통대: <span id="has_diaper_table">${empty vo1.reportHasDiaperTable ? vo2.userHasDiaperTable : vo1.reportHasDiaperTable}</span><br>
      코멘트: <span id="description">${empty vo1.reportDescription ? vo2.userDescription : vo1.reportDescription}</span>
    </div>

    <div class="label">사진오류</div>
    <div class="value" id="photo_url">${vo1.reportPhotoError}</div>

    <div class="label">신고일</div>
    <div class="value">${vo1.reportedAt}</div>

    <input type="hidden" id="id" value="${vo1.reportId}">

    <c:if test="${vo1.reportStatus == '신규'}">
      <button class="btnState" status="정보반영">정보반영</button>
      <button class="btnState" status="보류">보류</button>
      <button class="btnState" status="반려">반려</button>
    </c:if>
    <c:if test="${vo1.reportStatus == '보류'}">
      <button class="btnState" status="정보반영">정보반영</button>
      <button class="btnState" status="반려">반려</button>
    </c:if>
    <c:if test="${vo1.reportStatus == '정보반영'}">
      <div class="status-label">반영완료</div>
    </c:if>
    <c:if test="${vo1.reportStatus == '반려'}">
      <div class="status-label">반려됨</div>
    </c:if>
  </div>
</body>
</html>