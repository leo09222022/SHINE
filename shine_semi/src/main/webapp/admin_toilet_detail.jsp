<%@page import="com.emerlet.vo.UserToiletVO"%>
<%@page import="com.emerlet.dao.UserToiletDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 요청 상세 정보</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function(){		
		$(".btnState").click(function(){
			let status=$(this).attr("status");
			let id = $("#id").val();
			console.log(id);
		    location.href="UpdateToiletStatus?id="+id+"&status="+status;
		});	
	});  
</script>
</head>
<body>
		<a href="admin.jsp">← 목록으로</a><br><br>
		
		<b>등록 요청</b><br>		
		화장실명: ${vo.userName }<br>
		도로명주소: ${vo.userRoadAddress }<br>
		남자화장실: ${vo.userMaleToilet }<br>
		여자화장실: ${vo.userFemaleToilet }<br>
		장애인화장실: ${vo.userDisabledToilet }<br>
		기저귀교환대: ${vo.userHasDiaperTable }<br>
		코멘트: ${vo.userDescription }<br>
		사진 URL: ${vo.photoUrl }<br><br>
		<b>등록일</b> ${vo.submittedAt }<br>
		<br>
		
		<c:if test="${vo.status == '승인대기' }">
			<input type="hidden" id="id" value="${vo.userToiletId }">			
			<button class="btnState" status="승인완료">승인</button>
   			<button class="btnState" status="반려">반려</button>
   		</c:if>
   		<c:if test="${vo.status == '승인완료' }">
   			<b>승인완료</b>
   		</c:if>
   		<c:if test="${vo.status == '반려' }">
   			<b>반려됨</b>
   		</c:if>
</body>
</html>