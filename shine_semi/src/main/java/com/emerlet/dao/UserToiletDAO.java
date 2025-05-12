package com.emerlet.dao;

import java.sql.*;
import java.util.ArrayList;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.UserToiletVO;

public class UserToiletDAO {
	
	// 사용자가 등록한 화장실 중 status가 approved로 바뀐 화장실들만 조회하는 메소드 
	public ArrayList<UserToiletVO> findApprovedToilets() {
	    ArrayList<UserToiletVO> list = new ArrayList<>();
	    String sql = "SELECT * FROM user_toilets WHERE status = 'approved'";
	    
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
	            vo.setUserMaleDisabledToilet(rs.getString("user_male_disabled_toilet"));
	            vo.setUserFemaleDisabledToilet(rs.getString("user_female_disabled_toilet")); 
	            vo.setUserHasDiaperTable(rs.getString("user_has_diaper_table"));
	            vo.setUserHasEmergencyBell(rs.getString("user_has_emergency_bell")); 
	            vo.setUserHasCctv(rs.getString("user_has_cctv")); 
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
                + "user_male_toilet, user_female_toilet, user_male_disabled_toilet, user_female_disabled_toilet, "
                + "user_has_diaper_table, user_has_emergency_bell, user_has_cctv, "
                + "user_description, user_lat, user_lng, submitted_at, status, photo_url) "
                + "VALUES (user_toilet_id_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, 'pending', ?)";

        String[] generatedColumns = { "user_toilet_id" };
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int newId = -1;

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql, generatedColumns);

            pstmt.setString(1, userToilet.getUserName());
            pstmt.setString(2, userToilet.getUserRoadAddress());

            // null 처리 (모름 == null)
            if (userToilet.getUserMaleToilet() == null || "U".equals(userToilet.getUserMaleToilet())) {
                pstmt.setNull(3, Types.CHAR);
            } else {
                pstmt.setString(3, userToilet.getUserMaleToilet());
            }

            if (userToilet.getUserFemaleToilet() == null || "U".equals(userToilet.getUserFemaleToilet())) {
                pstmt.setNull(4, Types.CHAR);
            } else {
                pstmt.setString(4, userToilet.getUserFemaleToilet());
            }

            if (userToilet.getUserMaleDisabledToilet() == null || "U".equals(userToilet.getUserMaleDisabledToilet())) {
                pstmt.setNull(5, Types.CHAR);
            } else {
                pstmt.setString(5, userToilet.getUserMaleDisabledToilet());
            }

            if (userToilet.getUserFemaleDisabledToilet() == null || "U".equals(userToilet.getUserFemaleDisabledToilet())) {
                pstmt.setNull(6, Types.CHAR);
            } else {
                pstmt.setString(6, userToilet.getUserFemaleDisabledToilet());
            }

            if (userToilet.getUserHasDiaperTable() == null || "U".equals(userToilet.getUserHasDiaperTable())) {
                pstmt.setNull(7, Types.CHAR);
            } else {
                pstmt.setString(7, userToilet.getUserHasDiaperTable());
            }

            if (userToilet.getUserHasEmergencyBell() == null || "U".equals(userToilet.getUserHasEmergencyBell())) {
                pstmt.setNull(8, Types.CHAR);
            } else {
                pstmt.setString(8, userToilet.getUserHasEmergencyBell());
            }

            if (userToilet.getUserHasCctv() == null || "U".equals(userToilet.getUserHasCctv())) {
                pstmt.setNull(9, Types.CHAR);
            } else {
                pstmt.setString(9, userToilet.getUserHasCctv());
            }

            pstmt.setString(10, userToilet.getUserDescription());
            pstmt.setDouble(11, userToilet.getUserLat());
            pstmt.setDouble(12, userToilet.getUserLng());
            pstmt.setString(13, userToilet.getPhotoUrl());

            int result = pstmt.executeUpdate();

            if (result > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    newId = rs.getInt(1);
                    System.out.println("생성된 화장실 ID: " + newId);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionProvider.close(conn, pstmt, rs);
        }
        return newId;
    } 
 
    
    public int findToiletID(String toiletName) {
    	int id = 0;
    	String name = toiletName;
    	String SQL = "select user_toilet_id from user_toilets where user_name =?";
    	
    	try {
    		Connection conn = ConnectionProvider.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, name);
    		
    		ResultSet rs = pstmt.executeQuery();
    		if(rs.next()) {
    			id = rs.getInt(1);
    		}
    		
    		System.out.println(id);
    		ConnectionProvider.close(conn, pstmt, rs);
    		
    		
    	}catch (Exception e){
    		 e.printStackTrace();
    	}
    	
    	return id;    	
    }
    
}