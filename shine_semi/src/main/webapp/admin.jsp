<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Emerlet 관리자 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/mo_style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
body {
	font-family: 'Pretendard', sans-serif;
	margin: 0;
	background-color: #f5f5f5;
}

header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16px 24px;
	background-color: #3A81FF;
	color: white;
}

header h1 {
	margin: 0;
	font-size: 20px;
}

.logout-btn {
	background-color: white;
	color: #3A81FF;
	padding: 8px 16px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
}

.logout-btn:hover {
	background-color: #e3eaff;
}

main {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 24px;
}

.section {
	height: calc(100vh - 140px);
	display: flex;
	flex-direction: column;
	background-color: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	flex: 1 1 48%;
	padding: 20px;
	min-width: 320px;
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12px;
}

.section h2 {
	margin: 0;
	font-size: 18px;
	color: #333;
}

.button-group {
	display: flex;
	gap: 8px;
}

.button-group button {
	padding: 6px 12px;
	border: none;
	border-radius: 6px;
	background-color: #3A81FF;
	color: white;
	cursor: pointer;
	font-size: 14px;
}

.button-group button:hover {
	background-color: #2a63cc;
}

.content-scroll {
	flex-grow: 1;
	overflow-y: auto;
	border-top: 1px solid #eee;
	padding-top: 10px;
}


.item {
	padding: 10px 0;
	border-bottom: 1px solid #eee;
}

.item a {
	color: #1D1D1F;
	text-decoration: none;
}

.item a:hover {
	text-decoration: underline;
}
</style>
<script>
	$(function() {
		function loadRequest(status) {
			$("#request_list").empty();
			$.get("AdminAddRequest?status=" + status, function(arr) {
				$.each(arr, function(i, item) {
					let div = $("<div></div>").addClass("item");
					let a = $("<a></a>").html(
							"[" + item.submittedAt + "] "
									+ item.userRoadAddress + " (" + status
									+ ")");
					$(a).attr(
							"href",
							"AdminToiletDetail?id=" + item.userToiletId
									+ "&status=" + status);
					$(div).append(a);
					$("#request_list").append(div);
				})
			});
		}

		function loadReport(status) {
			$("#report_list").empty();
			$.get("AdminReport?status=" + status, function(arr) {
				$.each(arr, function(i, item) {
					let div = $("<div></div>").addClass("item");
					let a = $("<a></a>").html(
							"[" + item.reportedAt + "] " + item.toiletName
									+ " (" + status + ")");
					$(a).attr(
							"href",
							"AdminReportDetail?id=" + item.reportId
									+ "&toilet_id=" + item.userToiletId
									+ "&status=" + status);
					$(div).append(a);
					$("#report_list").append(div);
				})
			});
		}

		$(".button_request").click(function() {
			let status = $(this).attr("status");
			loadRequest(status);
		});

		$(".button_report").click(function() {
			let status = $(this).attr("status");
			loadReport(status);
		});

		loadRequest("승인대기");
		loadReport("신규");
	});

	function logout() {
		alert("로그아웃 되었습니다.");
		window.location.href = "admin_login.jsp";
	}
</script>
</head>
<body>
	<c:if test="${add=='승인완료' }">
		<script>
			alert("승인되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='정보반영' }">
		<script>
			alert("수정 정보가 반영되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='보류' }">
		<script>
			alert("보류되었습니다.");
		</script>
	</c:if>
	<c:if test="${add=='반려' }">
		<script>
			alert("반려되었습니다.");
		</script>
	</c:if>

	<header>
		<h1>Emerlet 관리자 페이지</h1>
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
			<div class="content-scroll" id="request_list"></div>
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
			<div class="content-scroll" id="report_list"></div>
		</div>
	</main>
</body>
</html>
