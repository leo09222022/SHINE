package com.emerlet.dao;

import java.sql.*;
import java.util.ArrayList;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.UserToiletVO;

public class UserToiletDAO {
	
	// 사용자가 등록한 화장실 중 status가 approved로 바뀐 화장실들만 조회하는 메소드 
	public ArrayList<UserToiletVO> findApprovedToilets() {
	    ArrayList<UserToiletVO> list = new ArrayList<>();
	    String sql = "select * from user_toilets where status = 'approved'";
	    
	    try (
	        Connection conn = ConnectionProvider.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	    ) {
	        while (rs.next()) {
	            UserToiletVO vo = new UserToiletVO();
	            vo.setUserToiletId(rs.getInt("user_toilet_id"));
	            vo.setUserName(rs.getString("user_name"));
	            vo.setUserRoadAddress(rs.getString("user_road_address"));
	            vo.setUserLat(rs.getDouble("user_lat"));
	            vo.setUserLng(rs.getDouble("user_lng"));
	            vo.setUserMaleToilet(rs.getString("user_male_toilet"));
	            vo.setUserFemaleToilet(rs.getString("user_female_toilet"));
	            vo.setUserDisabledToilet(rs.getString("user_disabled_toilet"));
	            vo.setUserHasDiaperTable(rs.getString("user_has_diaper_table"));
	            vo.setUserDescription(rs.getString("user_description"));
	            list.add(vo);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}


    // 화장실 추가하고 생성된 ID 반환
    public int addUserToilet(UserToiletVO userToilet) {
        String sql = "INSERT INTO user_toilets (user_toilet_id, user_name, user_road_address, "
                + "user_male_toilet, user_female_toilet, user_disabled_toilet, user_has_diaper_table, "
                + "user_description, user_lat, user_lng, submitted_at, status, photo_url) "
                + "VALUES (user_toilet_id_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, 'pending', ?)";
        
        String[] generatedColumns = {"user_toilet_id"}; // 자동 생성되는 키 컬럼 이름
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int newId = -1;  // 실패 시 -1 반환

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql, generatedColumns);

            pstmt.setString(1, userToilet.getUserName());
            pstmt.setString(2, userToilet.getUserRoadAddress());

            // null 처리 - "모름" 일 경우 null 설정
            if (userToilet.getUserMaleToilet() == null) {
                pstmt.setNull(3, Types.CHAR);
            } else {
                pstmt.setString(3, userToilet.getUserMaleToilet());
            }

            if (userToilet.getUserFemaleToilet() == null) {
                pstmt.setNull(4, Types.CHAR);
            } else {
                pstmt.setString(4, userToilet.getUserFemaleToilet());
            }

            if (userToilet.getUserDisabledToilet() == null) {
                pstmt.setNull(5, Types.CHAR);
            } else {
                pstmt.setString(5, userToilet.getUserDisabledToilet());
            }

            if (userToilet.getUserHasDiaperTable() == null) {
                pstmt.setNull(6, Types.CHAR);
            } else {
                pstmt.setString(6, userToilet.getUserHasDiaperTable());
            }

            pstmt.setString(7, userToilet.getUserDescription());
            pstmt.setDouble(8, userToilet.getUserLat());
            pstmt.setDouble(9, userToilet.getUserLng());
            pstmt.setString(10, userToilet.getPhotoUrl());

            System.out.println("SQL 실행: " + sql);
            System.out.println("파라미터: name=" + userToilet.getUserName() + ", maleToilet="
                    + userToilet.getUserMaleToilet() + ", femaleToilet=" + userToilet.getUserFemaleToilet()
                    + ", disabledToilet=" + userToilet.getUserDisabledToilet() + ", hasDiaperTable="
                    + userToilet.getUserHasDiaperTable());

            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    newId = rs.getInt(1);
                    System.out.println("생성된 화장실 ID: " + newId);
                }
            }
            
            return newId;

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            ConnectionProvider.close(conn, pstmt, rs);
        }
    }
}