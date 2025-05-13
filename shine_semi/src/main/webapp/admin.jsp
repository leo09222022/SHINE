<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <style>
    * {
      box-sizing: border-box;
    }

    html, body {
      margin: 0;
      height: 100%;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: center;
      height: 60px;
      background-color: #4CAF50;
      color: white;
      position: relative;
    }

    header h1 {
      margin: 0;
      font-size: 24px;
    }

    .logout-btn {
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      padding: 8px 16px;
      font-size: 14px;
      background-color: white;
      color: #4CAF50;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .logout-btn:hover {
      background-color: #eee;
    }

    main {
      display: flex;
      height: calc(100% - 60px); /* 헤더를 제외한 전체 높이 */
      padding: 20px;
      gap: 20px;
    }

    .section {
      flex: 1;
      background-color: white;
      border-radius: 12px;
      padding: 16px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
      overflow: hidden;
    }

    .section h2 {
      margin-top: 0;
      font-size: 18px;
      border-bottom: 1px solid #ccc;
      padding-bottom: 8px;
      flex-shrink: 0;
    }

    .content-scroll {
      overflow-y: auto;
      margin-top: 12px;
      flex-grow: 1;
    }

    .item {
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }

    .item:last-child {
      border-bottom: none;
    }
    
    .section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    
    .button-group {
      display: flex;
      gap: 8px;
    }
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script>
  	$(function(){
  		function loadRequest(status){
  			$("#request_list").empty();
  			$.get("AdminAddRequest?status="+status,function(arr){
  	  			console.log(arr);
  	  			$.each(arr,function(i, item){
  	  				let div = $("<div></div>").addClass("item");
  	  				let a = $("<a></a>").html("["+item.submittedAt+"] "+item.userRoadAddress+" ("+status+")");
  	  				$(a).attr("href","AdminToiletDetail?id="+item.userToiletId+"&status="+status);
  	  				$(div).append(a);
  	  				$("#request_list").append(div);
  	  			})
  	  		});
  		}
  		
  		function loadReport(status){
  			$("#report_list").empty();
  			$.get("AdminReport?status="+status,function(arr){
  	  			console.log(arr);
  	  			$.each(arr,function(i, item){
  	  				let div = $("<div></div>").addClass("item");
  	  				let a = $("<a></a>").html("["+item.reportedAt+"] "+item.toiletName+" ("+status+")");
  	  				$(a).attr("href","AdminReportDetail?id="+item.reportId+"&toilet_id="+item.userToiletId+"&status="+status);
  	  				$(div).append(a);
  	  				$("#report_list").append(div);
  	  			})
  	  		});
  		}
  		
  		$(".button_request").click(function(){
  			let status = $(this).attr("status");
  			//info = $(this).attr("info");
  			loadRequest(status);
  			
  		});
  		
  		$(".button_report").click(function(){
  			let status = $(this).attr("status");
  			//info = $(this).attr("info");
  			loadReport(status);
  			
  		});
  		
  		loadRequest("승인대기");
  		loadReport("신규");
  		
  		
  	});
  </script>
</head>
<body>
	<c:if test="${add=='승인완료' }">
		<script type="text/javascript">
			alert("승인되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='정보반영' }">
		<script type="text/javascript">
			alert("수정 정보가 반영되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='보류' }">
		<script type="text/javascript">
			alert("보류되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='반려' }">
		<script type="text/javascript">
			alert("반려되었습니다.");
		</script>
	</c:if>


  <header>
    <h1>관리자 페이지</h1>
    <button class="logout-btn" onclick="logout()">로그아웃</button>
  </header>
	
  <main>
    <div class="section">
      <div class="section-header">
        <h2>화장실 등록 요청</h2>
        <div class="button-group">
        <button class="button_request" status="승인대기">승인대기</button>
        <button class="button_request" status="승인완료">승인완료</button>
        <button class="button_request" status="반려">반려</button>
        </div>
      </div>
      <div class="content-scroll" id="request_list">       
      </div>
    </div>

    <div class="section">
      <div class="section-header">
        <h2>정보 오류 신고 내역</h2>
        <div class="button-group">
        <button class="button_report" status="신규">신규</button>
        <button class="button_report" status="정보반영">정보반영</button>
        <button class="button_report" status="보류">보류</button>
        <button class="button_report" status="반려">반려</button>
        </div>
      </div>
      <div class="content-scroll" id="report_list">
      </div>
    </div>
  </main>

  <script>
    function logout() {
      alert("로그아웃 되었습니다.");
      window.location.href = "index_admin.html";
    }
  </script>

</body>
</html>
