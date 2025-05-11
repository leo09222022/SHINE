<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  </style>
</head>
<body>

  <header>
    <h1>관리자 페이지</h1>
    <button class="logout-btn" onclick="logout()">로그아웃</button>
  </header>
	
  <main>
    <div class="section">
      <h2>등록 요청</h2>
      <div class="content-scroll">
        <%
		try {
			String sql = "select user_toilet_id, user_road_address, submitted_at "
					+ "from user_toilets where status=0 order by submitted_at";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt(1);
				String addr = rs.getString(2);
				Date submitted = rs.getDate(3);
				%>
				<div class="item"><a href="admin_toilet_detail.jsp?id=<%= id %>">[<%= submitted %>] <%= addr %> (승인 대기 중)</a></div>
				<%
			}
			ConnectionProvider.close(conn, stmt, rs);
		}catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
		%>
      </div>
    </div>

    <div class="section">
      <h2>신고 내역</h2>
      <div class="content-scroll">
        <%
		try {
			String sql = "select user_toilet_id, user_road_address, reported_at "
					+ "from user_toilets, user_toilet_reports "
					+ "where user_toilet_reports.status=1 and user_toilets.user_toilet_id=user_toilet_reports.user_toilet_id "
					+ "order by reported_at";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt(1);
				String addr = rs.getString(2);
				Date reported = rs.getDate(3);
				%>
				<div class="item"><a href="admin_report_detail.jsp?id=<%= id %>"><%= addr %></a></div>
				<%
			}
			ConnectionProvider.close(conn, stmt, rs);
		}catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
		%>
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
