<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="com.emerlet.dao.UserToiletDAO"%>
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
<title>등록 요청 상세 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
  body {
    font-family: 'Pretendard', sans-serif;
    background-color: #f5f5f5;
    padding: 40px;
  }
  .container {
    background: white;
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
    margin: 10px 10px 0 0;
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
      location.href = "UpdateToiletStatus?id=" + id + "&status=" + status;
    });
  });
</script>
</head>
<body>
  <div class="container">
    <a href="admin.jsp">← 목록으로</a>

    <div class="label">등록 요청</div>
    <div class="value">
      화장실명: ${vo.userName}<br>
      도로명주소: ${vo.userRoadAddress}<br>
      남자화장실: ${vo.userMaleToilet}<br>
      여자화장실: ${vo.userFemaleToilet}<br>
      장애인화장실: ${vo.userDisabledToilet}<br>
      기저귀교환대: ${vo.userHasDiaperTable}<br>
      코멘트: ${vo.userDescription}<br>
      사진 URL: ${vo.photoUrl}
    </div>

    <div class="label">등록일</div>
    <div class="value">${vo.submittedAt}</div>

    <input type="hidden" id="id" value="${vo.userToiletId}">

    <c:if test="${vo.status == '승인대기'}">
      <button class="btnState" status="승인완료">승인</button>
      <button class="btnState" status="반려">반려</button>
    </c:if>

    <c:if test="${vo.status == '승인완료'}">
      <div class="status-label">승인완료</div>
    </c:if>
    <c:if test="${vo.status == '반려'}">
      <div class="status-label">반려됨</div>
    </c:if>
  </div>
</body>
</html>