<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 내용 상세 정보</title>
<script>
    function handleAction(actionType) {
	  let message;
      if(actionType === 'apply'){
    	  message = '정보 반영되었습니다.'
      }else if(actionType === 'postpone'){
    	  message = '보류되었습니다.';
      }else{
    	  message = '반려되었습니다.';
      }
      alert(message);
      document.getElementById("actionForm_" + actionType).submit();
    }
</script>
</head>
<body>
<%
		request.setCharacterEncoding("UTF-8");
	
		int id = Integer.parseInt(request.getParameter("id"));
		String action = request.getParameter("action");
		
		try {	
			Connection conn = ConnectionProvider.getConnection();
			String sql = "select * from user_toilet_reports where report_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			int user_toilet_id;
			if(rs.next()){
				user_toilet_id = rs.getInt("user_toilet_id");
			}else{
				return;
			}
			ConnectionProvider.close(conn, pstmt, rs);
			
			conn = ConnectionProvider.getConnection();
			sql = "select * from user_toilets where user_toilet_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_toilet_id);
			rs = pstmt.executeQuery();
			
			String p_name, p_male_toilet, p_female_toilet, p_disabled_toilet, p_has_diaper_table, p_description;
			if(rs.next()){
				p_name = rs.getString("user_name");
				if(rs.getInt("user_male_toilet") == 1){
					p_male_toilet = "O";
				}else if(rs.getInt("user_male_toilet") == 0){
					p_male_toilet = "X";
				}else{
					p_male_toilet = "정보 없음";
				}
				if(rs.getInt("user_female_toilet") == 1){
					p_female_toilet = "O";
				}else if(rs.getInt("user_female_toilet") == 0){
					p_female_toilet = "X";
				}else{
					p_female_toilet = "정보 없음";
				}
				if(rs.getInt("user_disabled_toilet") == 1){
					p_disabled_toilet = "O";
				}else if(rs.getInt("user_disabled_toilet") == 0){
					p_disabled_toilet = "X";
				}else{
					p_disabled_toilet = "정보 없음";
				}
				if(rs.getInt("user_has_diaper_table") == 1){
					p_has_diaper_table = "O";
				}else if(rs.getInt("user_has_diaper_table") == 0){
					p_has_diaper_table = "X";
				}else{
					p_has_diaper_table = "정보 없음";
				}
				if(rs.getString("user_description") == null){
					p_description = "";
				}else{
					p_description = rs.getString("user_description");
				}
			}else{
				return;
			}
			ConnectionProvider.close(conn, pstmt, rs);
			
			conn = ConnectionProvider.getConnection();
			sql = "select * from user_toilet_reports where report_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			String reason, name, male_toilet, female_toilet, disabled_toilet, has_diaper_table, description, photo_error;
			if(rs.next()){
				reason = rs.getString("reason");
				if(rs.getString("user_name") == null){
					name = p_name;
				}else{
					name = rs.getString("user_name");
				}
				int temp = rs.getInt("user_male_toilet");
				if(rs.wasNull()){
					male_toilet = p_male_toilet;
				}else{
					if(rs.getInt("user_male_toilet") == 1){
						male_toilet = "O";
					}else if(rs.getInt("user_male_toilet") == 0){
						male_toilet = "X";
					}else{
						male_toilet = "정보 없음";
					}
				}
				temp = rs.getInt("user_female_toilet");
				if(rs.wasNull()){
					female_toilet = p_female_toilet;
				}else{
					if(rs.getInt("user_female_toilet") == 1){
						female_toilet = "O";
					}else if(rs.getInt("user_female_toilet") == 0){
						female_toilet = "X";
					}else{
						female_toilet = "정보 없음";
					}
				}
				temp = rs.getInt("user_disabled_toilet");
				if(rs.wasNull()){
					disabled_toilet = p_disabled_toilet;
				}else{
					if(rs.getInt("user_disabled_toilet") == 1){
						disabled_toilet = "O";
					}else if(rs.getInt("user_disabled_toilet") == 0){
						disabled_toilet = "X";
					}else{
						disabled_toilet = "정보 없음";
					}
				}
				temp = rs.getInt("user_has_diaper_table");
				if(rs.wasNull()){
					has_diaper_table = p_has_diaper_table;
				}else{
					if(rs.getInt("user_has_diaper_table") == 1){
						has_diaper_table = "O";
					}else if(rs.getInt("user_has_diaper_table") == 0){
						has_diaper_table = "X";
					}else{
						has_diaper_table = "정보 없음";
					}
				}
				if(rs.getString("user_description") == null){
					description = p_description;
				}else{
					description = rs.getString("user_description");
				}
				if(rs.getInt("photo_error") == 1){
					photo_error = "O";
				}else{
					photo_error = "X";
				}
			}else{
				return;
			}			
			ConnectionProvider.close(conn, pstmt, rs);
			
			if (action != null && (action.equals("apply") || action.equals("postpone") || action.equals("reject"))) {
				try {
					conn = ConnectionProvider.getConnection();
					int status;
					if(action.equals("apply")){
						status = 1;
						sql = "update user_toilets set user_name=?, user_male_toilet=?, user_female_toilet=?, user_disabled_toilet=?, user_has_diaper_table=?, user_description=? where user_toilet_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, name);
						if(male_toilet == "O"){
							pstmt.setInt(2, 1);
						}else if(male_toilet == "X"){
							pstmt.setInt(2, 0);
						}else{
							pstmt.setInt(2, 2);
						}
						if(female_toilet == "O"){
							pstmt.setInt(3, 1);
						}else if(female_toilet == "X"){
							pstmt.setInt(3, 0);
						}else{
							pstmt.setInt(3, 2);
						}
						if(disabled_toilet == "O"){
							pstmt.setInt(4, 1);
						}else if(disabled_toilet == "X"){
							pstmt.setInt(4, 0);
						}else{
							pstmt.setInt(4, 2);
						}
						if(has_diaper_table == "O"){
							pstmt.setInt(5, 1);
						}else if(has_diaper_table == "X"){
							pstmt.setInt(5, 0);
						}else{
							pstmt.setInt(5, 2);
						}
						pstmt.setString(6, description);
						pstmt.setInt(7, user_toilet_id);
						pstmt.executeUpdate();
						
						if(photo_error.equals("O")){
							sql = "update user_toilets set photo_url=null where user_toilet_id=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, user_toilet_id);
							pstmt.executeUpdate();
						}
						
						sql = "update user_toilets set user_edit_request=0 where user_toilet_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, user_toilet_id);
						pstmt.executeUpdate();
					}else if(action.equals("postpone")){
						status = 2;
					}else{
						status = 3;
					}
					sql = "update user_toilet_reports set status=? where report_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, status);
					pstmt.setInt(2, id);
					pstmt.executeUpdate();
					ConnectionProvider.close(conn, pstmt);
					
					response.sendRedirect("admin.jsp");
				    return;
				}catch (Exception e) {
					e.printStackTrace();
					System.out.println("예외발생:"+e.getMessage());
				}
			}

			%>
			
			<a href="admin.jsp">← 목록으로</a><br><br>
			<b>수정 전</b><br>
			화장실명: <%=p_name %><br>
			남자화장실: <%=p_male_toilet %><br>
			여자화장실: <%=p_female_toilet %><br>
			장애인화장실: <%=p_disabled_toilet %><br>
			기저귀교환대: <%=p_has_diaper_table %><br>
			코멘트: <%=p_description %><br>
			<br>
			
			<b>수정 후</b><br>
			화장실명: <%=name %><br>
			남자화장실: <%=male_toilet %><br>
			여자화장실: <%=female_toilet %><br>
			장애인화장실: <%=disabled_toilet %><br>
			기저귀교환대: <%=has_diaper_table %><br>
			코멘트: <%=description %><br>
			<br>
			
			사진오류: <%=photo_error %><br><br>
			
			<b>신고사유</b><br>
			<%=reason %><br><br>
			
			<form id="actionForm_apply" method="get" style="display:inline;">
				<input type="hidden" name="id" value="<%= id %>">
				<input type="hidden" name="action" value="apply">
				<button type="button" onclick="handleAction('apply')">정보 반영</button>
			</form>

			<form id="actionForm_postpone" method="get" style="display:inline;">
    			<input type="hidden" name="id" value="<%= id %>">
    			<input type="hidden" name="action" value="postpone">
    			<button type="button" onclick="handleAction('postpone')">보류</button>
			</form>
			
			<form id="actionForm_reject" method="get" style="display:inline;">
    			<input type="hidden" name="id" value="<%= id %>">
    			<input type="hidden" name="action" value="reject">
    			<button type="button" onclick="handleAction('reject')">반려</button>
			</form>
			<%
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("예외발생:"+e.getMessage());
		}
	%>
</body>
</html>