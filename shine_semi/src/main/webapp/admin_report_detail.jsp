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
<title>신고 내용 상세 정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function(){		
		$(".btnState").click(function(){
			let status=$(this).attr("status");
			let id = $("#id").val();
			let toilet_id = ${vo1.reportId };
			console.log(id);
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
		    location.href="UpdateReportStatus?id="+id+"&toilet_id="+toilet_id+"&status="+status+"&"+queryString;		    
		    
		    
		});	
	});  
</script>
</head>
<body>
	<a href="admin.jsp">← 목록으로</a><br><br>
	
	<b>화장실명</b><br>
	${vo2.userName }<br>
	<b>도로명주소</b><br>
	${vo2.userRoadAddress }<br><br>
	
	<b>수정 전</b><br>	
	남자화장실: ${vo2.userMaleToilet }<br>
	여자화장실: ${vo2.userFemaleToilet }<br>
	장애인화장실: ${vo2.userDisabledToilet }<br>
	기저귀교환대: ${vo2.userHasDiaperTable }<br>
	코멘트: ${vo2.userDescription }<br>
	<br>
	
	<b>수정 후</b><br>	
	남자화장실: 
	<c:if test="${vo1.reportMaleToilet == null }">
		<span id="male_toilet">${vo2.userMaleToilet }</span>
	</c:if>
	<c:if test="${vo1.reportMaleToilet != null }">
		<span id="male_toilet">${vo1.reportMaleToilet }</span>
	</c:if>
	
	<br>
	여자화장실: 
	<c:if test="${vo1.reportFemaleToilet == null }">
		<span id="female_toilet">${vo2.userFemaleToilet }</span>
	</c:if>
	<c:if test="${vo1.reportFemaleToilet != null }">
		<span id="female_toilet">${vo1.reportFemaleToilet }</span>
	</c:if>
	<br>
	
	장애인화장실: 
	<c:if test="${vo1.reportDisabledToilet == null }">
		<span id="disabled_toilet">${vo2.userDisabledToilet }</span>
	</c:if>
	<c:if test="${vo1.reportDisabledToilet != null }">
		<span id="disabled_toilet">${vo1.reportDisabledToilet }</span>
	</c:if>
	<br>
	
	기저귀교환대: 
	<c:if test="${vo1.reportHasDiaperTable == null }">
		<span id="has_diaper_table">${vo2.userHasDiaperTable }</span>
	</c:if>
	<c:if test="${vo1.reportHasDiaperTable != null }">
		<span id="has_diaper_table">${vo1.reportHasDiaperTable }</span>
	</c:if>
	<br>
	
	코멘트: 
	<c:if test="${vo1.reportDescription== null }">
		<span id="description">${vo2.userDescription }</span>
	</c:if>
	<c:if test="${vo1.reportDescription != null }">
		<span id="description">${vo1.reportDescription }</span>
	</c:if>
	<br><br>
	
	<b>사진오류</b> <span id="photo_url">${vo1.reportPhotoError }</span><br><br>
	
	<b>신고일</b> ${vo1.reportedAt }<br><br>
	
	<input type="hidden" id="id" value="${vo1.reportId }">			
	<c:if test="${vo1.reportStatus == '신규' }">		
		<button class="btnState" status="정보반영">정보반영</button>
		<button class="btnState" status="보류">보류</button>
		<button class="btnState" status="반려">반려</button>
	</c:if>
	<c:if test="${vo1.reportStatus == '보류' }">	
		<button class="btnState" status="정보반영">정보반영</button>
		<button class="btnState" status="반려">반려</button>
	</c:if>
	<c:if test="${vo1.reportStatus == '정보반영' }">
		<b>반영완료</b>
	</c:if>
	<c:if test="${vo1.reportStatus == '반려' }">
		<b>반려됨</b>
	</c:if>
</body>
</html>